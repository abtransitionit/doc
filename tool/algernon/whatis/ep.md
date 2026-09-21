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


# What does "serves a directory" mean for algernon?

- It means **Algernon uses that directory as the root of the web server**.

## Use case

**the folder tree**

```text
your filesystem                    web server

~/Projects/my-project/             /
       │                            │
       ├── README.md        →       /README.md
       ├── foo.lua          →       /foo.lua
       │
       ├── docs/            →       /docs/
       │     ├── guide.md   →       /docs/guide.md
       │     └── example.lua →      /docs/example.lua
       │
       └── images/          →       /images/
             └── logo.png   →       /images/logo.png
```

```bash
# from ~/Projects/my-project/
algernon -a -e -q .
```
Meaning:
- Start the web server here
- make this directory the place from which you serve/execute files
- `.` isn't saying: Serve only this one Lua script
- `.` is saying:    Use this directory and its contents as the web application's directory

# How links works
- If you click a link to a `.md` file, **Algernon receives the request for that `.md` file**.
- If there is also a `.lua` file in the same folder, **nothing special happens just because the Lua file is there**.

For example:

```text
docs/
├── guide.md
└── guide.lua
```

**Visiting/Clicking**:

```text
/docs/guide.md
```

asks Algernon for **`guide.md`**.

It does **not** automatically run `guide.lua`.

The `.lua` file would only be involved if the requested URL maps to that Lua handler according to Algernon's routing/handler rules.

**Visiting/Clicking**:

```text
/docs/guide.lua
```

asks Algernon for **`guide.lua`**.


The `.lua` file is executeded and sends whatever that Lua script outputs.

### The special case: `index.lua`

This is the important one for your setup.

If a directory contains:

```text
docs/
├── index.lua
├── guide.md
└── other.md
```

and you visit:

```text
/docs/
```

Algernon automatically uses:

```text
/docs/index.lua
```

as the handler for that directory. `index.lua` is a special filename in Algernon.

So, very simply:

```text
URL                       What Algernon does

/docs/                    → runs docs/index.lua
/docs/guide.md            → renders guide.md
/docs/guide.lua           → runs guide.lua
/docs/other.md            → renders other.md
```

- `index.lua` is special because it handles the directory itself.


