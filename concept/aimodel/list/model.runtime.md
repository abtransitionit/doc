[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[whatis topic]: ../whatis/model.runtime.md
[whatis ollama]: ../whatis/ollama.md
[whatis llama.cpp]: ../whatis/llama.cpp.md
[whatis lm studio]: ../whatis/lmstudio.md


<div align="center">

# List ot Model Runtime
[↑ Whatis][whatis topic]

</div>




# List of inference engine

| Engine | Issue |
|---|---|
| **MLX / MLX-LM** | The positioning is accurate (Apple's official framework, independent engine)|
| **MLX / MLX-LM** | **Independent Inference Engine** | Apple's official framework, with its own model implementation and execution backend |
| **gmlx** | Apple chips | Niche/emerging, claims faster than llama.cpp in some scenarios (according to your original note, **this claim is not independently confirmed by search results**) |
| | **MLX / MLX-LM** | Mac (M-series chips) | Apple's official framework |
| **Niche / emerging** | **gmlx** | Apple chips, long context | Claims faster than llama.cpp in some cases |
| | **OpenVINO** | Intel CPUs / NPUs | Intel's optimization toolkit |
| **OpenVINO** | The positioning is accurate (Intel's inference toolkit), but note: vLLM itself can also **use OpenVINO as a backend** to run on x86 CPUs . So OpenVINO is both an independent engine and a backend that can be called by vLLM. This doesn't overturn your classification, just a level nuance. |
| **OpenVINO** | **Independent Inference Engine** | Intel's inference toolkit, with its own plugin architecture supporting Intel hardware |
| **llama.cpp** | The "CPU+GPU hybrid" description is accurate. But one point needs clarification: llama.cpp does **not** have "GGUF format" as its exclusive feature—GGUF is a format it defines, but other engines (such as OpenVINO) are also beginning to support GGUF . Writing "GGUF format" in the "Notes" column is fine, but it shouldn't imply that other engines cannot read GGUF. |
| **llama.cpp** | **Inference Engine (Engine)** | It is the engine itself | Low-level C/C++ inference engine, directly handles tensor computation, quantization, and hardware acceleration |
| [llama.cpp][whatis llama.cpp] | <li>Performance engineers</li><li>CPU inference</li><li>Edge deployment</li> | CLI / Library | <li>Underlying inference engine (many tools are based on it)</li><li>Maximum parameter control</li><li>Optimal CPU performance</li><li>Supports GGUF</li> | Yes | <li>No GUI</li><li>No model registry</li><li>Requires manual configuration of all parameters</li> |
| **vLLM / SGLang** | The positioning is accurate. Supplementary evidence: An ecosystem analysis clearly classifies vLLM/SGLang as "server-side inference engines," llama.cpp as "local/edge runtime," and Ollama as "local developer runtime built on llama.cpp/MLX" . This fully matches your table structure. |
| **vLLM** | **Independent Inference Engine** | Not based on llama.cpp; a high-throughput serving engine designed specifically for GPUs, with PagedAttention as its core |
| **SGLang** | **Independent Inference Engine** | High-performance serving framework, with its own Runtime, supporting RadixAttention, continuous batching, etc. |
| **TensorRT-LLM** | **Independent Inference Engine / Toolkit** | NVIDIA's official offering, with PyTorch as the execution backend, deeply optimized for NVIDIA GPUs |
| **Lightweight local engines** (consumer hardware) | **llama.cpp** | Running models locally on laptops/CPUs | Pure C/C++, GGUF format, CPU+GPU hybrid |
| **Enterprise serving engines** (GPU servers, many users) | **vLLM** | Production, high throughput | Open-source standard, continuous batching |
| | **SGLang** | Long contexts, complex routing | vLLM-like, specialized |
| | **TensorRT-LLM** | Max performance on NVIDIA GPUs | NVIDIA official |
| **OxiLLaMa** | Pure Rust general-purpose engine | From-scratch implementation, not wrapping llama.cpp |
| **Reflex** | Serverless cold-start scenarios | Rust/CUDA, AOT-compiled kernels, no batching, single-process design |




**OxiLLaMa**: 
- Pure Rust General-Purpose Engine
- An independent inference engine 
- implemented entirely in Rust
- Positioned as the "sovereign alternative to **llama.cpp**. 
- Supports loading GGUF models
- Has its own quantization kernels, model architectures, KV cache, and sampling implementation, and comes with an OpenAI-compatible HTTP server.
- It parses **GGUF** and executes inference from scratch in Rust.
- Has a workspace of approximately 164,000 lines of code and 3,751 tests. 

**Reflex**: 
- Cold-Start Latency Engine for Serverless Scenarios
- A Rust/CUDA inference engine 
- Focused on **cold-start latency** (time from process launch to first token)
- Explicitly targeting serverless/scale-to-zero GPU deployment scenarios.
- It is an **independent engine**, not a wrapper. 
- Its core optimization is ahead-of-time compilation of all CUDA kernels at build time, avoiding runtime JIT overhead, thereby achieving cold-start speeds approximately 1.3–3.3x faster than llama.cpp on T4 GPUs. 
- It **does not support batching or multi-tenant serving**; 
- the official documentation explicitly states "this is a single-process engine for placement behind an orchestrator".

> Note: The "Reflex" appearing in the search results is also a commercial decision model API unrelated to this engine, and a Go language internal tool package. They are not the same thing and should not be confused.

# List of runtime model

| Wrapper | Notes |
|---|---|
| **Ollama** | wraps llama.cpp (+ MLX on Mac/Apple chips) |
| **Ollama** | CLI. **Runtime / Wrapper** | **Wraps llama.cpp** | Built on top of llama.cpp, adds model management, CLI, API, and other conveniences |
| [Ollama][whatis ollama] | <li>Developers</li><li>Local API</li><li>CLI automation</li> | CLI / API | <li>Local model management and service</li><li>OpenAI-compatible API</li><li>Supports GGUF and other formats</li><li>Recent focus on coding agent integration</li> | Yes | <li>No native GUI</li><li>Steep learning curve for beginners</li> |
| [LM Studio][whatis lm studio] | <li>Non-technical users</li><li>GUI interaction</li><li>Model comparison</li> | GUI (Desktop) | <li>Visual model browser (integrated with Hugging Face)</li><li>Built-in chat</li><li>Local API server</li><li>Side-by-side model comparison</li><li>VRAM monitoring</li> | No (Free but closed source) | <li>Weaker as headless server</li><li>Lower throughput under high load compared to Ollama</li> |
| | **Ollama** | Beginners, one-command setup | Shell on top of llama.cpp |
| | **LM Studio** | Non-technical users | GUI chat app, mouse-only |
| **LM Studio** | wraps llama.cpp (+ MLX on Mac/Apple chips) |
| **LM Studio** | **GUI Application / Wrapper** | **Internally uses llama.cpp (also MLX engine)** | Desktop application, with llama.cpp as the CPU/GGUF backend underneath, plus its own MLX engine for Apple chips |
| **Jan** | **llama.cpp** (+ MLX on Apple Silicon) | Open-source ChatGPT desktop alternative, with built-in model management, chat UI, and local API server |
| **Jan** | <li>Privacy-focused</li><li>Polished desktop experience</li><li>Local + cloud hybrid</li> | GUI (Native Desktop) | <li>Supports local models (via llama.cpp)</li><li>Direct connection to cloud APIs (OpenAI, Anthropic, etc.)</li><li>Completely offline</li><li>Built-in OpenAI-compatible API</li> | Yes | <li>Smaller ecosystem</li><li>Fewer third-party integrations</li><li>Not designed for multi-user service</li> |
| **GPT4All** | **llama.cpp** (and Nomic's C backend) | Open-source desktop application, featuring built-in **LocalDocs** document RAG functionality, Python SDK |
| **GPT4All** | <li>Absolute beginners</li><li>Offline document Q&A</li> | GUI / Python SDK | <li>Out-of-the-box desktop application</li><li>Built-in **LocalDocs** feature (RAG for local files)</li><li>Simple setup</li> | Yes | <li>Desktop version has not been updated since early 2025</li><li>Project activity has significantly decreased</li> |

* **Bundled engine**: Since v0.8.5, Jan has bundled the llama.cpp engine directly in the installer, eliminating the need for separate downloads.
* **Third-party positioning**: Analysis also points out that Jan is a "frontend application with a bundled backend," with llama.cpp running underneath, 
* **Ollama** is purely a backend service that does not include a **backend**.
* **GPT4All Difference from Jan/Ollama**: The main differentiation lies in the built-in **LocalDocs** feature, which allows direct "chatting" with local documents (RAG), a capability that native Jan and Ollama do not have .
* **GPT4All**: It is a complete desktop application for running LLMs on laptops/desktops, requiring no API calls or GPUs .



# List of Multi-Engine Orchestration Layer

| Type | Tool | Relationship with Inference Engines | Notes |
|---|---|---|---|
| **Orchestration/Runtime Layer** | **LocalAI** | **Does not bind to a single engine; dynamically calls multiple engines** | Exposes OpenAI API, installs backends on demand (llama.cpp/vLLM/MLX, etc.), core is very small, backends are independent gRPC services |

- **LocalAI** is different from **Jan**, **GPT4All**, and **Ollama**.
- **It is not a "chat application" directly facing end users, but rather an "AI stack" or "unified scheduling layer"**
— it does not bind to a single inference engine, but can dynamically call various engines as "backends" (such as llama.cpp, vLLM, MLX, etc.) and expose them uniformly as an OpenAI-compatible API.
- **Official definition**: LocalAI is a "composable AI stack" whose core is a small binary that speaks OpenAI/Anthropic APIs, while each model backend is installed on demand and runs as an independent gRPC service.
- **Backend list**: Its official compatibility table explicitly lists **llama.cpp, vLLM, SGLang, MLX, transformers** and many other engines as its backends. This means it **does not manufacture its own engines**, but wraps existing engines.
- **Difference from Ollama**: Ollama is essentially a wrapper around llama.cpp (+MLX); LocalAI, however, is a **general-purpose scheduler** that can switch between different engines based on model type (text, speech, image, video).

**In short**: If Ollama is a "car dedicated to the llama.cpp engine," then LocalAI is a "car chassis that can be fitted with different engines (llama.cpp/vLLM/MLX) as needed," and additionally provides a complete OpenAI-compatible API and Web UI.

### Summary

1. **GGUF** was crerated by llama.cpp exclusive and has become the de facto widely uses format to bundle AI model for distribution.
1. **GGML**





| Tool | Positioning & Best For | Interface Type | Core Features & Model Support | Open Source Status | Key Limitations |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **LocalAI** | <li>OpenAI API drop-in replacement</li><li>Multi-modal</li><li>Team migration</li> | API / Web UI | <li>Single API supports text, audio, images, embedding and other multi-modal capabilities</li><li>Composable backend architecture (llama.cpp, vLLM, etc.)</li> | Yes | <li>More complex configuration than Ollama</li><li>Pure text inference performance may not be as good as dedicated tools</li> |






| Category | Tool | Best for | Notes |
|---|---|---|---|
| | **OxiLLaMa / Reflex** | Rust-purists, fast cold start | Written in Rust |

**Quick rule of thumb:** personal machine → **Ollama** or **LM Studio**; serving many users → **vLLM**.
### How to Choose Based on Your Needs

You can make a quick decision based on your primary usage scenario:

*   **If you need to integrate AI capabilities in code or scripts**: **Ollama** is the most convenient choice, providing a clean API and CLI . If you need extreme performance control or run on pure CPU, consider directly using **llama.cpp** .
*   **If you want to click around like using ChatGPT and compare models**: **LM Studio** provides the most polished graphical experience, with built-in model downloads and side-by-side comparison features .
*   **If you are extremely concerned about privacy and want to switch between local and cloud models in the same interface**: **Jan**'s design philosophy fits this perfectly, completely offline and supports connecting to cloud APIs .
*   **If you just want to quickly upload a document and ask questions**: **GPT4All**'s LocalDocs feature is the simplest to get started with, but note that its development activity is low .
*   **If you want to build a service compatible with OpenAI API**: **LocalAI** is the most comprehensive functional choice, supporting multiple modalities, but the cost is slightly more complex configuration .





