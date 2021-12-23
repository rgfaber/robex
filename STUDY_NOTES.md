# Study Notes

Based on: **Elixir in Action** (2nd ed.)

## Table of Contents

- [Study Notes](#study-notes)
    - [Table of Contents](#table-of-contents)
    - [Introduction](#introduction)
        - [Why Erlang?](#why-erlang)
            - [High Availability](#high-availability)
            - [Concurrency](#concurrency)
        - [Why Elixir?](#why-elixir)
            - [Advantages](#advantages)
            - [Disadvantages](#disadvantages)
    - [Building Blocks](#building-blocks)
        - [The interactive shell (iex)](#the-interactive-shell-iex)

## Introduction

### Why Erlang?

#### High Availability

- Responsiveness
- Scalability
- Fault Tollerance
- Distibution
- Live Update

#### Concurrency

```mono
+----------+       
|   BEAM   |
+----------+       
  |     +-----------+     +-----------+ 
  +-many| Scheduler |--one|    Core   |
        +-----------+     +-----------+         
                 |        +-----------+
                 +----many|  Process  |
                          +-----------+
```

BEAM = **B**ogdan/Bjorns **E**rlang **A**bstract **M**achine

### Why Elixir?

#### Advantages

- Code Simplification
- Composing Functions
- More readable, pleasant to code

#### Disadvantages

- Speed (built for availability, not performance)
- Relatively small ecosystem

## Building Blocks

### The interactive shell (iex)


