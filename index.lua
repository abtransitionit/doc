content("text/html")

local f = io.open("README.md", "r")

if not f then
    status(404)
    print("<h1>README.md not found</h1>")
    return
end

local md = f:read("*a")
f:close()

print(markdown(md))