---
layout: post
title:  "Blog.Moved(); //again"
date:   2016-02-08 20:47:18 +1030
categories: meta
author: Jim Burger
tags:
- meta
- blog
- Jekyll
- ruby
- redcarpet
- github-pages
- git
---

## Why move at all

I guess the pull to use markdown and github as a blogging platform was too great - [github pages](http://pages.github.com) have that elusive _it just works_ factor.

Originally, I had grand visions of making it a DIY project, but between working in the game and helping out on a startup, as well as keeping up with study on Azure and other tech, this was starting to feel like a fools errand. Blogging was more important than learning to use [angular 2](https://angular.io) & [nodejs to integrate with Github](https://github.com/ajaxorg/node-github). So while [Medium](https://medium.com) was tempting, this setup proved to be closer to my original intent. And I'm pleased with the result.

I've tried [the](http://wordpresscom) [big](http://tumblr.com) [three](http://blogger.com). I've tried dasBlog. Yes I'm fussy - I want control, but I want it to be simple. I want it to have features (e.g. custom domain redirection), but I don't want to pay for those features.

### Stack share

So - for those interested, the tech stack here is:
- Git & Github Pages for versioning/hosting
- Markdown, SASS & HTML5 for content generation
- Jekyll (runs on Ruby) for engine and scaffolding
- Disqus for driving user engagement
- Godaddy for the DNS entries and domain purchasing etc.
- Outlook aliases for any emails
- A humble macbook pro

This arrangement costs nothing (Domain registration not withstanding) and the workflow is as follows:
- Create / edit a post.md
- open terminal
- git add .
- git commit -m 'describe change'
- git push

### Other considerations

I found importing my existing content from [The Maintenance Coder](http://maintenancecoder.wordpress.com) to be a simple affair - thanks to the jekyll-import ruby gem and its documentation. It wasn't 100%, but it got me 80% of the way there and even downloaded image assets etc. Again, pretty happy.

Markdown choice wasn't entirely OOTB - I went with redcarpet for the Github Flavoured Markdown (syntax highlighting was a must - something I struggled with on wordpress.com)
