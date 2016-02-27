---
layout: post
title:  "Typescript testing workflows - part 1: Using Mocha"
date:   2016-02-27 21:47:18 +1030
categories: web
published: true
author: Jim Burger
tags:
- testing
- blog
- mocha
- TypeScript
---

## if(!simple) { //ignore }

I like simple test workflows. Mainly because as soon as they get difficult, people
simply work around them or ignore the test output.

Throw in xplat development and it really pays off to have a write once, execute many, workflow.

## Hot n tasty testing

This recipe comprises four main ingredients:
- A clear folder structure
- gulp tasks
- the mocha test framework
- integration into your development environment. In part 2 of this series, I'll cover the following editor integrations:
    - VS Code
    - Atom
    - Sublime Text 3
    - Brackets
    - Vim
    - Visual Studio

> You can review the code for this recipe here: https://github.com/jburger/examples/tree/master/typescript_mocha

#### Packages used

```bash
#globals
npm install -g gulp typescript typings mocha
#locals
npm install --save-dev gulp gulp-typescript mocha gulp-mocha chai
```
### TSafying mocha tests
Mocha's test framework uses familiar syntax and plays nicely with common assertion packages like chai, should and assert. Using typescript makes for some minor stylistic changes:

```javascript
///<reference path="typings/mocha.d.ts"/>
// the above is to give our tooling ambient definition hinting - not available in all editors
import SystemUnderTest from '../src/sut';
import * as Chai from 'chai';
const expect = Chai.expect;

describe('My context', () => {
  describe('Some event', () => {
    it('should result in something', () => {
      const sut = new SystemUnderTest();
      expect(sut.result).to.eq('something'); //aside: chai is not type checked :()
    })
  })
});
```
### Mmm, mocha .... *gulp*
The basic steps for a repeatable test task are as follows:

0. (Build your source code)
1. Find your test code (*gulp.src('glob')*)
2. Transpile to javascript (*gulp.pipe(transpiler())*)
3. Flush to disk (*gulp.pipe(gulp.dest('path/out'))*)
4. Run tests with mocha (*gulp.pipe(mocha(options))*)
5. Place it in your default task (*gulp.task('default', ['build', 'test'])*)
6. Run build on the command line (*gulp*)
7. **Taste the glory**

E.g.

```javascript
var gulp = require('gulp');
var ts = require('gulp-typescript');
var mocha = require('gulp-mocha');

//SNIP -- build task.
// .
// .
//--

//optional - use a tsconfig file
var tsProject = ts.createProject('./tsconfig.json');
gulp.task('test', function() {
    //find test code - note use of 'base'
    return gulp.src('./test/**/*.ts', { base: '.' })
    /*transpile*/
    .pipe(ts(tsProject))
    /*'base' keeps js output in same place as ts files*/
    .pipe(gulp.dest('.'))
    /*execute tests*/
    .pipe(mocha({
        reporter: 'progress'
    }));
});
/* single command to hook into VS Code */
gulp.task('default', ['build','test']);
```
Writing build and test automations has never been simpler, mocha's syntax for testing is immediately recognizable, and gulp's syntax will make you feel instantly productive with minimal learning curve.

In my [next post]('2016-02-27-typescript-testing-workflows-part-2-integrating-editors.html'), I'll round out the solution with integration of gulp into commonly used editors.
