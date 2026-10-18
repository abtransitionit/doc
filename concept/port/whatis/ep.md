[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[port howto]:   ../howto/ep.md
[socket whatis]: /resource/socket/whatis/ep.md


Related topics

| Topic | Location | Kind |
|-|-|-|
|[Ho-to for Port][port howto]|see|
|[What is a Socket][socket whatis]|see|






<h1 align="center">What is a Port</h1>

The concept of Port

# Definition

## Network namespace
- An isolated instance of a network stack view/value
- Contains its own **interfaces**, **IP addresses**, **routing table**, and **ports**. 

## Port
- Works only in TCP/UDP transport layer.
- A **16-bit number** (0–65535) in the TCP or UDP header of a packet.
- Allows to distinguish services on a host.
- Tells the network stack which service should receive the traffic.
- Is used to route packet are to the correct service.
-  
**Port = logical number that 


## Service
- A process/daemon on a host
- Can use multiple sockets
- Listens for incoming traffic/request/connections/packets (TCP or UDP)
- Binds to a socket
- Uses that Socket as its communication endpoint to send/receive data/request.
- **Example**
  - `nginx` service listens both `0.0.0.0:80/TCP` and `0.0.0.0:443/TCP`
  - **DNS** service listens on both `53/TCP` and port `53/UDP` → two sockets, often two handlers



# Kind
- ephemeral
- client or server
- well known

# Terminology

 | Term | Description |
 |-|-|
 | IP address | <li>Identify a host|
 | Port       | <li>16-bit number <li>Identify a service|
 | Protocol   | <li>TCP or UDP <li>Identify the kind of communication             |
 | Socket     | <li>IP + port + protocol <li>Identify a uniq service on a host          |
 | ENDPOINT   | sysnonym for SOCKET                           |
 | Process    | the program bound to the socket               |
 | Service    | a process LISTENING on a socket               |
 
## Summary diagram


```
                         HOST  (network namespace)
                         e.g. 192.168.1.10
 ┌──────────────────────────────────────────────────────────────┐
 │                                                              │
 │   IP ADDRESS                PROTOCOL            PORT         │
 │   192.168.1.10              TCP                 :80          │
 │        │                      │                   │          │
 │        └──────────────┬───────┴───────────────────┘          │
 │                       ▼                                      │
 │                  ┌─────────┐                                 │
 │                  │ SOCKET  │  = IP + port + protocol         │
 │                  │192.168. │     (the ENDPOINT)              │
 │                  │1.10:80/ │                                 │
 │                  │TCP      │                                 │
 │                  └────┬────┘                                 │
 │                       │ bound to                             │
 │                       ▼                                      │
 │                  ┌─────────┐                                 │
 │                  │ PROCESS │  (the SERVICE, listening)       │
 │                  │ nginx   │                                 │
 │                  └─────────┘                                 │
 │                                                              │
 └──────────────────────────────────────────────────────────────┘
```
> ⚠️ Only one process can listen on the same socket at a time. 

```
   127.0.0.1:3000/TCP   ──▶  socket A  ──▶  process X   (e.g. a TCP server)
   127.0.0.1:3000/UDP   ──▶  socket B  ──▶  process Y   (e.g. a UDP server)
        ▲
        └── same IP, same PORT, different PROTOCOL → Identify different sockets, no conflict
            
```

```
   CLIENT                                          SERVER
 ┌───────────────┐                             ┌───────────────┐
 │ client socket │  ──── request ──────────▶  │ server socket │
 │ 10.0.0.5:54321│                             │ 192.168.1.10  │
 │      /TCP     │  ◀─── response ──────────   │     :80/TCP   │
 └───────────────┘                             └───────────────┘
     ephemeral                                    listening
     (temporary)                                  (a service)
```     
1. **Agent** opens `http://192.168.1.10` (browser, CLI)
1. **Agent** as a client creates a local client socket, e.g. `10.0.0.5:54321/TCP`
1. The client socket connects to the server socket.
1. The connection is then identified by the **pair** (client socket  ,  server socket)

> ⚠️ A socket is a communication endpoint use both by a **Client** and a **Server**







