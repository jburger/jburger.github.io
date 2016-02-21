---
layout: post
title:  "Webpack & TypeScript"
date:   2016-02-21 20:47:18 +1030
categories: web
published: true
author: Jim Burger
tags:
- bundling
- blog
- minification
- TypeScript
---
## TL;DR
- A working example of client side bundling TypeScript with webpack.
- The aim is not to bundle everything, but to minimise the risk of mistakes when self managing script dependencies.
- It is widely recognised now that bundling large sites slows performance, and with HTTP/2 becoming more and more common, we should take advantage of its multiple script loading.
- With that said, we'd rather keep managing script order to minimum =)

You can view the entire solution (on github)[http://github.com/jburger/examples/typescript_webpack]

## A word on namespaces and modules

There is a lot of unfounded & emotional criticism of tsc --out and namespaces (nee internal modules) out there to read. Take it all with a pinch of salt. It is not bad or evil. They will not hurt you if you don't expect magic from them.

In short - *[you should only choose one approach](https://www.stevefenton.co.uk/2015/05/Stop-Mixing-TypeScript-Internal-And-External-Modules/).*

The reality is that internal namespaces are just the old module pattern with the same list of use cases and caveats. Being aware of those caveats is essential to understanding how to achieve your goals.

One such caveat is that while it solves the 'don't dirty the global namespace' issue, it leaves you with a bunch of new problems, like 'what order should I load my script files in?'

For smaller projects (say 5-10 files) this is probably a non issue. Keeping track is trivial and usually executed in a template once. Yes, you can use the --out directive for tsc.exe to concatenate your files, however this still requires you to be aware of your own script dependency ordering.

For larger projects with a desire for proliferation of script files, it becomes attractive to consider using tooling to manage the script loading and dependency ordering issues that namespaces may tend toward.

Enter [commonjs](http://www.commonjs.org/) and the external module feature of TypeScript.

These also have use cases and caveats. Mainly that **you cannot split an external module across files like you can with namespaces**, potentially making a simple port to external modules a non trivial exercise. And that using **this approach is best pulled off with nodejs**. If either of these are a problem, you may want to look elsewhere.

For this reason alone, I think any developer starting a new TypeScript implementation should carefully weigh up the options before proceeding down any given track.

### A target implementation

To demonstrate how to take advantage of external modules to clean up a large code base I'll describe a target implementation for discussions sake (it is complex enough to demonstrate the point, but still simplistic):

- Client side architecture is divided into 3 categories: Application, Services, Configuration;
- Each category will map to an external module, and there will be several class exports in each module.
- For ease of development and code reuse, the desired bundled output is two javascript files: main.js & services.js

![TypeScript dependencies](/assets/example-architecture.png)

### A TypeScript+Webpack Recipe
#### Node Module Ingredients

The following dependencies were used to achieve this:

```JSON
"devDependencies": {
  "del": "^2.2.0",
  "gulp": "^3.9.1",
  "ts-loader": "^0.8.1",
  "webpack-stream": "^3.1.0"
},
"dependencies": {
  "jquery": "^2.2.0"
}
```

For those playing along at home, here are some handy snippets to get you going:

```bash
#optional CLI utils to help sanity check the build process
npm install tsc gulp typings webpack -g
#local development dependencies
npm install --save-dev gulp del webpack-stream ts-loader
#local dependencies
npm install --save jquery
#once packages are loaded, retrieve typings for external libraries used
typings install jquery --save --ambient
```

*NOTE: DefinitelyTyped has recently deprecated tsd in favour of [typings](https://github.com/typings/typings), which does a better job at keeping typing mgmt overhead lower on large projects and is worth reading up on.*

#### Splitting up into modules
As specified I'm aiming to reduce the number of scripts I need to manually manage ordering for. You could choose to bundle into one file if you wanted to with the same approach.

```XML
<head>
  <title>Testing TypeScript and webpack</title>
  <script src="js/services.js" charset="utf-8"></script>
  <script src="js/main.js" charset="utf-8"></script>
</head>
```
As you can see we'll be bundling 3 TypeScript files into two javascript files. Here is the source files (snipped for brevity)

**main.ts**

```javascript
///<reference path="../typings/main.d.ts"/>
import $ = require('jquery');
import { IConfiguration } from './configuration';
import { IService } from './services';

export class Program {
  private _config : IConfiguration;
  private _endpoint : IService;

  constructor(config? : IConfiguration, endpoint? : IService) {
      this._config = config;
      this._endpoint = endpoint;
  }

  Run() {
  //does stuff
  }
}
.
.
.
.
//todo: DI - you get the picture...
const app = new Program(config, service);
$(() => app.Run());
```
> Note that we bring in the typing reference for jquery as well as require it directly. The first is to give tsc a hint, the second is for webpack / commonjs hinting. The subsequent lines use named module loading.

**services.ts**

```javascript
import { IConfiguration,  DevelopmentConfig } from './Configuration';

export interface IService {
    Get(): IEndpointResponse;
}

export interface IEndpointResponse {
    data: any;
    total: number;
}

export class EndpointService implements IService {
    private _config: IConfiguration;
    constructor(config: IConfiguration) {
        this._config = config;
    }

    Get(): IEndpointResponse {
        //more stuff to do
    }
}
```

**configuration.ts**

```javascript
export interface IConfiguration {
    serviceUrl: string;
    welcomeMessage: string;
}

export class DevelopmentConfig implements IConfiguration {
  //settings etc
}

```

> Use of explicit 'export module' calls are up to you. You end up aliasing a bit more in practice, but the global namespace pollution seems less to me. Again, a design decision to ponder up front. In essance, we dont want to [over use the module keyword unecessarily](http://www.typescriptlang.org/Handbook#modules-pitfalls-of-modules) to avoid syntax like:

```javascript
import shapes = require('./shapes');
var t = new shapes.Shapes.Triangle(); // shapes.Shapes?
/// this works out a little better on the surface, but compiles to the same(ish) JS:
import { Shapes } from './shapes';
var t = new Shapes.Triangle();
```

### Stop. Building time.
A massive part of this approach is the build scripting itself.

The theory is the same regardless of build tool choice (I'm using gulp here):
1. Determine appropriate 'entry points' into your TypeScript code base.
2. Pipe your TypeScript along with the entry point information to webpack and let it figure out your dependency graph based on the import statements in the code.

Here is how I did that in my gulpfile.js:

```javascript
var gulp = require('gulp'),
    del = require('del'),
    webpack = require('webpack-stream');

var webpackOptions = {
  devtool: 'source-map',
  resolve: {
    extensions: ['', '.webpack.js', '.web.js', '.ts', '.js']
  },
  module: {
    loaders: [
      { test: /\.ts$/, loader: 'ts-loader' }
    ]
  }
}
```
First I start by loading the dependencies:
- gulp: build tool
- del: delete files from a pipe
- webpack-stream: run webpack from within gulp and pipe files to it

I then configure an options object for use with webpack.
- **devtool:** optionally set source mapping on for live debugging
- **resolve:** teaches webpack which files to inspect and resolve
- **module.loaders:** this is important; ts-loader understands TypeScript and its module syntax and allows you to pipe TypeScript directly into webpack without compilation first. This decoupling allows you to use your IDE to do whatever it likes to do to tell you about compilation warnings, which doesn't effect what goes on in the build script. Webpack will still fail if there is a compilation issue.

I then create a reusable function in to make targeting entry points easier:

```javascript
function builder(files, dest, entrypoint, outfile) {
  var opts = webpackOptions;
  opts.entry = entrypoint;
  opts.output = { filename: outfile };

  return gulp.src(files)
    .pipe(webpack(webpackOptions))
    .pipe(gulp.dest(dest));
}
```
From here it is now a case of fairly straight forward gulp scripting:

```javascript
gulp.task('clean', function() {
    return del(['js/', "ts/**/*.js"]);
});

gulp.task('build-main', function() {
  return builder(['ts/*.ts'], 'js/', './ts/main.ts', 'main.js')
});

gulp.task('build-services', function() {
  return builder(['ts/*.ts'], 'js/', './ts/services.ts', 'services.js')
});

gulp.task('default', ['clean', 'build-main', 'build-services']);
```
#### Hiding folders from the TypeScript compiler

Using nodejs means having a node_modules folder inevitably, so you'll likely need to exclude it from your tsconfig.json.

**tsconfig.json**

```JSON
{
	"compilerOptions": {
		"module": "commonjs",
		"target": "ES5"
	},
  "exclude": [
      "node_modules",
			"typings"
  ]
}
```

#### Polishing the dev experience a little
The final piece to a good dev experience is hooking simple commands to make everything work nicely. You can use a gulp watch if you like, although not everyone is into those. Here is how I added some scripts to my package.json file for this purpose:

**package.json**

```JSON
{
    .
    .
    .
  "scripts": {
    "start": "./node_modules/http-server/bin/http-server",
    "build": "gulp"
  },
  .
  .
  .
}
```

The idea here is to enable a simple set of commands to do the typical things:

```bash
npm install   # Install packages
npm run build # Transpile and pack scripts and content
npm start     # Run the web server
```

### What have we achieved?

Our outcomes are as follows:

1. A mechanism to have a reasonably modular development experience at design time; the ability to break down functionality into smaller code files, optionally naming those as modules
2. A simple transpile and package step. We could hook in further mangling/minification if we choose.
3. Brought in a rich framework for packing other site assets like css, images and the like
4. Enabled a minimized runtime script surface area, while still allowing for optimized load times over HTTP/2 multi request.
