[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md


[↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic howto]:   ../howto/logging.md
[error whatis]: ../whatis/error.md
[context whatis]: ../whatis/context.md

<div align="center">

# Langage Go — Whatis - Logging

[↑ Howto][topic howto]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Whatis | [Error][error whatis] . [Context][context whatis]| internal |

# Definition
- aka. logging management

# When NOT to pass a logger (Keep it at the Caller Level)

Business logic functions should ideally be "dumb" and know nothing about logging. their signatures to **should not** accept a logger.

**What it is:** Pure business logic, data transformers, or **atomic tasks**. Example: 
- `downloadFile`
- `parseJSON`
- `calculateTax`

**Why:** 
- If `downloadFile` takes a logger, it becomes tightly coupled to *how* you log. 
- What if tomorrow you switch logging libraries? 
- What if you want to reuse `downloadFile` 
    - in a CLI tool (print to stdout) 
    - in a web server (JSON logs)? 
- What if you want to test it without generating log files?

**How to log instead:** 
- Do it at the **orchestrator level**. Example:
 -  inside your `errgroup` loop or wrapper

```go
// downloadFile stays clean and unchanged
g.Go(func() error {
    logger.Info("Starting download", "file", f) // Logger lives outside
    err := downloadFile(f)
    if err != nil {
        logger.Error("Failed", "error", err)
        return err
    }
    return nil
})

```

# When TO pass a logger (Dependency Injection)

Pass a logger (or a logger interface) into a function in when:

**It’s a Service / Component Orchestrator:** A struct method that manages a complex workflow spanning multiple steps. Example
    - `PaymentService.ProcessCheckout()`

**It needs internal milestones:** 
- The function is long-running
- The function performs multiple internal steps where logging *inside* the function body is critical for debugging. Example:
    - step 1 succeeded, connecting to retry pool, ...

If you do need to pass a logger to a service struct, the idiomatic Go way is to inject it **via the constructor (`New...`)**:

```go
type DownloaderService struct {
    logger *logging.Logger
    client *http.Client
}

// Inject the logger once when creating the service
func NewDownloaderService(logger *logging.Logger) *DownloaderService {
    return &DownloaderService{logger: logger}
}

func (s *DownloaderService) Download(filename string) error {
    s.logger.Info("Starting internal download step", "file", filename)
    // ... logic ...
    return nil
}

```


# Summary Checklist

| Function Type | Should it take a logger? | Where to log? |
| --- | --- | --- |
| **Atomic Workers / Helpers** (`downloadFile`, `parseRow`) | **No.** Keep signatures clean. | At the caller level (around the function call). |
| **Service Structs / Orchestrators** (`UserService`, `PipelineManager`) | **Yes.** Inject it via the constructor (`New...`). | Inside the methods as it moves through states. |

