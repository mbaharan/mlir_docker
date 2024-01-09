FROM ubuntu:latest as builder
USER root
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y build-essential
RUN apt-get install -y python-pip
RUN apt-get install -y autoconf
RUN apt-get install -y make
RUN apt-get install -y autoconf
RUN apt-get install -y flex
RUN apt-get install -y bison
RUN apt-get install -y libfl2 # (CIRCT)
RUN apt-get install -y libfl-dev # (CIRCT)
RUN apt-get install -y git
WORKDIR /workdir
ENV HOME=/workdir

# 1) Install packages.
ENV PATH=$PATH:/workdir/bin
RUN apt-get update
RUN apt-get install -y python3-numpy
RUN apt-get install -y python3-pip
RUN python3 -m pip install --upgrade pip
RUN apt-get install -y gdb
RUN apt-get install -y lldb

# 2) Instal optional packages, comment/uncomment/add as you see fit.
RUN apt-get install -y vim
RUN apt-get install -y emacs
RUN apt-get install -y valgrind
RUN apt-get install -y libeigen3-dev
RUN apt-get install -y clang-format
RUN python3 -m pip install wheel
RUN python3 -m pip install numpy
RUN python3 -m pip install torch>=2.0.0+cpu torchvision>=0.15.1+cpu -f https://download.pytorch.org/whl/torch_stable.html
RUN git clone https://github.com/onnx/tutorials.git
# Install clang
RUN apt-get install -y lsb-release wget software-properties-common
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
# For development
RUN apt-get install -y ssh-client

# 3) When using vscode, copy your .vscode in the Dockerfile dir and
#    uncomment the two lines below.
# WORKDIR /workdir/.vscode
# ADD .vscode /workdir/.vscode

# 4) When using a personal workspace folder, set your workspace sub-directory
#    in the Dockerfile dir and uncomment the two lines below.
# WORKDIR /workdir/workspace
# ADD workspace /workdir/workspace

# 5) Fix git by reattaching head and making git see other branches than main.
# WORKDIR /workdir/onnx-mlir
# Add optional personal fork and disable pushing to upstream (best practice).
# RUN git remote add origin https://github.com/<<user>>/onnx-mlir.git
# RUN git remote set-url --push upstream no_push
