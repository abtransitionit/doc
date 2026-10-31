[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md


[↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic howto]:    ../howto/error.md
[logging whatis]: ../whatis/logging.md
[context whatis]: ../whatis/context.md


<div align="center">

# Langage Go — Whatis - Error

[↑ Howto][topic howto]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# Related topics

| Kind | Topic | Location |
|-|-|-|
| Whatis | [Logging][logging whatis] . [Context][context whatis]| internal |

# Definition
- aka. Error management


# Rule 1: Error Creation (Keep them lowercase, short, and unpunctuated)

Internal functions should return raw, context-free errors. 

**Never** include prefixes like `"error:"` 

**Never** duplicate the filename inside the error text if the caller already knows it.

* **❌ Bad:** `errors.New("downloading error: network timeout while downloading file2.txt")`
* **✅ Good:** `errors.New("network timeout")`
* **✅ Good:** `errors.New("connection refused")`


# Rule 2: Error Wrapping (Add context as it moves up)

When a lower-level function fails, **the caller adds** context using `fmt.Errorf` with the `%w` verb.

* **The Pattern:** `fmt.Errorf("context/action failed: %w", err)`
* **Example:** `fmt.Errorf("failed to fetch from S3: %w", err)`


# Rule 3: The "Log Once" Rule

**Never log an error and return it.** 

If a function logs an error **and** returns it up to `main`, `main` will log it again, creating duplicate log spam.

* *Workers (like `downloadFile`) should just return errors.*
* *The boundary (like `main` or your `errgroup`) should catch it and log it once.*

---

### Rule 4: Static Log Messages + Dynamic Fields

Your log message string should be a **static, unchanging constant phrase**. All variables (filenames, user IDs, error strings) must go into **structured fields**, never hardcoded into the message text.

* **❌ Bad:** `logger.Error("Failed to download file2.txt due to network timeout")`
* **✅ Good:** `logger.Error("Download failed", "file", "file2.txt", "error", err)`

---

### Putting It All Together (Production-Grade Code)

Here is how your `downloadFile`, error handling, and logger look following these clean practices:

```go
package main

import (
	"errors"
	"fmt"
	"os"
	"time"

	"golang.org/x/sync/errgroup"
)

// 1. Clean, atomic worker. Error is short, lowercase, no punctuation.
func downloadFile(filename string) error {
	time.Sleep(500 * time.Millisecond)

	if filename == "file2.txt" {
		// Just describe *what* went wrong locally. No duplicate filename.
		return errors.New("network timeout")
	}

	return nil
}

func main() {
	loggerConf := logging.Config{
		Level:   logging.LevelInfo,
		AsJSON:  true,
		Backend: logging.Zap,
	}
	logger := logging.GetLogger(os.Stderr, loggerConf)

	files := []string{"file1.txt", "file2.txt", "file3.txt"}
	var g errgroup.Group

	for _, file := range files {
		f := file
		g.Go(func() error {
			// 2. Wrap the error with high-level context (action + object)
			if err := downloadFile(f); err != nil {
				return fmt.Errorf("failed to process file: %w", err)
			}
			return nil
		})
	}

	// 3. Log ONCE at the top-level boundary, using structured fields cleanly
	if err := g.Wait(); err != nil {
		logger.Error("Batch download failed", "error", err)
		os.Exit(1)
	}

	logger.Info("All downloads completed successfully")
}

```

### What the new log output looks like:

Instead of a messy, repetitive sentence, your JSON log becomes clean, parseable, and DRY (Don't Repeat Yourself):

```json
{
  "timestamp": "2026-10-30T10:36:08.932+0100",
  "level": "ERROR",
  "caller": "rms2/main.go:167",
  "msg": "Batch download failed",
  "error": "failed to process file: network timeout"
}

```


# Todo

**managing errors**
```go
// generic
fmt.Errorf("<operation> <resource>: %w", err)

// example
fmt.Errorf("read file %q: %w", path, err)
fmt.Errorf("parse yaml %q: %w", path, err)
fmt.Errorf("open database %q: %w", dsn, err)
```
