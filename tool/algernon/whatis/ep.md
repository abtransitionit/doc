[//]: #(home)
[home set]: ../../README.md
[home doc]:     ../../../README.md

[↖ Tool][home set] · [↖ Doc][home doc]

[//]: #(doc)


Related topics

| Topic                                            | Location | Kind    |
| ------------------------------------------------ | -------- | ------- |

**Document's status**
- Early stage.
- The project is currently being defined (concepts, architecture, ...)

<h1 align="center">What is Algernon</h1>


# Definition
- written in go
- a webserver for `markdown` files
- renders Markdown files, HTML, and JSX on-demand.
- is configurable via Lua scripts




# List
- https://github.com/xyproto/algernon : render `.md` files


# How it works

gemini response:

* Algernon does not load all `.md` files into memory by default.
* **On-Demand Rendering:** When a request comes in for a specific Markdown file, Algernon reads it **from disk**, processes it, and renders it to HTML.
* **Optional Caching:** Algernon provides options to cache rendered pages or static assets in memory (or in a built-in database like BoltDB / Redis) to speed up response times, but it does not pre-load or hold the entire directory of `.md` files in RAM just to operate.
* **Low Footprint:** Because it processes files dynamically and only caches as configured, it maintains a very small memory footprint.
