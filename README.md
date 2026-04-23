# cat

A minimal implementation of the Unix `cat` utility written in Zig — a learning project for getting familiar with the language.

## What it does

Reads one or more files and prints their contents to stdout. File open errors are reported to stderr and skipped; the program continues with remaining arguments.

## Build

```sh
zig build
```

The binary is placed at `zig-out/bin/cat`.

## Usage

```sh
./zig-out/bin/cat file1.txt file2.txt
```

## Build options

| Option | Default | Description |
|---|---|---|
| `-Dreader-buffer-size=N` | `1024` | Read buffer size in bytes |
| `-Dwriter-buffer-size=N` | `1024` | Write buffer size in bytes |

Example:

```sh
zig build -Dreader-buffer-size=4096 -Dwriter-buffer-size=4096
```
