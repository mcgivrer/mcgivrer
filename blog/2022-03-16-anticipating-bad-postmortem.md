---
title: Anticipating bad postmortem
author: Frédéric Delorme
date: 16-MAR-2022
description: a short storues oriented pseudo postmortem to illustrates bad infrastrcuture and design anticipation.
tag: 
  - story
  - infra
  - architecture
  - postmortem
  - good practices
---

# Anticipating bad postmortem

## 2 words of Introduction

When we try to build project or product, the better you serve your customer, the better you are.

But we often talk product features, and rarely platform or infra for those products. 

Here we talk about dark NFRs, the naughty and frightening Non Functional Request, the things thqt any product people hate discussing about, and often don't know what to add to this category.

And sometimes NFRs are about data size, stogare, legal, regulation, UX etc...

Here is an exercise to try and anticipate some of the bottlenecks and potholes where not to go or fall in.

## Story of a project


let's dive into an Lean/Agile/Scrum/Kanban way of life :


```text
 _ Agile loop (until product's end of life)
| ==== product feature grow ================
|   _ Epic Loop
|  |   _ Sprints Loop
|  |  | 1. capture the (user/customer) needs
|  |  | 2. design and write the functional requirement
|  |  | 3. develop code and document the implementation
|  |  | 4. test the produce artefacts
|  |  | 5. deliver to prod 
|  |  |_ end of Sprints loop
| ==== Parallel activities (other teams) ===
|  |   _ if at least 1 Release exists
|  |  | 6. hope and pray :)
|  |  | 7. start (user/customer) support 
|  |  | 8. hope :)
|  |  | 9. feed epic/sprint with maintainance feedback 
|  |  |_ end
|  |_ end of Epic Loop
|      10. pray and offer gift to production gods  :)
| =========================================
|_ end of Agile loop
```

Ok, we all know how to build a project and deliver a product.

BUT 

- Do we really know how to tackle or reduce support issues or when prod goes wrong ?
- Do we really manage the impact or links between Data size and production issue ?  
- Are we conscious that a bad design can imply BAD (or worst) performance (ever seen on the planet) ? 

THIS is where NFRs are REALLY important and MANDATORY !

Yes, I know, I open already opened doors, but do we know at best the door's handle usage ?

> _**Never Forget**<br/>_
> _NFRs are the handle **design guide** to not let the door all the time open to avoid issue with door hinges :)

## Let's illustrate the purpose !

### Story 1 - when an impatient user triple click

#### What the user/customer do

Story of the user who click the third time on the "OK" button becsaue nothing change visually, and then  trigger the save operation on background side, so 3 times, and produces 3 records of the same data just with 1 second (sometime less than 1s) difference in the stored event date :)
and seeing nothing change, click 10 more time on the OK button. and finally driving the UI to the famous "_Error 500_" :)

#### Analysis

The user , after a long serie of inputs in the form, press the salvator "OK" button thinking all is ok.

but at save time, a lot of processing is needed to verify user input and cross-check with mutliple interacting system through web-services or event exchanges.

And nothing happened on the UI, telling the user the processing can take some time, and he can have a coffee break :)


#### What has not been done

- Nobody ask about global application performance for the user side:
    - how long can take a page to refresh ?
    - how to notify the user about back-end processing ?
    - modal or not for the window and user dialog ? (even if miodel is cleary not the standard now)
- Is there a UI visual color code for good and bad operation ?
- Does the UI and processing won't be split into sub-steps to provide a better ans siple user experience ?


#### NFRs can be

