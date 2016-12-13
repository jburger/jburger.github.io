---
layout: "post"
title: "Onions, Docker and Infrastructure Composition"
date: "2016-12-13"
categories: web
published: true
author: Jim Burger
tags:
- Docker
- Scaling
- docker-compose
---

### Contents

- [Docker is everywhere](#thing)
- [New Terms](#terms)
- [Differences to virtual machines](#differences)
- [Collaborative infrastructure](#collab)
- [Example: dotnet core running on linux](#dotnetcore)
- [Common commands](#commands)
- [Example: networking containers with compose](#compose)
- [Example: scaling out a service](#scale-out)
- [Scaling Teamwork](#scaling-teamwork)

<a name="docker"></a>
## Docker is everywhere

> I noticed the other day that Docker is now a first class citizen amongst the big three cloud providers.
> 
> - [Azure Container Service](https://azure.microsoft.com/en-us/services/container-service/)
> - [Amazon Container Service](https://aws.amazon.com/ecs/)
> - [Google Container Engine](https://cloud.google.com/container-engine/)
>
> [Windows server 2016](https://msdn.microsoft.com/en-us/virtualization/windowscontainers/quick_start/quick_start_windows_server) and [windows 10](https://msdn.microsoft.com/en-us/virtualization/windowscontainers/quick_start/quick_start_windows_10) both support [windows nano containers](https://channel9.msdn.com/Series/Nano-Server-Team) too! 

We use [Vagrant](https://www.vagrantup.com) at work for our development virtual machines a lot and I love their tool set. We have also started using docker for more complex scenarios development environments. I've also been using Docker for personal projects for a good year now.

Docker has some great features that set it apart from other virtualization technologies that I'll try to explain.

The following is brain dump of learnings I've picked up over the last 12 months of casual use.

Hopefully this article will help someone else navigate this area of knowledge. If you spot something that I have wrong, or is out of date, please let me know!

<a name="terms"></a>
## New Terms

There are some terms that didn't immediately make sense to me when I got started, and I've found that getting others over the terminology hump is required when introducing people to the tech. 

Docker has a great [glossary available here](https://docs.docker.com/engine/reference/glossary/) if you are interested in the formal definitions. 

*Not everyone likes reading glossaries... so here is my unofficial guide to Docker 'things'...*

![Docker image registries](/assets/docker-things.png)

Essentially, a registry holds a bunch of images from different publishers, who can store many images, which in turn have many different 'flavours' known as tags.

> A tag is version of an image that you'll use to create a running container. 
>
> Form: [publisher]/[image-name]:[tag]
>
> E.g microsoft/dotnet:1.0.1-runtime, rabbitmq:latest

_Note: if you omit the publisher, Docker will assume you mean its official set of images. If you omit the tag, it will assume you mean the latest_

## Containers are not virtual machines
<a name="differences"></a>
Containers are the running instances of an image/tag. These [are different to virtual machines](http://stackoverflow.com/a/16048358) in some ways, primarily in terms of security. 

> Unlike a virtual machine, an elevated application running in a docker container can access the underlying host.
>
> So treat your containers as you would a server application: _use least privilege as much as possible, and drop privilege when no longer required._

## Containers are onions
<a name="collab"></a>
![Proof of edible containers](https://seagreentelecaster.files.wordpress.com/2011/09/daffodilteacup21.jpg)

_Probably not as edible as this container_

Something that I think makes Docker easy to learn, is that it treats the problem of machine configuration as a series of layers, each adding a small amount of functionality required by its consumers and no more. Like an onion. Or a cake.

[Docker hub](https://hub.docker.com) is effectively a meeting place where people all over the world are collaboratively building 'fit for purpose' environments, layer by layer, rating their quality and following their progress. The built-in integration with Github allows consumers an avenue for contributing and lodging issues.

This means:
- We don't need to store a whole repository full of bash or powershell script files to reproduce an environment
- Resultant images *only have what is required for your software to run*
- Images are typically small enough to proliferate over the web. E.g. Microsoft's dotnet image is ~250MB compressed. The official debian base images start at around ~50MB. _No that is not a typo. Megabytes._ 
- Ability to build from commonly shared, 'known good' images, making the ecosystem **accessible, social and self-correcting.**

---

<a name="dotnetcore"></a>
## Talk is cheap, show me the code

For example, if I want to build a .net application and deploy it to a useful image, I can use [Microsoft's latest 'dotnet' image](https://hub.docker.com/r/microsoft/dotnet/) as a base to build my own: 

*First, I publish my app*

```bash
cd /path/to/project.json # soon to be csproj
dotnet publish -c Release
```

*Then I'll create an image definition file - or 'Dockerfile'*

```
# Use the official container
FROM Microsoft/dotnet:latest

# bring some binaries into this container 
COPY /path/to/published/binaries .

# optional - open up port 5000 to the host
EXPOSE 5000

# Tell this container to autorun my dotnet app on boot as PID 1
CMD dotnet run
```
That's it.

[Microsoft's Dockerfile](https://hub.docker.com/r/microsoft/dotnet/~/dockerfile/) has already done the dotnet installation for us, and is in turn based on another image for a popular linux distribution - [Debian version 8.x aka 'Jesse'](https://hub.docker.com/_/buildpack-deps/)

## Common commands
<a name="commands"></a>
We can now perform a bunch of operations on our new container, here's some of the more common ones.

To build this [image](https://docs.docker.com/engine/reference/glossary/#image), so that I can use it later, I invoke:

```bash
docker build /path/to/app --tag myimage:latest
```

If I have access to a Docker [repository](https://docs.docker.com/engine/reference/glossary/#repository) on a [registry](https://docs.docker.com/engine/reference/glossary/#registry) somewhere I can share it with:

```bash
docker push myimage:latest
```  

If I want to get an image from a registry I can pull it down

```bash
docker pull microsoft/dotnet:latest
```

Of course, I can stamp out as many [containers](https://docs.docker.com/engine/reference/glossary/#container) of this image as I like, and because the image is pretty small (~250MB), this **startup cost can often be in the milliseconds.**

```bash
docker run myimage:latest
```

## Networking is configuration too
<a name="compose"></a>
Networking in Docker is equally declarative, with its suite of other CLI tools that allow us to define things like port numbers and volume mappings, and to define dependencies between the containers themselves. 

For [a really oversimplified] example, consider a website, where notifications to users have been decoupled from the web application, and these two components need to communicate with each other, via a queue.

![system design](/assets/partytime-design.png)

While we can expose ports in Dockerfiles, we could also use [docker-compose](https://docs.docker.com/compose/overview/) (part of the docker toolbox) and feed it a configuration template in YAML:

_a docker-compose.yml configuration_

```yaml
# define some services
services:
  # our messaging backbone - called 'backbone'
  backbone:
      # use the standard rabbitmq image from docker hub
      image: rabbitmq
      hostname: localhost
      # set some resilience rules
      restart: always
      # and some environment variables from a file
      env_file:
        - backbone.env
  # an aspnet core website
  web:
    # ensure port connectivity to our backbone
    links: 
      - backbone
    # my own custom image, defined in that Dockerfile we made earlier 
    image: myapplication
    #maps port 5000 inside the container to port 5000 on the host
    ports:
      - "5000:5000"   
    env_file:
      - web.env
    # bring this up after the backbone is started  
    depends_on: 
        - backbone
  # a notification service      
  notifications:
    links: 
      - backbone
    image: partytime-notification
    env_file:
      - notifications.env
    depends_on: 
        - backbone
```

This whole environment is brought up with a single call to compose like this:

```bash
cd /path/to/docker-compose.yml
docker-compose up -d 
# -d starts these containers as background services, omit if you want to console log output 
```

Notice how I used labels for those services? We'll use these to start scaling out.

### Scaling services sideways
<a name="scale-out"></a>
Among many other features - docker-compose allows you to create more instances of your named services:

Let's imagine that marketing have just had a successful campaign to generate loads of interest and you are expecting a rush of registration notifications to get sent.

```bash
# scale out our notification service with 5 instances total
docker-compose scale notification=5
``` 

![too much scale](/assets/100-containers.gif)

_probably a few too many containers_

**Trap for new players** 
For instance, doing this to a service that maps port 5000 externally - will fail because new copies of the service will try to use a port that is already in use.

Unfortunately, docker-compose is not quite smart enough to handle this ([yet](https://github.com/docker/compose/issues/722)).

> **A word on the subject of controlling startup order** 
>
> _Oh the epiphany I had when I learned this lesson! Bittersweet moments :)_ 
> 
>
> 'The problem of waiting for a database (for example) to be ready is really just a subset of a larger problem of distributed systems. In production, your database could become unavailable or move hosts at any time. Your application needs to be resilient to these types of failures.'  
>
> [This advice right here](https://docs.docker.com/compose/startup-order/) 
>
> ^^
> **My tip: Substitute the word 'database' for anything you consider to be 'central' or 'cross cutting'**  

All you are bound by is the performance profile of the system you deploy this to, and as I hinted to above - you can host containers on cloud providers to give you scale **up** as well as **out**.

## Scaling teamwork

<a name="scaling-teamwork"></a>
As a parting thought, there is scope for not only scaling out and up, but scaling your team. Docker could be used as part of a microservices architecture to good effect, and done well, could yield some less tangible - yet equally profound gains.

So much [well](damianm.com/articles/human-benefits-of-a-microservice-architecture) [researched](https://en.wikipedia.org/wiki/Conway%27s_law) [content](https://blog.bufferapp.com/small-teams-why-startups-often-win-against-google-and-facebook-the-science-behind-why-smaller-teams-get-more-done) [exists](http://martinfowler.com/articles/microservices.html) on the subject of [team structure and its impact on your architecture](https://www.thoughtworks.com/radar/techniques/inverse-conway-maneuver). I've enjoyed reading these articles and have similar experience, I hope they inspire you to enact change in your team!

## In Summary

There is a huge body of knowledge forming around containerization and its applications. I'm very new to the ecosystem, even after a year of trying things out and making use of the more obvious parts. I'm keen to hear from others using Docker or other container technologies, so please share your experiences.

