---
layout: "post"
title: "Fast & Furious REST APIs"
date: "2016-11-19"
categories: web
published: true
author: Jim Burger
tags:
- REST API
- Firebase
- Azure
- DocumentDB
- Swagger
---

## Shipping is a feature

![Fast and Furious](/assets/nissan-sx.jpg)

Not every application has to take a team of 10 developers 3 months and a team building trip to the local adventure park. Maybe its a throwaway thing. [Maybe its a prototype](/_posts/2009-10-01-throw-away-your-code.html). Maybe you're not sure how successful this will be. So with that in mind, here's 3 fast, pragmatic waysto just get data into your application from an API of some description. Each has their own cost model and feature set to consider, so choose your weapon!

- Swagger Editor
- Google Firebase
- Azure Document DB

### 1. Swagger Editor

[Swagger editor](http://swagger.io/swagger-editor/) allows you to edit a swagger definition file in convenient editor, and then auto-generate a server or a client application in a variety of languages. BYO hosting solution, so the cost is as cheap or as expensive as you want it to be.

- Seriously, try the demo - it will yield a working code sample for you to look at.
- You have complete control, clone this repo and add your own generators.

#### How to use swagger editor

1. Define your schema in YML 
2. Choose a language 
3. Download a working boilerplate for server and or client
4. Profit

||Breakdown|
|---|---|
|*Price*|Free|
|*Good*|Just design, download & run|
|*Not so good*|You're on your own when it comes to hosting. This is just a starter kit for a deployable REST API.|

![swagger editor](/assets/swagger-editor.png)

### 2. Google Firebase

If you already have a website or mobile phone mockup that is devoid of data, and want to hydrate it with something you could lean on for a while, [firebase is worth a look](https://firebase.google.com). Heck, it might even be enough for production, and you can scale this service up as required. 

- Realtime data events
- SaaS solution
- Good selection of authentication providers
- Easy to configure authorisation
- Assumes you have an app to host data from
- You can run a local server using the firebase CLI

This tool has a lot of features, but you can create something useful in minutes.

#### How to use Firebase

Choose an authentication strategy:

![Firebase Authentication Choices](/assets/fb-auth-choices.png)

Design your data as JSON in your favourite editor and then import it into firebase.

![cheeses.json](/assets/cheeses-json.png)
![Firebase imported data](/assets/fb-data.png)

Use the code snippets and add them into your application.

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

||Breakdown|
|---|---|
|*[Price](https://firebase.google.com/pricing/)*|Free to start, AUD$25 per month cap plan or PAYG|
|*Free Database Storage*|1GB stored, 10GB downloaded|
|*Good*|Extremely easy to use. Fast provisioning|
|*Not so good*|Features seem geared towards mobile applications, primarily Android. Limited feature set.|

### 3. Azure Document DB

[Microsoft's Azure Document DB](https://azure.microsoft.com/en-us/services/documentdb/) allows you to use their NoSQL database, or a hosted mongo DB instance to stand up some data - and then provides convenient javascript API access the data in your application. 

- Fully fledged PaaS database with 10GB capacity, can be partitioned for more space
- Monitoring and metrics
- Plug and play with other Azure resources
- Excellent query explorer to help you determine resource utilization and costs
- Geo-replication out of the box

#### How to use Azure Document DB

Follow the quickstart guide most relevant to your target platform
    
- ASP.NET
- ASP.NET Core
- Node.js
- Python
- Java

Doing so will give you a test instance and sample code to connect your backend to it.
Once your done seeing how it hangs together, get started on the real thing. I personally would not roll this code into production as it makes use of a static, generic repository pattern, but that is just my opinion. 

![Quick start](/assets/adb-quick-start.png)

Provision your document DB instance

![Provisioning Azure Document DB](/assets/adb-create.png)

Create a collection and database

![Create a collection](/assets/adb-add-collection.png)

Upload your JSON documents into the database you created

![Upload your JSON Data](/assets/adb-cheese-doc-upload.png)

Experiment with some queries in the query explorer to determine their cost

![Experiment with some queries](/assets/adb-query-explorer.png)

Start modifying your boilerplate to sui. [Documentation portal here](https://docs.microsoft.com/en-us/azure/documentdb/)

||Breakdown|
|---|---|
|*[Price](https://azure.microsoft.com/en-us/pricing/calculator/)*|PAYG only: S1 ~ AUD$30 a month|
|*Storage*|S1: 10GB SSD or ~30cents / GB |
|*Good*|Dial features up to 11, you can build serious software around this|
|*Not so good*| No free tier, No client side boilerplate OOTB, but could be done with node.js and browserify. Could get pricey, fast.|

### JSON => API in 60 Seconds

Ok, maybe a little longer than 60 seconds, but not by much!

Clearly, there is a correlation between cost and features - so the choice is yours.

With one of the tools used above, all you need is an idea of the data structure you would like to host, some knowledge of your target environment and an open mind.

Those ingredients can get you working against something real in no time, and each can scale in complexity with you as you go forward.

*Please note all prices were based on estimates provided from the links I've provided at time of writing, and may be out of date, please refer to the company pricing guides for up to date information*