- at **UX Design** => Propose an UX efficient design to prevent triple click : 
    - notify user about current operation (don't let the user/customer in darkness) on the front end side, 
    - unactivate the 'OK' button until the background proccess ending.
    - propose a "wizard step-by-step" UX approach for features needing a bunch of data and long processing time. 

> **TIPS**<br/>
> If nothing exists at UX Guide lines, it would be a good point to write ones, and better, integrate such default behavior in the UI Component/framework you are using to develop.

- at **Architecture design level** => Propose a secure way to prevent this happened on the backend side
    - using unique id in transaction,
    - applying atomique operation principle between front and back end
    - use event based processing with a clear identified nature and id to insure uniqueness of operation.
    - provide processing monitoring to feed the user with valuable visual status information on  the current involved processing.
    - And in term of infra, be ready to monitor processing and performance to trigger alert for audit purpose, later helping support team to provide good explaination to the insatisfied user/customer.

- And if none of these solution are possible, build-up an continuously evolving "Issue's Knowledge base" for Support team, to help them analyse and answer user/customer request. 
- Build-up analytics on the monitoring data to extract most occuring issues to be able to provide a report to product people, to decice what MUST be prioritised as next release NFR's, or at least bug.
- And looping with Architect team is a also good point to define and raise best practices in term of applciation design (UX/Arch/infra etc...)

### Story 2 - when the designer really don't know that size matter

#### An enterprise starts a product adventure

A great new product, cloud oriented, has just been released and a bunch of customers/users are happy to ruch on it and take benefits of your fantastic bunch of fancy features.

The first 6 monthes are amazing, from 10 to 20000 customers/users is a very good scaling up in term of business.

The application serves happy and satisfied users, based on the "Pay per use" business model, this was a great idea.

8 months later, with the number of new users/customers the hosting cost explosed and even if new comers add their cents to the CA, the costs continues to raise up, until the costs goes over the benefits. 
Wihtout any chance to go back to a more smooth and handled balance.

#### Analysis

Starting the application at first public open release, everything sounds good, and user /customer are onboarding with success.

One of the proposed service cost a lot of storage space; not customer oriented data, but one of the features needs temporary space to run.
And unfortunately, this space is not monitored in a different manner that user oriented data.

So, as a CEO, having the hosting data store growing according the number of user seems to be accurate. A direct link between number of user and data storage is a reality.

The hosting service proposes some different level of usage and cost depending on level of data store usage.

During the 6 first monthes, nothing special happended, and no alert.

The 8th months application anniversary celebrates the first outstanding data storage cost, directly linked to the famous "temporary storage" usage we discussed before.

Cost raise against the benefits.

Stakeholders and Investor reclaim for their parts, and, by the way, urge at the due benefits in the company.

Because of tremendous data storage, some question raised about data nature: privacy and security administration people come to ask about usage and needs regarding regulation...

And...

End of story.

#### NFR's can be

- at **Product level** what are the unbreakable needs to cover in term of user data, or technical (meta) data ? 
    - If you want to provide a contextuyal search engine on document oriented service, be sure to take in account the cost of "user invisible data" used to index the user data (metadata)
    - Does some features need complex and data space consuming processing ? if yes, this MUST BE one of the clear NFRs
    - If you are cloud oriented, in a constantly evolving world, the cost fees for service usage is terribly volatile.  having the good practce to be provider agnostic MUST be an NFRS at Start. 
    - 
  > **TIPS** <br/>Because switching infra after prod is a project killer, anticipate it and provide provider agnostic solution.

- at **Design level** when thinking about implentation:
    - Clearly identify **user data** and **system/technical data**, split them interm of storage to be able to adapt thinely regarding storage usage,
    - You must ansmwer to the following questions :
        1. Does all the data you are keeping alive and store are needed ?
        2. Does it match with your product purposes ?
    - Be sure about **Security** requirement at country level, regarding criticity of **data privacy** and data usage.  keeping stick to current regulation at start will keep you far from "financial penalties"
    - Monitoring infrastructure and data consumption, and having dedicated people or team to report any triggered alert are mandatory, Building up an "issue management plan" to tackle problem as soon as possible will help.


> **TIPS**<br/>
> This can be the story of a Start-up, but even **big group** with _no software experience_ can suffer in the same way, and are not well prepared to manage such discrepencies.

#### What has not been done

When the design of the product occured, 
- nobody ask for data size and how the evolution of that size will behave in short, mid and long term. 
- Is there some needs about data rentention ?
- Why keeping all the data, is there a retention requirement ?
- what is the archivage policy (is there one ?)
- Is there some platform or infra monitriong inplace , ready to detect and anticipate problem ?
- is there in the support team, some dedicated people to monitor those data ?
- is there a Plan B to manage such situation ?


## Epilogue


In term of Design the direct link with support issues is clearly established.  You may go fast to the market, but even if you are in an agile world, bad design and a not well prepared team may drives you to bankroute.

Scalability is not the one and only solution to customers flow, you must evaluate future data consumption and linked cost usage. Maybe having a way to switch or share hosting between mutiple providers, for cost, but also for sustainability of the solution. 

If you think about mutiple providers for your hosting services, do you integrate this NFR in your roadmap to support switching, and beeing agnostic regarding one of the feature proposed by a host provider ?

Think directly out of the box when its about Design,  Infrastructure and Platform: keep solution opened,  provides connectors and interface to services in term of architecture, and listen to your customer's errance and feedback, in term of product, to feed your backlog!

Even if Product is evolving fast, changing the behind the scene infrastructure can ruin your product effort in term of cost !

> **Good Practices**<br/>
> So having a good knowledge of the Non Functional Requirement in term of Data, performance, storage, usage, desgin are MANDATORY, and must be take in account AS SOON AS you start your product journey.
> 
> - Keeping a living NFR's list with clearly identified items, communicated to ALL the teams is a very good practice.
> - NFR's product oriented (design etc...) can be kept at product level
> - NFR's infra /storage/security oriented must be shared between all the stakeholders of this infra.


Anyway, this are just fictional examples from some real life experiences and a lot more to surprise you during your own software adventures. Stay open (like your architecture), aware and ready (like your product team) and build solid and a useful application !



Happy product coding !

Frédéric Delorme.
