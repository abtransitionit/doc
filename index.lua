-- Tell Algernon that the response we're going to send is HTML.
-- The browser will therefore interpret the result as a web page.
content("text/html; charset=utf-8")


local f = io.open("README.md", "r")

if not f then
    status(404)
    print("<h1>README.md not found</h1>")
    return
end

local md = f:read("*a")
f:close()

print(markdown(md))