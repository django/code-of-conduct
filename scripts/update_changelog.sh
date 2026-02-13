#!/usr/bin/env bash
set -euo pipefail

changelog_path="CHANGELOG.md"
mode="incremental"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --backfill)
      mode="backfill"
      shift
      ;;
    --changelog)
      changelog_path="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 1
      ;;
  esac
done

if [[ ! -f "${changelog_path}" ]]; then
  echo "Changelog not found at ${changelog_path}" >&2
  exit 1
fi

have_jq=0
if command -v jq >/dev/null 2>&1; then
  have_jq=1
fi

get_pr_title_from_api() {
  local sha="$1"

  if [[ -z "${GITHUB_TOKEN:-}" || -z "${GITHUB_REPOSITORY:-}" ]]; then
    return 0
  fi

  if [[ ${have_jq} -ne 1 ]]; then
    return 0
  fi

  curl -sS \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/${GITHUB_REPOSITORY}/commits/${sha}/pulls" | \
    jq -r '.[0].title // empty'
}

get_pr_title_from_body() {
  local sha="$1"
  git log -1 --pretty=format:%b "${sha}" | awk 'NF { print; exit }'
}

trim_line() {
  sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
}

get_subject() {
  local sha="$1"
  local subject

  subject="$(get_pr_title_from_api "${sha}" | trim_line)"
  if [[ -z "${subject}" ]]; then
    subject="$(get_pr_title_from_body "${sha}" | trim_line)"
  fi
  if [[ -z "${subject}" ]]; then
    subject="$(git log -1 --pretty=format:%s "${sha}")"
  fi

  printf '%s' "${subject}"
}

generate_entries_from_range() {
  local range="$1"

  git log "${range}" --no-merges --pretty=format:%s | \
    grep -v '^Update changelog$' | \
    trim_line | \
    awk 'NF' | \
    awk '!seen[$0]++'
}

incremental_update() {
  local last_changelog_commit
  local entries
  local date_str
  local subject
  local new_block
  local filtered_entries
  local placeholder_pattern

  last_changelog_commit="$(git log -1 --format=%H -- "${changelog_path}" || true)"
  if [[ -z "${last_changelog_commit}" ]]; then
    last_changelog_commit="$(git rev-list --max-parents=0 HEAD)"
  fi

  subject="$(get_subject "${GITHUB_SHA:-HEAD}")"
  entries="$(generate_entries_from_range "${last_changelog_commit}..HEAD")"
  filtered_entries="$(printf '%s\n' "${entries}" | awk -v subj="${subject}" '$0 != subj')"
  entries="${filtered_entries}"

  if [[ -z "${entries}" ]]; then
    echo "No new commits to add to the changelog."
    exit 0
  fi

  date_str="$(date -u +%Y-%m-%d)"
  new_block="## ${date_str}: ${subject}\n\n"
  if [[ -n "${entries}" ]]; then
    while IFS= read -r line; do
      new_block+="- ${line}\n"
    done <<< "${entries}"
    new_block+="\n"
  fi

  placeholder_pattern='^## XXXX-XX-XX(:|$)'
  if grep -Eq "${placeholder_pattern}" "${changelog_path}"; then
    awk -v block="${new_block}" '
      BEGIN { skip_next = 0 }
      /^## XXXX-XX-XX(:|)$/ {
        print block
        skip_next = 1
        next
      }
      skip_next == 1 {
        if ($0 ~ /^_Brief description of changes_$/) { next }
        skip_next = 0
      }
      { print }
    ' "${changelog_path}" > "${changelog_path}.tmp"
  else
    awk -v block="${new_block}" '
      BEGIN { inserted = 0 }
      /^$/ && inserted == 0 {
        print
        print block
        inserted = 1
        next
      }
      { print }
      END { if (inserted == 0) print block }
    ' "${changelog_path}" > "${changelog_path}.tmp"
  fi

  mv "${changelog_path}.tmp" "${changelog_path}"
}

backfill_update() {
  local header
  local shas
  local sha
  local date_str
  local subject
  local entries
  local parent_count
  local range
  local filtered_entries

  header="$(awk '
    BEGIN { in_header = 1 }
    /^## / { exit }
    { print }
  ' "${changelog_path}")"

  shas="$(git log --merges --pretty=format:%H)"
  if [[ -z "${shas}" ]]; then
    shas="$(git log --pretty=format:%H)"
  fi

  {
    printf '%s\n' "${header}"
    if [[ -n "${header}" && "${header}" != *$'\n' ]]; then
      printf '\n'
    fi

    while IFS= read -r sha; do
      date_str="$(git log -1 --pretty=format:%ad --date=format:%Y-%m-%d "${sha}")"
      subject="$(get_subject "${sha}")"
      parent_count="$(git rev-list --parents -n 1 "${sha}" | wc -w | tr -d ' ')"
      if [[ ${parent_count} -ge 3 ]]; then
        range="${sha}^1..${sha}^2"
      elif [[ ${parent_count} -eq 2 ]]; then
        range="${sha}^..${sha}"
      else
        range="${sha}"
      fi

      entries="$(generate_entries_from_range "${range}")"
      filtered_entries="$(printf '%s\n' "${entries}" | awk -v subj="${subject}" '$0 != subj')"
      entries="${filtered_entries}"

      printf '## %s: %s\n\n' "${date_str}" "${subject}"
      if [[ -n "${entries}" ]]; then
        while IFS= read -r line; do
          printf -- '- %s\n' "${line}"
        done <<< "${entries}"
        printf '\n'
      fi
    done <<< "${shas}"
  } > "${changelog_path}.tmp"

  mv "${changelog_path}.tmp" "${changelog_path}"
}

if [[ "${mode}" == "backfill" ]]; then
  backfill_update
else
  incremental_update
fi
