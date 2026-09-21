[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Tool][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[algernon whatis]: https://github.com/xyproto/algernon
[algernon git]:    https://github.com/akumansley/aft

Related topics

| Topic | Location | Kind    |
| - | - | - |
|[algernon on github][algernon git]|external| 

**Document's status**
- Early stage.
- The project is currently being defined (concepts, architecture, ...)

<h1 align="center">What is Algernon</h1>


# Definition
- written in go
- a webserver for `markdown` files
- renders Markdown files, HTML, and JSX on-demand.
- is configurable via Lua scripts



# How it works

gemini response:

* Algernon does not load all `.md` files into memory by default.
* **On-Demand Rendering:** When a request comes in for a specific Markdown file, Algernon reads it **from disk**, processes it, and renders it to HTML.
* **Optional Caching:** Algernon provides options to cache rendered pages or static assets in memory (or in a built-in database like BoltDB / Redis) to speed up response times, but it does not pre-load or hold the entire directory of `.md` files in RAM just to operate.
* **Low Footprint:** Because it processes files dynamically and only caches as configured, it maintains a very small memory footprint.
