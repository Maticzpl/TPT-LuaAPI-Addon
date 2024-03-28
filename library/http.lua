---@meta
---@diagnostic disable:lowercase-global
---@diagnostic disable:duplicate-set-field

--- @alias HTTPHeaders { [1]: string, [2]: string }[]
--- @alias HTTPPostParams { [1]: string, [2]: string, [3]: string? }[]

--The HTTP API provides access to basic HTTP functionality. Depending on how TPT is built, it may only work with secure sites (ones that use TLS, i.e. HTTPS) or it may even be wholly unable to actually complete HTTP requests; see relevant #defines in Config.h. 
http = {}

---@class HTTPRequest
HTTPRequest = {}

--Returns one of the following:<br>
-- - "running" if the request hasn't finished yet;<br>
-- - "done" if the request has finished and the response body is ready to be read;<br>
-- - "dead" if the request is dead, i.e. if it has been cancelled or if the response body has been read.<br>
---@return "running"|"done"|"dead"
function HTTPRequest:status()
end

--If the request is not dead, returns the size of the response body in bytes in the first return value (-1 if the size is not known), and the number of bytes received so far in the second. If the request is dead, returns nothing.<br>
---@return integer|nil, integer|nil
function HTTPRequest:progress()
end

--Cancels the request. Does nothing if the request is dead<br>
function HTTPRequest:cancel()
end


---Finishes the request and returns the response body, status code, and headers. Call this only when HTTPRequest:status returns "done". Does and returns nothing if the request is dead.  
---Header data is returned as a collection of table objects. Each header is represented by a subtable t with t[1] containing the header name and t[2] containing the value.  
---Non-standard status codes of note are 601, which is returned by plain HTTP requests if TPT is built with ENFORCE_HTTPS, and 604, which is returned by all requests if TPT is built with NOHTTP. Note that both codes may be returned for other reasons. 
---@return string, integer, HTTPHeaders
function HTTPRequest:finish()
end

--```
--HTTPRequest http.get(string uri, [table headers], [string verb])
--```
--Constructs an HTTPRequest object and starts the underlying GET request immediately with the URI and headers supplied. The optional table argument is a collection of string key and string value pairs.<br>
--The optional verb argument will change this GET request into a custom request.<br>
--Headers can also be given as a collection of table objects, where t[1] is the header name and t[2] is the value. The optional verb argument will change this GET request into a custom request.<br>
---@param uri string  
---@param headers HTTPHeaders?  
---@param verb string?
---@return HTTPRequest
function http.get(uri, headers, verb)
end

--```
--HTTPRequest http.post(string uri, [table post_params | string post_data], [table headers], [string verb])
--```
--Same as http.get, except the underlying request is a POST. Post parameters are passed in the extra table argument, a collection of string key and string value pairs. You can also pass in string data to make a non-multipart POST request, or omit the argument to make a POST request with no data. The optional verb argument will change this POST request into a custom request (such as DELETE, etc.).<br>
--post parameters and headers can also be given as a collection of table objects, where t[1] is the parameter name and t[2] is the value. For post parameters only, t[3] is optional and controls the filename.<br>
---@param uri string  
---@param postParams HTTPPostParams | string?  
---@param headers HTTPHeaders?  
---@param verb string?  
---@return HTTPRequest
function http.post(uri, postParams, headers, verb)
end


