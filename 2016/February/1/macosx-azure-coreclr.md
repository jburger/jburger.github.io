# Web app development on Mac OS X with DotNet Core and Azure

Firstly, some disclaimers. I don't pretend that this is always going to work, and it highly dependent on various factors, but is a catalog of techniques that has worked for me. I hope you find something of use in this article!

## High level goals
- Coding on my MBP
- Free editing tools
- Continuous Deploy via Azure
- Setup some cross cutting concerns like auth/auth/logging
- Use the later bits n pieces from MS like dotnet core CLR

> NOTE: beginner developers may want to look elsewhere as we are talking about beta software and bleeding edge developer catnip from Microsoft

## Tech stack - Microsoft

I _promise_, for those not interesting in Microsoft technologies, I will do this on another stack - but for today I'll focus on using:
- Azure Web Application Services
- dotnet CLI, kestrel web server, dotnet core 1.0, C# etc.
- VS Code on a MBP

### Roadmap
We'll take the following steps through this process:

1. install the latest bits and pieces
2. create a project and hook it into azure continuous deployment
3. turn on auth and write some common scenarios in .NET

#### Pieces & Bits to install
Here is the order of installations I performed.

1. https://get.asp.net/
This install the various parts of the dotnet core runtime that we'll be leveraging.

> _To ignore security warning when installing .pkg files on OS X_:

> In the Finder, locate the app you want to open.

>Don’t use Launchpad to do this. Launchpad doesn’t allow you to access the shortcut menu.

>Press the Control key and click the app icon, then choose Open from the shortcut menu.

>Click Open.

>The app is saved as an exception to your security settings, and you can open it in the future by double-clicking it just as you can any registered app.

2. https://code.visualstudio.com/ This free text editor is well worth the look, although if you prefer a different editor - OmniSharp is a great way to integrate dotnet into most of the popular editors out there.

#### command line basics

You've got some new tools at your fingertips now. Lets crank up Terminal to take a look. Once open start typing:

```
dnvm       
```
For those familiar with node and other platforms, dnvm is unsurprising, its a version manager for assigning the current session with a dotnet runtime. dnvm list will show your your currently managed runtimes.

```
ls ~/.dnx/packages
```
Gives a listing of what was recently installed for dotnet to run.
```
dnu
```

Dnu is the utility used to manage nuget packages. most commonly you'll use dnu restore to fetch dependencies. Similar to npm (in fact it will invoke npm/bower as required). It is also used to build your application.

```
dnx
```
Dnx is effectively the runtime itself, you can run a project.json
with it, debug, set configurations etc.

> NOTE: At time of writing the newer dotnet CLI was currently not able to 'just work' so at some point I'll have to update this post to use it instead of the rc1 toolkit


#### Create a project and setup continuous deployment

This step will make some assumptions:
- You have an azure account (there is a free trial offering)
- You have a Github account (also free)
- You've installed VS Code on your Mac (OmniSharp is a viable option for those who want to stay in their favourite editor)
- You are connected to the internet for parts of this tutorial that require it.

The github aspect is relatively interchangeable with other source control SaaS providers out there - I'll let you figure that part out.

So lets crank up Terminal and make a project. Type in the following lines to get started...

```
mkdir myApp && cd myApp
git init .
>> do your git setup for github etc.

touch project.json
touch Program.cs

```

For those familiar with Microsoft technologies, the most pleasing aspect of this boilerplate is the sheer *minimalism* going on here. You will only need 2 files: a project.json file (for dependencies), and a source file.

Now is a good time to commit & push your initial state, should you want to work on it later (assuming you have set up your github repo). I'd recommend setting up a 'develop' branch and pushing to it. We'll use your master branch to deploy from.

```
git add .
git commit -m 'initialized my project'
git push origin develop
```

#### Turning hello world into a web application
#### Creating the web application on Azure
#### Git based 'continuous deployment'
#### Setting up authentication providers
#### Role based authorizations
#### Logging
#### Wrapping up
