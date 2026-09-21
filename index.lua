-- `content(...)` is an Algernon function that tells the web server what type of content we are going to send to the browser. 
--
-- `"text/html"` means that the content is HTML. 
-- `"charset=utf-8"` tells the browser that the text uses UTF-8 encoding. 
--
-- the browser will interpret this content as a web page and render it accordingly.
content("text/html; charset=utf-8")

-- Creates a local variable
-- If the file is successfully opened, `f` contains the file handle that we can use to read the file.
-- If it cannot be opened, `f` will be nil.
local f = io.open("README.md", "r")

-- Return a 404 page if the f does not contain a valid value
if not f then
    -- `status(...)` is an Algernon function.
    status(404)
    -- `print(...)` is an Algernon function that sends text to the HTTP response.
    print([[
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="utf-8">
        <title>404 - Not Found</title>
    </head>
    <body>
        <h1>README.md not found</h1>
        <p>The requested README.md file could not be found.</p>
    </body>
    </html>
    ]])
    -- print("<h1>README.md not found</h1>")
    return
end

-- Read the entire Markdown file
-- `f:read("*a")` calls the `read()` method on the file represented by `f`
-- `*a` means "read all the file".
local md = f:read("*a")

-- We no longer need the file because we have already read all of its contents into the `md` variable. 
-- Closing the file releases the resources used to keep it open.
f:close()
-- `markdown(..)` takes the Markdown text stored in `md` and converts it into HTML.
print(markdown(md))