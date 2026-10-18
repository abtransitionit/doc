[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Resource][home domain] · [↖ Doc][home doc]

[//]: #(Reference)
[port whatis]: /concept/port/whatis/ep.md

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a port][port whatis]|see|

<h1 align="center">What is A Socket</h1>

The conspet of Socket

## Definition
- A communication endpoint
- Can be shared by multiple processes (with `SO_REUSEPORT`, or accept-forking)
- Sockets exist without being services
a client connection's socket is not a service
- identified by the tuple (`IP:Port:Protocol`)
- Example:
  - 192.168.1.10:80/TCP
  - 127.0.0.1:3000/TCP
  - a client connection's socket is not a service

# Definition
- A kernel object
- Represented to a process as a file descriptor (fd, an integer)
- Process can read/write to the socket
- Manipulated through system calls (ie. operation: socket, bind, listen, connect, send, recv…)

## Operation
```
int fd = socket(AF_INET, SOCK_STREAM, 0);   // create a socket
bind(fd, ...);                              // attach IP+port
listen(fd, ...);                            // (server) listen
accept(fd, ...);                            // (server) accept a connection
connect(fd, ...);                           // (client) connect
send(fd, ...); recv(fd, ...);               // exchange data
close(fd);
```