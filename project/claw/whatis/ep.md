[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Project][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[claw howto]: ../howto/ep.md

Related topics

| Topic | Location | Kind |
|---|---|---|
|[How-to for OpenClaw][claw howto]|axternal|


<h1 align="center">Project: Claw</h1>

An Agent using openClaw


# Terminology

## Skill

- Tell the agent how and when to use a tool.

## AI provider

## OpenClaw's workspace/Gateway

- Essentially the central OpenClaw process.
- Manages OpenClaw's sessions, tools, events, and connections to messaging channels.
- an AI assistant that lives on your VPS.
- Unlike **ChatGPT** in a browser, It can be connected to your computer and tools.
```
VM  → OpenClaw → Gateway → AI + tools + connections
You → OpenClaw → AI → Does things on your VPS
```

# Eample of actions
Think of OpenClaw as **an AI assistant that lives on your VPS**.

* read and write files
* run commands
* use programs/tools
* automate tasks
* interact with messaging apps
* keep working through its Gateway

# Eample of automation

- Create a folder called `project` and put my files in it.
- Check this server every day and tell me if something is wrong.

# Security

- OpenClaw can have **access to the VM as root**, 
- giving it powerful permissions means you're effectively giving an AI the ability to operate that VM.

```text
ChatGPT in a browser  → mostly talks to you
OpenClaw on your VPS  → AI + access to your machine/tools
```

#  the mental model

- an AI employee sitting inside your server.
- Given configuration, instructions, tools and permissions : **do work instead of merely telling you how to do it** 
- The exact things it can do depend heavily on 
  - permissions
  - integrations
  - AI provider
  - tools you give it

# Question:
## When you give OpenClaw a tool, how does he know how to use it ?  

- Give hime the source code and that 's all
**You give the AI a tool + instructions for that tool.**

For example, imagine you give OpenClaw a tool called `send_email`.

You also give it a description like:

```text
Tool: send_email

Purpose:
Send an email.

Inputs:
- recipient
- subject
- message
```

Then the AI sees something like:

> "I have a tool called `send_email`. It needs a recipient, subject, and message."

So if you say:

> "Email John and tell him I'll be late."

The AI figures out:

```text
recipient = John
subject = ...
message = "I'll be late."
```

and asks the tool to do it.

### The important idea

The AI **doesn't magically know how every tool works**.

It's more like:

```text
        TOOL
          ↑
   instructions
   + what it accepts
          ↑
         AI
          ↑
       your request
```

The **tool description/API definition** tells the AI:

* what the tool does
* when to use it
* what information it needs
* what format to provide that information

Then the AI decides **when and how to call it**.

### An even simpler analogy

Imagine giving someone a **hammer**.

You don't need to explain what a hammer is every time.

You say:

> "Here's a hammer. Use it to drive nails."

Then you say:

> "Build me a shelf."

They understand that the hammer might be useful.

**OpenClaw works similarly, except the "tools" are software functions.**


