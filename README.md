[![Build Status](https://travis-ci.org/LuckyMarmot/Paw-JavaApacheHttpClientFluentAPICodeGenerator.svg?branch=master)](https://travis-ci.org/LuckyMarmot/Paw-JavaApacheHttpClientFluentAPICodeGenerator)

# Java + HttpClient (from HttpComponents) Code Generator (Paw Extension)

This a Paw Extension that generates code for Java using the [Apache HttpComponents Client](http://hc.apache.org/httpcomponents-client-ga/index.html) library via the [Fluent API](http://hc.apache.org/httpcomponents-client-ga/fluent-hc/apidocs/index.html).

## Installation

* `npm install`
* `cake build`
* `cake install`

## Tests

Download `HttpClient >= 4.3.x` at https://hc.apache.org/downloads.cgi

```bash
export CLASSPATH=.:commons-logging-1.1.3.jar:httpmime-4.3.6.jar:httpcore-4.3.3.jar:httpclient-4.3.6.jar:fluent-hc-4.3.6.jar && javac SendRequest.java && java SendRequest
```

## License

This Paw Extension is released under the [MIT License](LICENSE). Feel free to fork, and modify!

Copyright © 2014 Paw Inc.

## Contributors

Created by Quentin Rousseau ([@kwent](https://github.com/kwent)). See [Contributors](https://github.com/LuckyMarmot/Paw-JavaApacheHttpClientFluentAPICodeGenerator/graphs/contributors).

## Credits

* [Mustache.js](https://github.com/janl/mustache.js/), also released under the MIT License
