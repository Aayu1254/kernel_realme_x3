FROM ubuntu:jammy
RUN sudo apt-get update
RUN --mount=type=bind,source=$GITHUB_WORKSPACE,target=/src
ENTRYPOINT [/src/kernel_realme_x3/kernelbuilder.sh]
