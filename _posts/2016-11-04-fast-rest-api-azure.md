---
layout: "post"
title: "Fast & Furious API Delivery"
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
## Shipping is a feature

Im not going to pretend this is good advice. We all know there are right ways to build high quality APIs and there are wrong ways.

But sometimes you dont care about quality. Mock services for testing, POCs and sales demos. Sometimes shipping is the feature. You know it will bite you later. Hopefully this article might buy you time (or money) for better solutions down the track.

Not every job has to take a team of 10 developers 3 months and a team building trip to the local adventure park. So here's 3 fast, pragmatic ways to just get data into your application from an API of some description - just add JSON.

- Swagger Editor
- Firebase
- Azure API Management

### 1. Swagger Editor - great for quick and dirty code to run

[Swagger editor](http://swagger.io/swagger-editor/) allows you to edit a swagger definition file in convenient editor, and then auto-generate a server or a client application in a variety of languages. Its best feature is that it is hosted on github. 

- Seriously, try the demo - it will yield a working code sample for you to look at.
- You have complete control, clone this repo and add your own generators.

#### How to use swagger editor

1. Define your schema in YML 
2. Choose a language 
3. Download a working boilerplate for server and or client
4. Profit

*Price:* Free
*Good:* just design, download & run.
*Not so good:* your on your own when it comes to hosting. This is just a starter kit for a deployable REST API.

![swagger editor](/assets/swagger-editor.png)

### 2. Firebase - cross media database and storage

If you already have a website or mobile phone mockup that is devoid of data, and want to hydrate it with something you could lean on for a while, [firebase is worth a look](https://firebase.google.com). Heck, it might even be enough for production.

- Realtime data events
- SaaS solution
- Good selection of authentication providers
- Easy to configure authorisation
- Assumes you have an app to host data from
- You can run a local server using the firebase CLI

This tool has a lot of features, but you can create something useful in minutes.

#### How to use Firebase

1. Choose an authentication strategy:

![Firebase Authentication Choices](/assets/fb-auth-choices.png)

2. Design your data as JSON in your favourite editor and then import it into firebase.

![cheeses.json](/assets/cheeses-json.png)
![Firebase imported data](/assets/fb-data.png)

3. Use the code snippets and add them into your application.

![Firebase web snippet](/assets/fb-add-web.png)

[Full guide here](https://firebase.google.com/docs/web/setup)

Once boostrapped, you can do all the things you'd expect, simple snapshot reads, to realtime event stream subscriptions. Here's a basic example

```javascript
 firebase
  		.database()
  		.ref('/Cheeses/')
  		.once('value')
  		.then(function(snapshot) {
 			var cheeses = snapshot.val();
				console.log(cheeses);
		});
```
[Reading and writing in firebase](https://firebase.google.com/docs/database/web/read-and-write)

*Price:* Free to start, paid plans start at $25 per month*
*Good:* extremely easy to use. Fast provisioning
*Not so good:* features seem geared towards mobile applications, primarily Android. Limited feature set.

### 3. Azure API Management - 

The big daddy: this service is currently in preview but already has an impressive array of features. It looks to be geared towards quickly serving up a suite of APIs for your organisation. 


You may not need all of its community oriented features initially, but if you've put your POC in front of the right people, who knows?

- Manage API consumer usage restrictions
- Can import swagger.json files
- Web UI for managing Operations
- Autogenned documentation and test runner for you API (similar to swagger UI)
- Rate limiting
- In built caching options
- Customizable portal for your API consumers
- SOAP / WSDL support

1. Goto the publisher portal and import your API definition file (accepts swagger or WSDL files). 

![Import your swagger definition](/assets/aam-import-swagger.png)

2. Adjust various settings in the publisher portal to your liking
3. You can even add new operation via the user interface.

![Add an operation](/assets/aam-add-operation.png)


[Azure API Management Documentation](https://docs.microsoft.com/en-us/azure/api-management/api-management-key-concepts)


*Price:* Currently starts at $50 per month
*Good:* Loads of features
*Not so good:* Bigger learning curve, takes a while to provision, its up to you to create a client side API and datasources.









