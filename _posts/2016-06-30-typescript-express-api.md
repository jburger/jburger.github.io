---
layout: "post"
title: "Server side typescript: express API example"
date: "2016-06-30"
categories: web
published: true
author: Jim Burger
tags:
- REST
- express
- TypeScript
---

Here lies a simple(ish) pattern to build express API's with typescript.

## Why typescript for the server?
For the same reason people end up using other transpiled languages! Because I get an early warning system - for very little upfront effort. Also, it allows me use a language that reminds me of the best parts of [C#](https://www.typescriptlang.org/docs/handbook/generics.html), [F#](https://www.typescriptlang.org/docs/handbook/type-inference.html) and [javascript](http://shop.oreilly.com/product/9780596517748.do).

### So I don't need to write unit tests anymore?
Sorry but even though this example doesn't come packing with tests, you should probably write tests for your production code. Not all issues are picked up by type checking.

### [Take a look on github](https://github.com/jburger/examples/tree/master/typescript_express)

### What next?

You could easily extend this example to include [authentication](http://passportjs.org/docs), produce dynamic [api documentation](https://www.npmjs.com/package/swagger-ui), add a [database](https://www.npmjs.com/package/documentdb) and many other types of middleware.

### Break it down...

### tsconfig.json
_For configuring the behaviour of the typescript compiler_

```
{
    "compilerOptions": {
        "module":"umd",
        "sourceMap": true,
        "noEmitOnError": true
    },
    "exclude": [
        "node_modules/",
        "typings/"
    ]
}
```

**NOTE** You'll want to use [typings](https://npmjs.org/typings) to bring in nodejs & express definitions.

### application.ts
_Application Class_

```
///<reference path="./typings/main.d.ts"/>
import express = require("express");
import customerRouter = require("./routes/customerRouter");
import requestLogger = require("./middleware/requestLogger");

export class WebApi {
    /**
     * @param app - express application
     * @param port - port to listen on
     */
    constructor(private app: express.Express, private port: number) {
        this.configureMiddleware(app);
        this.configureRoutes(app);
    }

    /**
     * @param app - express application
     */
    private configureMiddleware(app: express.Express) {
        app.use(requestLogger);
    }

    private configureRoutes(app: express.Express) {
        app.use("/customer", customerRouter );
        // mount more routers here
        // e.g. app.use("/organisation", organisationRouter);
    }

    public run() {
        this.app.listen(this.port);  
    }
}
```

### routes/customerRouter.ts
_Example express Router usage_

```
import express = require("express");

let customerRouter = express.Router();
customerRouter.get('/', (request: express.Request, response: express.Response) => {
    let testData = {
        firstName: "The",
        lastName: "Burge"
    }

    response.send(testData);
});
// add more route handlers here
// e.g. customerRouter.post('/', (req,res,next)=> {/*...*/})
export = customerRouter;
```

### middleware/requestLogger.ts
_Example custom middleware implementation_

```
import express = require("express");

let requestLogger: express.RequestHandler = (
    request: express.Request,
    response: express.Response,
    next: express.NextFunction
) => {
    console.info(`${(new Date()).toUTCString()}|${request.method}|${request.url}|${request.ip}`);
    next();
}

export = requestLogger;
```

### index.ts
_Program entry point_

```
import express = require('express');
import { WebApi } from './application';

let port = 5001; //or from a configuration file
let api = new WebApi(express(), port);
api.run();
console.info(`listening on ${port}`);
```
