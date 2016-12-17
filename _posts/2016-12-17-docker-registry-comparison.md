---
layout: "post"
title: "Private Docker Registries - Comparison"
date: "2016-12-17"
categories: web
published: true
author: Jim Burger
tags:
- docker
- azure
- amazon
- google
- devops
---

So you've decided to use containers. _It'll be fun they said._

Once committed to using a container service, an overhead becomes apparent: image storage. 

While not completely necessary for a small, localized team; a distributed team will likely want the convenience of access
over the Internet and fine grained access control. 

If you're going all in, you'll be after a large number of repositories too.

I've been assessing SaaS solutions, so I thought I'd write about a few different options I've come across.

- [Azure Container Registry (preview)](https://docs.microsoft.com/en-us/azure/container-registry/)
- [Google Container Registry](https://cloud.google.com/container-registry/)
- [Amazon EC2 Container Registry](https://aws.amazon.com/ecr/) 
- [Docker Hub](https://hub.docker.com)


## Comparison 
Each option has packaged up a registry server for you such that you don't need to manage the hardware side of things. **However they do differ on features, capacity and cost.**

### Pricing 

_NB: prices in US dollars, charge rates as at Dec 2016_

| Service | Storage Price | Egress Price |
|---------|---------------|-----------------|
| Azure   |$0.024 per GM/mo*|$0 (first 5GB/mo, $0.138 per Gb/mo upto 10TB )|
| Google  |$0.02 per GB/mo|$0.19 per GB/mo**|
|Amazon§|$0.1 per GB/mo| $0 < 1TB ($0.09 per GB < 10TB per month)|
|Docker†|$0 - $250 month||


<br />
As a scenario to compare the variably priced providers with, let's assume storage of 1TB and that much again each month in egress costs:
<br />
<br />

| Service | Storage | Egress | Total |
|---------|---------|--------|-------|
|Azure    |$24      |$138    |$162   | 
|Amazon   |$100     |$90     |$190   |
|Google   |$20      |$190    |$210   |


_This is a simplistic comparison, your own team will want to extrapolate their real world needs in a similar fashion_

### Why Docker Hub?
Docker Hub may appear expensive at the big end; if you anticipate usage of up to 250 repositories, you'll be paying $250 a month. 

**However it has some compelling features:**

- Vulnerability scanning
- Github integration (e.g git push triggers a build)
- Web front end to show readme files and tags etc.
- Fixed monthly cost

For most teams, Docker hub is an excellent fixed cost solution with the most comprehensive set of features. Plans range from $0 - $250 a month depending on how many repositories you need.

## Azure Container Service 

Since I work primarily with Microsoft tech, I'm drawn to a solution that integrates with Active Directory.

Also, the Azure CR seems to strike a **good balance on price of storage and bandwidth usage.**

### Integration with other Azure resources

Azure does align itself in terms of features fairly well with the AWS EC2 based solution, focusing on Microsoft stack integration:

- Azure Active Directory Integration
- Role based registry access
- Azure Container Service integration
- Visual Studio Team Services CI integration

As with other Azure resources it is [really easy to setup](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli)

![Setup a private container registry](/assets/ACS-create.gif)

_please use more sensible names than I did_

Before you push your first image - you need to grab your connection details from the portal

![Get your admin credentials for the service](/assets/acs-admin-user.png)

### Pushing up to your new private repository

**1.** With your credentials in tow, you can login to your registry with the docker CLI

> Azure Container Registry also integrates with Azure Active Directory service principals instead if so desired.

```bash
docker login fubar786123-on.azurecr.io -u fubar786123 -p xxxxxxx
```
This credential is then cached by docker, and can be refreshed either with the Azure CLI or on the Azure portal.

**2.** register the image on your registry - using a folder to keep things tidy
```bash
docker tag hello-world fubar786123-on.azurecr.io/samples/hello-world
```

**3.** now push it up for others to use
```bash
docker tag fubar786123-on.azurecr.io/samples/hello-world
```

><text>*</text> prices fall after first TB uploaded (based on East US price, not avail. in Australia region)
>
>** prices fall after first TB egressed (based on Australia price)
>
>§ First 500MB per month for the first year free
>
>† Depending on plan (max. 250 containers / builds)
