---
layout: "post"
title: "Fast REST API Development: Azure API Management"
date: "2016-11-04"
categories: web
published: false
author: Jim Burger
tags:
- REST
- Azure
- Swagger
- dotnetcore
---
## Recipe: REST API in 30 minutes
This basic recipe aims to get you from 0 to REST in under 30 minutes. By the end of this blog post, assuming you follow along, you should be staring at the following achievements:

- A cheap REST .NET based service deployed to Azure
- OAuth authentication against one of the major OAuth providers
- A git repo for maintaining the source code
- A simple continuous delivery pipeline triggered by your commits

## I'm new to development, so I'm not sure what some of those things mean
I'm making some assumptions about the readers skill level here:
1. You're OK with reading and writing code in a popular systems programming language, but perhaps haven't written a REST service before
2. JSON is not [just] the name of some guy you used to work with. 
3. You can operate git and github
4. You're comfortable with scripting to automate things

If this doesn't describe you very well, but you'd like to continue, you may struggle - but if you do your homework, this shouldn't be too hard really.

## Ingredients:
- An [Azure](https://windowsazure.com) or [AWS](https://aws.amazon.com/) account
- A [Github](https://github.com) account
- A [Wercker](https://wercker.com) account (or equivalent)

## API's won't happen in a vacuum
Typically, you'll want to serve up some data - so having some datastore will help you follow this recipe such that something meaningful comes of it.

To that end, I'll be serving up some test data from a free firebase.com instance.





