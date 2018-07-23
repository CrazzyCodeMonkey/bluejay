# Bluejay
## What is it
Bluejay is a simple to use API framework, it differs from other frameworks in that you register routes up front, and anything not matching a route ends up in a 404.

## What is it not
Production ready. This is a work-in-progress, currently at a whopping version 0.1, so play around, all feedback is welcome, but don't blame me if it eats your precious data :)

## Requirements
Developed with the latest OpenBD (Released on 2018-07-18).

Does rely on [Tuckeys Url Rewrite Filter](http://tuckey.org/urlrewrite/) and the following as the WEB-INF/urlrewrite.xml

```
  <?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE urlrewrite PUBLIC "-//tuckey.org//DTD UrlRewrite 4.0//EN"
  "http://www.tuckey.org/res/dtds/urlrewrite4.0.dtd">

<urlrewrite use-query-string="true">
  <rule>
    <condition type="request-uri" operator="notequal">^/(index.cfm|robots.txt|images|javascripts|images|stylesheets)</condition>
    <from>^/(.*)$</from>
    <to type="passthrough">/index.cfm?$1</to>
  </rule>
</urlrewrite>
```

## Helpful magic
Bluejay will automatically register route handlers found in /routes, just place your components there and make sure to implement a public handler() and a public getRoute() function.

## Root Application.cfc example
```
component output="false" {
  this.name = "BluejayExample";

  function onApplicationStart() {
    application.bluejay = new bluejay.bluejay();
  }

  function onRequestStart(targetPage){
    application.bluejay.handleRoute();
  }
}
```

## Manually register route handler
`application.bluejay.registerRoute("route.to.component");`


## Route components
```
component output="false" {
  public function handler( struct data ) returnformat="json" {
    return { success: data.recipient};
  }

  public function getRoute(){
    return "message/%recipient%/";
  }
}
```

## Route matching
Bluejay supports four types of matching
* Complete match `message/status/`
* Wildcard `message/*/`
* Array data `message/%/`
* Struct data `message/%recipient%/`