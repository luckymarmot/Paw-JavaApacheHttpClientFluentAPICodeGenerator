require "mustache.js"
require "URI.js"

addslashes = (str) ->
    ("#{str}").replace(/[\\"]/g, '\\$&')
    
multiLinesToSingleLine = (str) ->
    ("#{str}").replace(/[\n"]/g, '\\n')

JavaApacheHttpClientFluentAPICodeGenerator = ->
  
    @url = (request) ->
        return {
            "fullpath": request.url
        }

    @headers = (request) ->
        headers = request.headers
        return {
            "has_headers": Object.keys(headers).length > 0
            "header_list": ({
                "header_name": addslashes header_name
                "header_value": addslashes header_value
            } for header_name, header_value of headers)
        }

    @body = (request) ->
        json_body = request.jsonBody
        if json_body
            return {
                "has_json_body":true
                "json_body_object": @json_body_object json_body
            }

        url_encoded_body = request.urlEncodedBody
        if url_encoded_body
            return {
                "has_url_encoded_body":true
                "url_encoded_body": ({
                    "name": addslashes name
                    "value": addslashes value
                } for name, value of url_encoded_body)
            }

        multipart_body = request.multipartBody
        if multipart_body 
            return {
                "has_multipart_body":true
                "multipart_body": ({
                    "name": addslashes name
                    "value": addslashes value
                } for name, value of multipart_body)
            }

        raw_body = request.body
        if raw_body
            if raw_body.length < 5000
                has_tabs_or_new_lines = (null != /\r|\n|\t/.exec(raw_body))
                return {
                    "has_raw_body":true
                    "raw_body": if has_tabs_or_new_lines then multiLinesToSingleLine(addslashes raw_body) else addslashes raw_body
                }
            else
                return {
                    "has_long_body":true
                }

    @json_body_object = (object) ->
        if object == null
            s = "null"
        else if typeof(object) == 'string'
            s = "\\\"#{addslashes object}\\\""
        else if typeof(object) == 'number'
            s = "#{object}"
        else if typeof(object) == 'boolean'
            s = "#{if object then "true" else "false"}"
        else if typeof(object) == 'object'
            if object.length?
                s = '[' + ("#{@json_body_object(value)}" for value in object).join(',') + ']'
            else
                s = '{' + ("\\\"#{addslashes key}\\\": #{@json_body_object(value)}" for key, value of object).join(',') + '}'
        return s

    @generate = (context) ->
        request = context.getCurrentRequest()
        
        view =
            "request": context.getCurrentRequest()
            "method": request.method[0].toUpperCase() + request.method[1..-1].toLowerCase()
            "url": @url request
            "headers": @headers request
            "body": @body request

        template = readFile "java.mustache"
        Mustache.render template, view

    return


JavaApacheHttpClientFluentAPICodeGenerator.identifier =
    "com.luckymarmot.PawExtensions.JavaApacheHttpClientFluentAPICodeGenerator";
JavaApacheHttpClientFluentAPICodeGenerator.title =
    "Java (Apache HttpClient via Fluent API)";

registerCodeGenerator JavaApacheHttpClientFluentAPICodeGenerator
