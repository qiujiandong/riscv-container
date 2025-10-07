# RISCV Container

[![Build rvgnu Docker Image](https://github.com/qiujiandong/riscv-container/actions/workflows/rvgnu.yml/badge.svg)](https://github.com/qiujiandong/riscv-container/actions/workflows/rvgnu.yml)

## Workflow

How I update the `rvgnu` docker image in this repo?

1. Every a period of time, I'll build the tools manually and upload them to
the release page with the version number.
2. I'll maintain the default tools' version in `Dockerfile` to keep them
as latest as posible.
3. The tags on `main` branch will note github workflow to build the image with
dedicated version.
