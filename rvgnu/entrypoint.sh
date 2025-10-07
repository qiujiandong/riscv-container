#!/bin/bash

set -e

riscv64-unknown-elf-gcc --version
qemu-riscv32 --version
qemu-riscv64 --version

exec "$@"
