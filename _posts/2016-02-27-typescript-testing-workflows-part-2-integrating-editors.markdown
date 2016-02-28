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

### Integrate with $env:UsersFavouriteEditor
Because gulp is just another node application, we can integrate it to any number of editors, to use key bindings or buttons to mash when building.

I've provided some examples of popular editors:

- [VS Code](#vscode)
- [Atom](#atom)
- [Sublime Text 3](#sublime3)
- [Brackets](#brackets)
- [Vim](#vim)
- [Visual Studio](#vs)

#### <a name="vscode"></a>Visual Studio Code
>[VS Code](https://www.visualstudio.com/en-us/products/code-vs.aspx) uses its own [task runner](https://code.visualstudio.com/docs/editor/tasks) and a tasks.json file to integrate your projects chosen runner. If you hit Ctrl+Shift+B without this file, VS Code will create a sample for you.

Below is an example that utilizes gulp and uses the gulp-tsc 'problemMatcher' (think: output formatter) to yield any problems to the IDE.

**./.vscode/tasks.json**

```javascript
{
    "version": "0.1.0",
    "command": "gulp.cmd",
    "isShellOutput": true,
    "showOutput": "always",
    "tasks": [
        { "taskName": "default", "isBuildCommand": true, "isTestCommand": true, "problemMatcher": "$gulp-tsc" },
    ]
}
```

Once saved, isBuildCommand and isTestCommand bind to Ctrl+Shift+B and Ctrl+Shift+T respectively.

![VS Code & gulp-tsc problemMatcher](/assets/vs-code-gulp.PNG)

#### <a name="atom"></a>Atom
>[Atom](https://atom.io/) has a diverse range of packages that you can add. You can even automate this with apm. Here I'll use apm to install [gulp-control](https://atom.io/packages/gulp-control) for a graphical gulp experience.

```bash
apm install gulp-control
```

Once installed just open gulp-control with Ctrl+Alt+O. This gives you large buttons to mash when building is required.

![atom gulp control](/assets/atom-gulp-control.PNG)

#### <a name="sublime3"></a>Sublime Text 3

>[Sublime Text 3](https://www.sublimetext.com/3) has a [great site](https://packagecontrol.io/) for package management that integrates with the editor.
I've found the Sublime Gulp package to work well: https://packagecontrol.io/packages/Gulp

1. Install package control https://packagecontrol.io/installation
2. Ctrl+Shift+P (Ctrl+Command+P) to open the command pallette
3. Type 'install package' wait for the repo to index
4. Reboot sublime (!)
5. Repeat step 2
6. Type 'Gulp'

Once Installed open the command palette (Ctrl+Shift+P), type gulp, then select the task you want to run.

![Sublime Text 3 and Gulp](/assets/sublime-gulp.PNG)

#### <a name="#brackets"></a>Brackets

>The [Brackets](http://brackets.io/) community also enjoys a huge variety of packages.
There is a [brackets-gulp](https://github.com/dalcib/brackets-gulp) package that is no longer maintained, and the owners advice appears to be 'use [brackets-shell](https://github.com/adobe/brackets-shell)'

1. File -> Extensions Manager -> Search -> 'brackets-shell'
2. install brackets-shell
3. There will now be a shell icon right of screen, click it and  type 'gulp' in the console bottom screen.

![brackets-shell](/assets/brackets-shell.PNG)

type 'gulp' to run your build

#### <a name="vim"></a>Vim
> I highly recommend using [vim-plug](https://github.com/junegunn/vim-plug) for automating plugin installation over the traditional method of self management.


[Vim](http://www.vim.org/) has a nice little gulp wrapper plugin called  [gulp-vim](https://github.com/KabbAmine/gulp-vim) which is easy to install and use.


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

#### <a name="vs"></a>Visual Studio
[Visual Studio](https://www.visualstudio.com/) now has an in built, grunt/gulp aware [Task Runner Explorer](http://www.hanselman.com/blog/IntroducingGulpGruntBowerAndNpmSupportForVisualStudio.aspx) that requires no steps to configure.  
Open the explorer with Ctrl+Alt+Bkspce and it will inspect available gulpfiles for tasks to run.
IMO this works best in conjunction with [Node Tools for Visual Studio](https://www.visualstudio.com/en-us/features/node-js-vs.aspx) to provide nodejs debugging where required.

![Visual Studio Task Runner Explorer](/assets/vs-task-runner.PNG)

### Final thoughts

It is no surprise really that with the diversity of OSS actors, that we would end up with build technologies that are reasonably decoupled from IDE's and indirectly result in a high degree of developer choice.

Its certainly an exciting time to be a developer!
