---
layout: post
title:  "Typescript testing workflows - part 1: Using Gulp-Mocha"
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

I like simple test workflows. Mainly because testing is often the first guy up against the wall when the time pressure revolution comes.

![deadlines](/assets/test-passing.PNG)

If testing is simple, up to date and relevant, it won't need defense when the going gets tough.

Throw in the need for cross platform development and it really pays off to have a write once, execute many, workflow.

The following is a simplification based on [tried and true](https://github.com/Microsoft/vscode/blob/master/gulpfile.js) gulp automation techniques.

## Hot 'n tasty [TypeScript](http://www.typescriptlang.org/) testing

This recipe comprises four main ingredients:

- A clear folder structure
- [gulp](http://gulpjs.com/) tasks
- the [mocha](https://mochajs.org/) test framework
- integration into your development environment. In part 2 of this series, I'll cover the following editor integrations:
    - [VS Code](https://www.visualstudio.com/en-us/products/code-vs.aspx)
    - [Atom](https://atom.io/)
    - [Sublime Text 3](https://www.sublimetext.com/3)
    - [Brackets](http://brackets.io/)
    - [Vim](http://www.vim.org/)
    - [Visual Studio]( https://www.visualstudio.com/)

> [You can review the code for this recipe here](https://github.com/jburger/examples/tree/master/typescript_mocha)

#### Packages used

```bash
#globals
npm install -g gulp typescript typings mocha
#locals
npm install --save-dev gulp gulp-typescript mocha gulp-mocha chai
#typings
typings install --save --ambient mocha chai orchestrator Q
```
### TS-afying mocha tests
Mocha's test framework uses familiar syntax and plays nicely with common assertion packages like [chai](http://chaijs.com/), [should](https://shouldjs.github.io/) and assert. Using typescript makes for some minor stylistic changes:

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
    });
  });
});
```
### Mmm, mocha .... *gulp*
The basic steps for a repeatable test task are as follows:

1. Find your test code
  - ```gulp.src('glob')```
2. Transpile to javascript
  - ```gulp.pipe(transpiler())```
3. Run tests with mocha  
  - ```gulp.pipe(mocha(options))```
4. Rig gulp's 'default' task  
  - ```gulp.task('default', ['build', 'test'])```
5. Run build on the command line
  - ``` gulp ```
6. **Taste the glory**

**gulpfile.js**

```javascript
var gulp = require('gulp');
var ts = require('gulp-typescript');
var mocha = require('gulp-mocha');

gulp.task('build', function() {/*SNIP*/});

//optional - use a tsconfig file
var tsProject = ts.createProject('./tsconfig.json');
gulp.task('test', function() {
    //find test code - note use of 'base'
    return gulp.src('./test/**/*.ts', { base: '.' })
    /*transpile*/
    .pipe(ts(tsProject))
    /*execute tests*/
    .pipe(mocha({
        reporter: 'progress'
    }));
});
/* single command to hook into VS Code */
gulp.task('default', ['build','test']);
```

**tsconfig.json**
```javascript
{
    "compilerOptions": {
        "target": "es3",
        "module": "commonjs"
    }
}
```

#### Report all the things!
[Mocha's test reporters reporters are extensible](https://github.com/mochajs/mocha/tree/master/lib/reporters), and predictably range from simple progress bars (as is in my example) to a [nyan cat](https://www.youtube.com/watch?v=wZZ7oFKsKzY)

![nyan mocha reporter](/assets/ascii-nyan.png)

Writing build and test automations has never been simpler, mocha's syntax for testing is immediately recognizable, and gulp's syntax will make you feel instantly productive with a minimal learning curve.

#### Other recipes
Gulp provides a tonne of simple recipes - [try some out](https://github.com/gulpjs/gulp/tree/master/docs/recipes)

In my next post, I'll round out the solution with integration of gulp into commonly used editors.
