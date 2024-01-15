FROM ubuntu:latest as builder
EXPOSE 22

RUN mkdir -p /Projects
VOLUME /Projects
COPY setup.sh /Projects

ENTRYPOINT /bin/bash
