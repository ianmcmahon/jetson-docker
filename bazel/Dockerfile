FROM ubuntu:18.04

# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
      bzip2 \
      g++ \
      git \
      cmake \
      pkg-config \
      build-essential \
      python3 \
      openjdk-8-jdk \
      zip unzip \
      zlib1g-dev \
      wget
#??    rm -rf /var/lib/apt/lists/*

# bazel reqs
RUN apt-get install -y --no-install-recommends \
	pkg-config \
	zip \
	zlib1g-dev \
	unzip \
	build-essential \
	openjdk-8-jdk 

RUN apt-get install -y gnupg

ARG bazel_ver="0.19.2"

WORKDIR /root
RUN wget https://bazel.build/bazel-release.pub.gpg
RUN wget https://github.com/bazelbuild/bazel/releases/download/${bazel_ver}/bazel-${bazel_ver}-dist.zip
RUN wget https://github.com/bazelbuild/bazel/releases/download/${bazel_ver}/bazel-${bazel_ver}-dist.zip.sig
RUN wget https://github.com/bazelbuild/bazel/releases/download/${bazel_ver}/bazel-${bazel_ver}-dist.zip.sha256

RUN mkdir bazel && \
	gpg --import bazel-release.pub.gpg && \
	gpg --verify bazel-${bazel_ver}-dist.zip.sig bazel-${bazel_ver}-dist.zip && \
	shasum -a 256 -c bazel-${bazel_ver}-dist.zip.sha256 && \
	cd bazel && \
	unzip ../bazel-${bazel_ver}-dist.zip

WORKDIR /root/bazel
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN env EXTRA_BAZEL_ARGS="--host_javabase=@local_jdk//:jdk" bash ./compile.sh
