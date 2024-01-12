FROM ubuntu:latest as builder

# 1) Install packages.
USER root
RUN echo "nameserver 4.2.2.4" > /etc/resolv.conf 
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y build-essential
RUN apt-get install -y python-pip
RUN apt-get install -y autoconf
RUN apt-get install -y make
RUN apt-get install -y autoconf
RUN apt-get install -y flex
RUN apt-get install -y bison
RUN apt-get install -y git
RUN apt-get install -y sudo
RUN apt-get install -y python3-numpy
RUN apt-get install -y python3-pip
RUN apt-get update
RUN apt-get install -y gdb
RUN apt-get install -y lldb
RUN apt-get install -y vim
RUN apt-get install -y nano
RUN apt-get install -y emacs
RUN apt-get install -y valgrind
RUN apt-get install -y libeigen3-dev
RUN apt-get install -y clang-format
RUN apt-get install -y openssh-server
# For (CIRCT)
RUN apt-get install -y libfl2 
RUN apt-get install -y libfl-dev

# Python packages
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install wheel
RUN python3 -m pip install numpy
RUN python3 -m pip install torch>=2.0.0+cpu torchvision>=0.15.1+cpu -f https://download.pytorch.org/whl/torch_stable.html

# Install clang
RUN apt-get install -y lsb-release wget software-properties-common
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
# For development
RUN apt-get install -y ssh-client

# Setting up developer user
ENV DEBIAN_FRONTEND noninteractive
ARG USER=devuser
ARG UID=1000
ARG PASS=llvm

# Set environment variables
ENV USER                ${USER}
ENV HOME                /home/${USER}

# Create user and setup permissions on /etc/sudoers
RUN useradd -m -s /bin/bash -u $UID $USER && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && \
    chmod 0440 /etc/sudoers && \
    chmod g+w /etc/passwd 

# Set password
RUN echo "${USER}:${PASS}" | chpasswd


# Set workdir and switch back to non-root user
WORKDIR $HOME
USER ${UID}
RUN mkdir -p ${HOME}/Projects
VOLUME ${HOME}/Projects

# Start ssh
EXPOSE 22
ENTRYPOINT sudo service ssh start && /bin/bash