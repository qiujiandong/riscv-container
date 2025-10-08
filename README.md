# RISC-V Container

[![Build rvgnu Docker Image](https://github.com/qiujiandong/riscv-container/actions/workflows/rvgnu.yml/badge.svg)](https://github.com/qiujiandong/riscv-container/actions/workflows/rvgnu.yml)

This repository hosts Docker images for RISC-V development, aiming to simplify
CI testing in GitHub Actions. The toolchain is primarily built from the
[riscv-gnu-toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain).
Currently, only the [rvgnu](https://github.com/qiujiandong/riscv-container/pkgs/container/rvgnu)
image is supported.

## RVGNU

`rvgnu` includes tools built from the [riscv-gnu-toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain).

### Tools Included

The `rvgnu` image tagged as `v0.1.x` is based on the
[2025.09.28](https://github.com/riscv-collab/riscv-gnu-toolchain/tree/2025.09.28)
tag of `riscv-gnu-toolchain`.

| Tool | Version |
|------|---------|
| GCC newlib toolchain | 15.1.0 |
| qemu-riscv32/qemu-riscv64 | 10.1.0 |

### Design Philosophy

> Concise and independent from specific hardware.

The GCC `newlib` toolchain is often used in bare-metal environments. Compared
to `glibc` or `musl`, `newlib` is smaller. However, running on bare-metal
requires implementing system calls for specific hardware.  
Linux environments, on the other hand, are hardware-agnostic, making them a
better choice for CI testing.  
But is it possible to build with `newlib` GCC and run on Linux? Yes! `libgloss`
provides default implementations for some system calls, enabling the use of
`newlib` GCC while running on Linux.

### Building the Tools

To build the tools, check out the desired tag:

```shell
cd riscv-gnu-toolchain
git checkout <tag>
```

Then, follow these steps to build and archive the tools:

```shell
./configure --prefix=`pwd`/riscv --enable-multilib --enable-strip
make -j all build-qemu
tar -cJvf ../prebuilt_tools_$(git describe --tags --exact-match 2>/dev/null).tar.xz riscv
```

### Workflow Overview

1. Periodically, I manually build the tools and upload them to the
[release page](https://github.com/qiujiandong/riscv-container/releases/tag/v1.0.0-rc),
using the corresponding tag from `riscv-gnu-toolchain`.
2. I update the tool URLs (specifically the tool tags) in the `Dockerfile` to
ensure they remain up-to-date.
3. The latest version of `rvgnu` is based on the most recent commit in the
`main` branch.
4. If the latest commit in the `main` branch has a tag in the format `v*.*.*`,
the Docker image will also be tagged with the same version.
