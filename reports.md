:point_left: [Come back to index](README.md)

# Django Code of Conduct

## Report handling procedure

This document aims to present the way we handle received reports. This is not a complete guide, but a set of guidelines or best practices that guide the way we provide support to the community. Each issue is different and requires individual consideration on a case-to-case basis.

### Types of received reports

In general, almost all reports we receive can be categorized into two groups:

- **reported by local representatives** - issues that were usually already handled by organizers or curators of communities like Django conferences, meetups or online spaces like IRC and subreddits. In those situations, we either acknowledge the report if it was already resolved and keep it in our central log, or provide support and advice, or enforce Code of Conduct if needed.
- **reported by people who need our help** - those reports usually require our decision and enforcement of the Code of Conduct.

### How we receive reports

All reports received by us are usually sent to [conduct@djangoproject.com](mailto:conduct@djangoproject.com) email address that is automatically forwarded to each member of the committee.

We're looking into more ways to make it as easy for people as possible to report an issue. Feedback on that matter would be throughly appreciated.

### On-call duty

In order to achieve a fast response time to received reports, we implement a week long on-call duty that is rotated between members of the Code of Conduct Committee. Every week we assign one member to be the primary person on duty, and another member to be a secondary supporter. On-call duty ends and finishes every Monday at noon UTC, when a reminder is sent to conduct@djangoproject.com with information who is the next primary and secondary member on-duty following week. The schedule is managed via a [spreadsheet]. If a member won't be available on given week, they should exchange their week with another member.

![spreadsheet](https://docs.google.com/a/sitarska.com/uc?authuser=0&id=0B_sMcBckSgWqX1p5cm50UmQ1VVk)

**Primary person on duty** is responsible for providing the initial response to a reporter, ideally within half a day. They're also responsible for either shepherding the received issue, or finding another member of the committee who will commit to shepherding it.

**Secondary person on duty** inherits the responsibilities of the primary person if they're not available.

If all else fails, any member of the committee can step in and pick up an issue if they see that response hasn't been provided within a first day.

### Initial response

We aim to provide the initial response and acknowledgement of the received report ideally within couple of hours, or half a day. The conduct@djangoproject.com address should be copied on all communications.

If the response requires a decision, we should send an acknowledgement of the report to make sure the report is informed we're working on it, and not ignoring it:

> Hi X,

> Thank you so much for reporting this issue to the Django Code of Conduct Committee. I appreciate you taking the time to get in touch - reports like this help us to make Django a  better community.

> We'll discuss and get back to you with the outcome, and will keep this report on file. Meanwhile, if there is anything else we can do to help or support you, please do let us know.

> Regards,
> [First Last name]
> DSF Code of Conduct Committee

If the received report clearly states that the action has been taken already, and the issue is only reported to be kept on file in our central log, the committee can close the issue by sending a simple acknowledgement:

> Hi [X],

> Thank you so much for reporting this issue to the Django Code of Conduct Committee. I appreciate you taking the time to get in touch - reports like this help us to make Django a  better community. The action you've taken so far seems appropriate, and I'd like to thank you for handling the issue with care.

> We're going to keep this report on file to look for patterns in the future across the community. If there is anything else we can do to help or support you, please do let us know.

> Thank you again!

> Regards,
> [First Last name]
> DSF Code of Conduct Committee

The first responder should also add a [record of the report](records.md) in our files.

### Resolving the report

We aim to resolve any report received within a week.

#### Assign a shepherd

In order to resolve reports timely and efficiently, we use "shepherding", a practice of assigning a member of the committee to "own" an issue from the initial report until it is resolved. The shepherd does not have to be the person who is on duty that week. A member can suggest themselves as a shepherd for an issue, but must take into consideration:

- **Biases** - If the shepherd has any bias towards the issue (such as knowing the people involved in the issue), then the shepherd should make these biases known to the rest of the committee immediately. Whether or not the bias may affect the outcome of the issue should be discussed by the committee, and a new shepherd should be picked if this is the case.

- **Time** - Handling issues is very important, the shepherd should be aware that resolving the issue is a high priority. It is the responsibility of the shepherd to see that each stage of the process is acted upon in a timely manner, and any delays be addressed. If the shepherd is busy for reasons outside of the committee, they need to alert the rest of the committee of this. If there is a delay during the process due to some external reason, it is the responsibility of the shepherd to alert the committee of this delay.

When a shepherd is assigned, if it is different to the initial responder, the initial responder should send an update:

> Dear [X],

> I'm writing regarding your recent report to the Django Code of Conduct Committee. I wanted to let you know that we have assigned the case to [Y], who will be your main point of contact going forward. [Y]'s email address is [Y@djangoproject.com]. If you have any questions or concerns with this, please let me know.

> Regards,
> [First Last name]
> DSF Code of Conduct Committee

Assuming no questions or concerns, this is marks the completion of the initial responder's responsibilities for this case. If the reporter does have concerns or questions, the first responder should ask the committee to resolve these.

#### Decision-making process

The process with which decisions are made differ slightly between issues, due to the fact that each issue is slightly different. However, there is a loosely defined set of stages that are present in each issue.

- **Shepherd nomination** - The committee decides on a shepherd for the issue.
- **Contacting the reporter** - The shepherd should contact the report letting them know they are the point of contact between the reporter and the committee, and will be available for the reporter if they have any questions. Based on the initial report, the shepherd may choose to ask for more information about the report at this time.
- **Initial discussion** - The committee conducts a discussion into the report in order to understand the issue. During this time, the committee should aim to decide the severity of the issue and the appropriate next steps. This could be:

    - Contacting the reporter for additional information.
    - Researching the issue if there is additional evidence online or in written form.
    - Contacting additional persons involved in the report.
    - Contacting any official bodies (such as the Django Software Foundation or Python Software Foundation) if the committee feels they can provide extra information.
    - Seeking legal advice.

    Regardless of the actual steps taken at this stage, the aim is the gather a clear understanding of the issue, what occurred, who is involved, and what is the severity of the issue.

- **Deciding actions** - Based on the evidence, the shepherd should propose to the committee the actions that should be taken to resolve the issue. The shepherd requires at least two members of the committee to agree on these actions. If the issue is very severe or requires legal action, it is advised that a majority of the committee agree to the actions before they're taken. The [enforcement manual](https://www.djangoproject.com/conduct/enforcement-manual/) provides details on the various actions that issues can result in. This is not a complete set of options, as each issue is different, different actions are likely.

### After decisions are made

Once the committee has made its decision, the following takes place:

 - **Carrying out actions** - The shepherd performs or delegates the actions agreed upon by the committee, the first of which should be to inform the reporter of the decision made by the committee. The actions can sometimes involve contacting individuals involved in the issue. For these actions, we recommend the shepherd write a draft and share it with the committee before it is sent to the individual in order to check that necessary information is conveyed clearly and objectively.

	- **Ongoing actions** - As a result of conducting the actions, the issue may not resolve straight away. Based on further developments, the shepherd should continue to share the developments and work with the committee to decide on the actions that need to be taken in response.

- **Resolving** - Once the actions are implemented and the issue feels resolved, it is the responsibility of the shepherd to:
   * contact the reporter about the final resolution, and that the committee considers the case closed until new information comes to light.
   * inform the committee that the issue is considered resolved
   * update the reports file with a summary of:
	 * actions taken
	 * outcome
	 * review date

  The reports file is kept for reference, is reviewed from time to time, and is consulted regularly to compile statistics.

----

[Go to next chapter: Record-keeping](records.md) :point_right:
