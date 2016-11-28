---
layout: "post"
title: "Thoughts on distributed teams & outsourcing"
date: "2016-11-28"
categories: web
published: true
author: Jim Burger
tags:
- Project Managment
- Outsourcing
- Observations
---

> TLDR; I learned that outsourcing small tasks to complement your teams skills can work really, really well, and that it can cause good growth within your own team at the same time. There are some challenges though, and its not all roses...

## Delivery as a skill

> Software is only a small part of the delivery 

Something new for me over the last 6 months has been to take part in the selection and management of distributed, outsourced talent being involved in our development process. It has become fashionable to beat up on outsourcing of late, so I met this task with a level of skepticism while keen to find some truth out for myself.

The reason for going down this road was that we tried to 'in house' some work, on a foreign technology stack (to us) - and it took more than double the time we expected it to, even when dishing out kid gloves. Not great, especially since this was not our core business, but still vital for our product to be viable in the market. _Time to market_ is also a big problem, so we needed deliverables fast.

The hold up wasn't so much as software, as it was wrestling with operating systems and platforms that none of us had used in anger before. And then there is the danger of [not knowing what you don't know.](https://en.wikipedia.org/wiki/Experience)

This re-iterated a lesson I have seen play out over several jobs now - that software is only a small part of the delivery skill. 

## Infrastructure will need to scale to meet distributed demands

After spending a significant amount of energy ensuring we had _some_ ducks, and that they _resembled_ a row, we proceeded to use a popular online talent recruitment service to quickly find developers from all over the globe that had a particular background useful for our project.

![ducks in a row...kinda](/assets/ducks-row.png)

Since our department had tales of previously failed outsourcing attempts, we had to tread carefully lest we be the subject of the dreaded 'I told you so' and the inevitable cries of 'outsourcing never works, and cannot work and you are bad for even thinking that it could'. That said, we received excellent management support for what we were undertaking.

> Things were blissful until...
 
We expected to be spinning up small contracts as fast as some people spin up VMs, so one of those ducks was setting up templates that contained  measurable goals and documentation of our backend services - to save time re-explaining ourselves.

Things were blissful until an internal team member wanted to deploy to our testing sandbox and we realized we had some new people to worry about.

![Our duck was cooked](/assets/cooked-duck.png)

So this pain encouraged us to further automate our build pipeline such that subsequent test environments could be created to keep up with in increase in demand for testing (thankyou again, Octopus Deploy). It made us rethink our versioning and branch policies. A whole lot of growth came from the simple realization that people outside the building were depending on us to get those things right. A customer will push you to better UX, but an API consumer will push your documentation quality.

## Benefits

- We saw two concurrent deliveries in times well under previous 'in house' velocity, at a fraction of the cost AND our local talent could focus on business value that they were already comfortable delivering. Massive spike in productivity.
- It forced us to write good documentation, and to treat it as part of the delivery. Every time a third party saw difficulties they would help us improve this asset. 
- Our team now has some baselines for this type of development if they need to do this in a pinch
- We have established relationships with experts in their fields and learned a lot along the way.

## Drawbacks

- You may find yourself on slack/gitter at odd hours thanks to timezone differences
- TZ differences can really show up bottlenecks in your team / process
- You may find new sources of distraction from your main tasks - especially if your process has flaws
- Expect to do lots of vetting. Put up a good size piece of work and the whole site will crawl all over it. 
- You can overdo outsourcing. [Don't outsource your brain.](https://blackpepper.co.uk/blog/dont-outsource-your-brain)
- You will need to be culturally aware, or at least aware that all people communicate discomfort/uncertainty in different ways when faced with authoritarian figures. School up on these subleties if you want to succeed. [EXCELLENT dissection of the impact of PDI on your management of outsourced talent](http://www.lessonsoffailure.com/developers/real-reason-outsourcing-fails/) - I believe this phenomenon is more prevalent that the article suggests and certainly isn't limited to countries IMO.

## Observations

- Use the right talent for the job. Choose carefully
- I can't overstate the need for role, goal and task clarity in this environment. This type of approach will fail with wishy washy desirements. Be clear and specific and make sure that those requirements align with your business' goals.
- Allow those you've hired to estimate the work and allow them that time to complete. For one thing it is a sign of simple respect, but also, you are getting help at a great rate, so no need to squeeze this unless people stop meeting their own targets.
- Use a project management service that allows for setting up payment milestones. Very useful to ensure quality and that everybody is happy to continue. Use those milestones to keep track of progress.
- Do homework on the applicants, in terms of their overall statistics for delivery as provided by the project management platform. It took us a while to find an applicant who was interested at the right price, but had a demonstrated 'habit of delivery on time'. However, some skepticism is required when selecting, as the systems in place appear to be easily flaunted, given enough time and energy - something a bored developer may well possess.
- Staying on top of comms takes on new dimensions, as its easy for either side of the equation to go dark, so appointing somebody responsible for contractor communications, who is on your development team is recommended. 
- You cannot over communicate.
- You'll want to ensure you have infrastructure & policies set up such that externals can safely and securely step in and out of work with your organization. Before you get hiring :)
- The people who live from these headhunting sites are real, talented people, who a very hungry for work. Moral of that story, is don't get complacent in a cushy coding job - either become [hyperproductive](http://blog.aha.io/5-tips-of-hyper-productive-developers/) or start learning skills your business industry won't/can't outsource.
- There is something very satisfying seeing another team of developers whom you've never met, deliver quickly based on the quality of code and documentation you've already provided.









