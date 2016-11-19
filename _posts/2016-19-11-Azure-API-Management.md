---
layout: "post"
title: "Azure API Management"
date: "2016-11-19"
categories: web
published: false
author: Jim Burger
tags:
- REST
- Azure
- Swagger
- dotnetcore
---

# Building a community around your API

Microsoft's Azure API Managment service is currently in preview but already has an impressive array of features. It looks to be geared towards quickly serving up a suite of APIs for your organisation. 


You may not need all of its community oriented features initially, but if you've put your POC in front of the right people, who knows?

- Manage API consumer usage restrictions
- Can import swagger.json files
- Seperate public and internal facing, customisable web portals for managing user and operations
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
4. Choose security options: there are many available ranging from client certificates to OAuth providers.

[Azure API Management Documentation](https://docs.microsoft.com/en-us/azure/api-management/api-management-key-concepts)
