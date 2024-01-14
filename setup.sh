echo "nameserver 4.2.2.4" > /etc/resolv.conf 
apt-get update
apt-get upgrade
apt-get install -y build-essential
apt-get install -y python-pip
apt-get install -y autoconf
apt-get install -y make
apt-get install -y autoconf
apt-get install -y flex
apt-get install -y bison
apt-get install -y git
apt-get install -y sudo
apt-get install -y python3-numpy
apt-get install -y python3-pip
apt-get update
apt-get install -y gdb
apt-get install -y lldb
apt-get install -y vim
apt-get install -y nano
apt-get install -y emacs
apt-get install -y valgrind
apt-get install -y libeigen3-dev
apt-get install -y clang-format
apt-get install -y openssh-server
# For (CIRCT)
apt-get install -y libfl2 
apt-get install -y libfl-dev
apt-get install -y lsb-release wget software-properties-common
# For development
apt-get install -y ssh-client

# Python packages
python3 -m pip install --upgrade pip
python3 -m pip install wheel
python3 -m pip install numpy
python3 -m pip install torch>=2.0.0+cpu torchvision>=0.15.1+cpu -f https://download.pytorch.org/whl/torch_stable.html

# Install clang
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"


service ssh start