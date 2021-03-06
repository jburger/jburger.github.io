---
layout: "post"
title: "Typescript testing workflows - part 2: Integrating editors"
date: "2016-02-27 23:39"
categories: web
published: true
author: Jim Burger
tags:
- testing
- blog
- mocha
- TypeScript
---

## Re-cap(uccino)
In my [previous post]('2016-02-27-typescript-testing-workflow-part1-mocha.html'), I walked through some basics with gulp, typescript and mocha.

In this post I'll cover the following popular editor integrations for gulp:

- [VS Code](https://www.visualstudio.com/en-us/products/code-vs.aspx)
- [Atom](https://atom.io/)
- [Sublime Text 3](https://www.sublimetext.com/3)
- [Brackets](http://brackets.io/)
- [Vim](http://www.vim.org/)
- [Visual Studio]( https://www.visualstudio.com/)

### Integrate with $env:USR_FAVOURITE_EDITOR
Over the years I've used plenty of editors and continue to chop and change as each leapfrogs the other in terms of quality & community support. What I choose to use is largely irrelevant though - they are all great in their own way and it should be up to each developer how they choose to code.

That said, I don't know of any serious programming text editors that don't have a way to execute a shell command, so as a last resort, you can lean on that. However, there are usually extensions that give you buttons to mash or keyboard shortcuts to hit when its time to build. Let's go through some!

#### Visual Studio Code
VS Code uses its own [task runner](https://code.visualstudio.com/docs/editor/tasks) and a tasks.json file to integrate your projects chosen runner. If you hit Ctrl+Shift+B without this file, VS Code will create a sample for you. Below is an example that utilizes gulp and uses the gulp-tsc 'problemMatcher' (think: output formatter) to yield any problems to the IDE.

**./.vscode/tasks.json**

```javascript
{
    "version": "0.1.0",
    "command": "gulp.cmd",
    "isShellOutput": true,
    "showOutput": "silent",
    "tasks": [
        { "taskName": "default", "isBuildCommand": true, "isTestCommand": true, "problemMatcher": "$gulp-tsc" },
    ]
}
```

Once saved, isBuildCommand and isTestCommand bind to Ctrl+Shift+B and Ctrl+Shift+T respectively.

![VS Code & gulp-tsc problemMatcher](/assets/vs-code-gulp.PNG)

#### Atom
Atom has a diverse range of packages that you can add. You can even automate this with apm. Here I'll use apm to install [gulp-control](https://atom.io/packages/gulp-control) for a great graphical gulp experience.

```bash
apm install gulp-control
```

Once installed just open gulp-control with Ctrl+Alt+O. This gives you large buttons to mash when building is required.

![atom gulp control](/assets/atom-gulp-control.PNG)

#### Sublime Text 3

Sublime has a great site for common packages: https://packagecontrol.io/
I've found the Sublime Gulp package to work well: https://packagecontrol.io/packages/Gulp
1. Install package control https://packagecontrol.io/installation
2. Ctrl+Shift+P (Ctrl+Command+P) to open the command pallette
3. Type 'install package' wait for the repo to index
4. Reboot sublime (!)
5. Repeat step 2
6. Type 'Gulp'

Once Installed open the command palette (Ctrl+Shift+P), type gulp, then select the task you want to run.

![Sublime Text 3 and Gulp](/assets/sublime-gulp.PNG)

#### Brackets

The brackets community also enjoys a huge variety of packages.
There is a [brackets-gulp](https://github.com/dalcib/brackets-gulp) package that is no longer maintained, and the owners advice appears to be 'use [brackets-shell](https://github.com/adobe/brackets-shell)'

1. File -> Extensions Manager -> Search -> 'brackets-shell'
2. install brackets-shell
3. There will now be a shell icon right of screen, click it and  type 'gulp' in the console bottom screen.

![brackets-shell](/assets/brackets-shell.png)

type 'gulp' to run your build

#### Vim
Vim has a nice little gulp wrapper available: [gulp-vim](https://github.com/KabbAmine/gulp-vim) which is easy to install and use:
I highly recommend using vim-plug for managing /automating plugin installation over the traditional method of self management.

1. Install vim-plug ([instructions](https://github.com/junegunn/vim-plug))
2. Configure to use gulp-vim

```vim
:e ~\.vimrc

call plug#begin
Plug 'KabbAmine/gulp-vim'
call plug#end

:wq
<reopen>
:PlugInstall
```
![vim-plug](/assets/plugvim.PNG)

3. now cwd to your source and start using it:

```vim
:cd /path/to/source
:Gulp <task_name>
```

![Using gulp with vim](/assets/gulp-vim.PNG)

#### Visual Studio
Visual Studio 2015 has an in built, grunt/gulp aware Task Runner Explorer that requires no steps to configure.  
Open the explorer with Ctrl+Alt+Bkspce and it will inspect available gulpfiles for tasks to run.
IMO this works best in conjunction with [Node Tools for Visual Studio](https://www.visualstudio.com/en-us/features/node-js-vs.aspx) to provide nodejs debugging where required.

![Visual Studio Task Runner Explorer](/assets/vs-task-runner.PNG)

### Final thoughts

It is no surprise really that with the diversity of OSS actors, that we would end up with build technologies that are reasonably decoupled from IDE's and indirectly result in a high degree of developer choice.

Its certainly an exciting time to be a developer!
