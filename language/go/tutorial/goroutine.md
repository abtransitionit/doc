[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]: ../whatis/build
[package whatis]: ../whatis/build


<div align="center">

# Langage Go — Tutorial - Goroutine

[↑ Whatis][topic whatis]

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Whatis | [Package][package whatis]| internal |


# Sequential download
```go
import (
    "fmt"
    "time"
)


func downloadFile(filename string) error {
	fmt.Printf("dld: Starting download: %s ...\n", filename)

    // Simulate file download with sleep
	time.Sleep(time.Duration(0.5 * float64(time.Second)))
	
    // Simulate a failure for "file2.txt" to test error handling
	if filename == "file2.txt" {
		return errors.New("network timeout")
	}
	fmt.Printf("dld: Finished download: %s ... done\n", filename)
	return nil
}


func main() {
    fmt.Println("Starting downloads...")

    startTime := time.Now()

    downloadFile("file1.txt")
    downloadFile("file2.txt")
    downloadFile("file3.txt")

    elapsedTime := time.Since(startTime)

    fmt.Printf("All downloads completed! Time elapsed: %s\n", elapsedTime)
}
```

output
```
Starting downloads...
Starting download: file1.txt
Finished download: file1.txt
Starting download: file2.txt
Finished download: file2.txt
Starting download: file3.txt
Finished download: file3.txt
All downloads completed! Time elapsed: 6.003792083s
```

**Meaning**

- `downloadFile()`: 
    - **intent**: download a file
- `main()` 
    - **intent**: orchestrate the download of several file in sequence
    - **how**
        - call `downloadFile()` in sequence
        - ends
- **notes**
    - `main()` is the parent of goroutines
    - all call are done in sequence 
    - ✅ `main()` ends and all files are download
    - `time.Sleep(1 * time.Second)` works only with integer
    - `time.Sleep(time.Duration(0.5 * float64(time.Second)))` works also with decimal

# Concurent download - the naive way

```go
func main() {
    fmt.Println("Starting downloads...")

    // Launch downloads concurrently
    go downloadFile("file1.txt")
    go downloadFile("file2.txt")
    go downloadFile("file3.txt")

    fmt.Println("All downloads completed!")
}
```

**Meaning**:
- `downloadFile()`: 
    - **intent**: download a file
- `main()` 
    - **intent**: orchestrate the download of several file in parallel
    - **how**
        - call `downloadFile()` in parallel
        - run other instruction and ends
- **notes**
    - `main()` is the parent of goroutines
    - ❌ `main()` ends before all goroutines finished


# Concurent download - the std way

```go
func main() {
    fmt.Println("Starting downloads...")

    // declare a counter of goroutines that should run concurently
	var wg sync.WaitGroup

    // define the counter
	wg.Add(3)


    // Launch goroutine concurrently
    go func { downloadFile("file1.txt"); wg.Done }()
    go func { downloadFile("file2.txt"); wg.Done }()
    go func { downloadFile("file3.txt"); wg.Done }()

	// the runtime block here until wg = 0
	wg.Wait()


    fmt.Println("All downloads completed!")
}
```

**Note**:
- `go func {...}()` is an anonymous goroutine that takes no ragument
- each goroutine executes its instructions sequentially
- `wg.done`: runtime decrement `wg` by one each time a goroutine finished


# Concurent download - the better way level 1

```go
func main() {
    fmt.Println("Starting downloads...")

    // tells main to wait for all downloads to finish
	var wg sync.WaitGroup

    // Nb of download to wait
	wg.Add(3)


    // Launch downloads concurrently - wg.done decrement wg by one each time a goroutine finished
    go func { defer wg.Done; downloadFile("file1.txt") }
    go func { defer wg.Done; downloadFile("file2.txt") }
    go func { defer wg.Done; downloadFile("file3.txt") }

	// the runtime block here until wg = 0
	wg.Wait()


    fmt.Println("All downloads completed!")
}
```
**Note**:
- `defer wg.done`: is executed at the end even if `downloadFile()` panics or failed

# Concurent download - the better way level 2

```go
func main() {
    fmt.Println("Starting downloads...")
	files := []string{
		"file1.txt",
		"file2.txt",
		"file3.txt",
	}

	// define a counter of goroutines
	var wg sync.WaitGroup

	// set the counter to the number of goroutine
	wg.Add(len(files))

	fmt.Println("main: Starting downloads...")
	startTime := time.Now()
	// Launch downloads concurrently
	for _, file := range files {
		go func(f string) { // anonymous accepts an arguments that will be passed to the wrapped method
			defer wg.Done() // go runtime decrement the counter when the goroutine completes - even if downloadFile panics
			downloadFile(f) // Existing function, unchanged
		}(file)
	}

	// go runtime blocks here until the counter reaches 0
	wg.Wait()

	elapsedTime := time.Since(startTime)
	fmt.Printf("main: All downloads completed! Time elapsed: %s\n", elapsedTime)
}
```
**Note**:
- `defer wg.done`: is executed at the end even if `downloadFile()` panics or failed

# Concurent download - 

```go
func main() {
    fmt.Println("Starting downloads...")
	files := []string{
		"file1.txt",
		"file2.txt",
		"file3.txt",
	}

	// Declare an error group to manage goroutines
	var g errgroup.Group


	fmt.Println("main: Starting downloads...")
	startTime := time.Now()
	// Launch downloads concurrently
	for _, file := range files {
        // Capture the loop variable safely for the closure
		f := file
        // g.Go automatically handles wg.Add(1), defer wg.Done(), and error interception
		g.Go(func() error {return downloadFile(f)})
	}

    if err := g.Wait(); err != nil {
		fmt.Printf("A download failed: %v\n", err)
		return
	}
	elapsedTime := time.Since(startTime)
	fmt.Printf("main: All downloads completed! Time elapsed: %s\n", elapsedTime)
}
```

**Note**:
- `g.Go` automatically handles `wg.Add(1)`, `defer wg.Done()`, and catches returned `errors`
- `g.Wait` blocks until all goroutines finish
- `g.Wait` returns the *first* non-nil error encountered by any task
