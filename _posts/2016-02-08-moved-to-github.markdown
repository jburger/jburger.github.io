---
layout: post
title:  "Blog.Moved();"
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

Originally, I had grand visions of making it a DIY project, but between working and helping out on a startup, as well as keeping up with study on Azure and other tech, this was starting to feel like a fools errand. Blogging was more important than learning to use [angular 2](https://angular.io) & [nodejs to integrate with Github](https://github.com/ajaxorg/node-github). So while [Medium](https://medium.com) was tempting, this setup proved to be closer to my original intent. And I'm pleased with the result.

### Stack share

So - for those interested, the tech stack here is:

- [Git](http://git-scm.org) & [Github Pages](http://pages.github.com) for versioning/hosting
- Markdown, SASS & HTML5 for content generation
- [Jekyll](http://jekyllrb.com) (runs on Ruby) for engine and scaffolding
- [Disqus](http://disqus.com) for driving user engagement
- [Godaddy](https://godaddy.com) for the DNS entries and domain name purchasing/management.
- [Outlook aliases](http://windows.microsoft.com/en-us/windows/add-alias-account) for any emails to this blog.
- A humble macbook pro

This arrangement costs nothing (Domain registration not withstanding) and the workflow is as follows:

- Create / edit a post.md
- open terminal

```bash
git add .
git commit -m 'describe change'
git push
```

### Other considerations

I found importing my existing content from [The Maintenance Coder](http://maintenancecoder.wordpress.com) to be a simple affair - thanks to the [jekyll-import](http://import.jekyllrb.com/) ruby gem and its documentation. It wasn't 100%, but it got me 80% of the way there and even downloaded image assets etc. Again, pretty happy.

Markdown choice wasn't entirely OOTB - I went with the documentation for using [redcarpet](http://jekyllrb.com/docs/configuration/#redcarpet) - for the Github Flavoured Markdown (syntax highlighting was a must - something I struggled with on wordpress.com)
