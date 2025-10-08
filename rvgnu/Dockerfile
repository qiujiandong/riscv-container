FROM ubuntu:24.04

ARG PREBUILT_TOOLS_TAG=2025.09.28

LABEL org.opencontainers.image.source=https://github.com/qiujiandong/riscv-container
LABEL org.opencontainers.image.description="An image with RISC-V GNU GCC newlib toolchain and QEMU"
LABEL org.opencontainers.image.licenses="Apache-2.0"

WORKDIR /wksp
VOLUME ["/wksp"]

# copy entrypoint.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# install dependencies
RUN DEBIAN_FRONTEND=noninteractive TZ=Asia/Shanghai \
    apt-get update && \
    apt-get install -y \
    wget \
    xz-utils \
    libdw-dev \
    libglib2.0-dev \
    && rm -rf /var/lib/apt/lists/*

# add riscv toolchain
ENV PREBUILT_TOOLS_ROOT=/opt/riscv
ENV PATH=${PREBUILT_TOOLS_ROOT}/bin:$PATH
RUN mkdir -p ${PREBUILT_TOOLS_ROOT} && \
    wget -qO- -L https://github.com/qiujiandong/riscv-container/releases/download/v1.0.0-rc/prebuilt_tools_${PREBUILT_TOOLS_TAG}.tar.xz | \
    tar -xJvf - -C ${PREBUILT_TOOLS_ROOT} --strip-components=1

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD ["/bin/bash"]
