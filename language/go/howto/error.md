[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md


[↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]:   ../whatis/error.md
[logging howto]:   ../howto/logging.md


<div align="center">

# Langage Go — Howto - Error

[↑ Whatis][topic whatis]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Howto | [Logging][logging howto]| internal |


**managing errors**
```go
if err := downloadFile(f); err != nil {
    return fmt.Errorf("failed to process file: %w", err)
}
```

**managing errors**
```go
// generic
fmt.Errorf("<operation> <resource>: %w", err)

// example
fmt.Errorf("reading file %q: %w", path, err)
fmt.Errorf("parsing yaml %q: %w", path, err)
fmt.Errorf("opening database %q: %w", dsn, err)
```
