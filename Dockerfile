FROM ubuntu:18.04

RUN apt-get update && apt-get install -y gnupg

COPY cuda-10-0-local-10.0.166.list /etc/apt/sources.list.d/
COPY cuda-repo-10-0-local-10.0.166 /var/cuda-repo-10-0-local-10.0.166
COPY cudnn /usr/lib/aarch64-linux-gnu/
COPY bazel/bazel /usr/local/bin/bazel

RUN apt-key add /var/cuda-repo-10-0-local-10.0.166/7fa2af80.pub

# Install system packages
RUN apt-get update  && apt-get install -y --no-install-recommends \
	python3-dev python3-pip python3-setuptools \
	wget git g++ cmake openjdk-8-jdk vim

RUN pip3 install -U pip six numpy wheel setuptools mock
RUN pip3 install -U keras_applications==1.0.6 keras_preprocessing==1.0.5 --no-deps

WORKDIR /root

RUN git clone https://github.com/tensorflow/tensorflow.git && \
	cd tensorflow && \
	git checkout v1.12.2

ENV PYTHON_BIN_PATH="/usr/bin/python3"
ENV PYTHON_LIB_PATH="/usr/lib/python3/dist-packages"
ENV TF_NEED_OPENCL_SYCL="0"
ENV TF_NEED_ROCM="0"
ENV TF_NEED_CUDA="1"
ENV CUDA_TOOLKIT_PATH="/usr/local/cuda"
ENV TF_CUDA_VERSION="10.0"
ENV CUDNN_INSTALL_PATH="/usr/lib/aarch64-linux-gnu"
ENV TF_CUDNN_VERSION="7"
ENV TF_NCCL_VERSION="1"
ENV TF_CUDA_COMPUTE_CAPABILITIES="5.3"
ENV LD_LIBRARY_PATH=":/usr/lib/aarch64-linux-gnu:/usr/lib/aarch64-linux-gnu/tegra:/usr/local/cuda/lib64"
ENV TF_CUDA_CLANG="1"
ENV TF_DOWNLOAD_CLANG="1"

# RUN bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package

CMD /bin/bash
