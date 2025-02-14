FROM --platform=linux/amd64 ubuntu:24.04

# Update the repository sources list
RUN apt update && apt upgrade -y
RUN apt install -y gcc clang make cmake autotools-dev libboost-all-dev libeigen3-dev gdb \
    gcc-multilib valgrind libarchive-dev libtbb-dev libgsl-dev openssh-server python3 python3-pip python3-scipy \
    libomp-dev 
RUN apt clean


RUN mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/Port 22/Port 22/' /etc/ssh/sshd_config



ENV SSH_PASSWORD=root

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22

CMD ["/entrypoint.sh"]

