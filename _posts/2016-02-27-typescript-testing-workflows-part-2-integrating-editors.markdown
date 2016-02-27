---
layout: "post"
title: "Typescript testing workflows - part 2: Integrating editors"
date: "2016-02-27 23:39"
---

## Recap(uccino)
In my [previous post]('2016-02-27-typescript-testing-workflow-part1-mocha.html') previous post, I walked through some basics with gulp, typescript and mocha.

In this post I'll cover the following popular editor integrations for gulp:
    - VS Code
    - Atom
    - Sublime Text 3
    - Brackets
    - Vim
    - Visual Studio

### Integrate with $env:USR_FAVOURITE_EDITOR
I don't know of any serious programming text editors that don't have a way to execute a shell command.

#### Visual Studio Code
VS Code uses its own task runner and a tasks.json file to integrate your projects chosen runner:

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
#### Atom
Atom has a diverse range of packages that you can add. You can even automate this with apm. Here I'll use apm to install gulp-control for a great graphical gulp experience.

```bash
apm install gulp-control
```

Once installed just open gulp-control from the packages menu.

![atom gulp control]('assets/atom-gulp-control.png')

#### Sublime Text 3

Sublime has a great site for common packages: https://packagecontrol.io/
I've found the Sublime Gulp package to work well: https://packagecontrol.io/packages/Gulp
1. Install package control https://packagecontrol.io/installation
2. Ctrl+Shift+P (Ctrl+Command+P) to open the command pallette
3. Type 'install package' wait for the repo to index
4. Reboot sublime (!)
5. Repeat step 2
6. Type 'Gulp'

Once Installed open the command pallette and type gulp then select the task you want to run

#### Brackets

THe brackets community also enjoys a huge variety of packages.
There is a brackets-gulp package that is no longer maintained, and the owners advice appears to be 'use brackets-shell'

1. File -> Extensions Manager -> Search -> 'brackets-shell'
2. install brackets-shell
3. There will now be a shell icon right of screen, just type 'gulp' and you're off.
