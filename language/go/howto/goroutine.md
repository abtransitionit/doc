[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md


[↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]:   ../whatis/goroutine.md


<div align="center">

# Langage Go — Howto - Goroutine

[↑ Whatis][topic whatis]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Topic | Location | Kind |
|-|-|-|

# Basic Usage

```go
func main() {
    fmt.Println("A")

    go sayHello() // asynchronous

    fmt.Println("B")
}

func sayHello() {
    time.Sleep(2 * time.Second)
    fmt.Println("Hello")
}
```

**Meaning**
- `sayhello()`: a function that has a job to do
- `main()`: the parent of `sayhello()`
- `main()`: 
    - launch `sayhello()`
    - immediatly after launch other instructions
    - ends ... 
    - Maybe `sayHello()` has not finished is job ⇒ `sayHello()` is killed as parent ends


