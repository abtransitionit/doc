[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[whatis llama ext]: https://github.com/ggml-org/llama.cpp
[whatis ollama]: ./ollama.md
[whatis lm studio]: ./lmstudio.md
[whatis inference engine]: ../whatis/model.runtime.md
[whatis gguf]: ../whatis/gguf.md
[whatis runtime model]: ../whatis/model.runtime.md
<div align="center">

# What is llama.cpp

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Whatis | [Runtime Model][whatis runtime model] . [Inference Engine][whatis inference engine] . [GGUF][whatis gguf] | internal |
| Whatis | [llama.cpp][whatis llama ext] | external |

# Definition
- Low-level [inference engine][whatis inference engine]
- Written in C/C++
- Responsible for the actual computation. 
- core engine of the following tools (aka. [runtime model][whatis runtime model]):
    - [Ollama][Whatis ollama]
    - [LM Studio][Whatis lm studio]
