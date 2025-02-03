# https://onnxruntime.ai/docs/execution-providers/CUDA-ExecutionProvider.html#cuda-11x
FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PROJECT_PATH=/voice-changer
ENV PROJECT_SERVER_PATH=/voice-changer/server
ENV POETRY_HOME=/opt/poetry
ENV POETRY_VIRTUALENVS_CREATE=false

RUN apt-get update && \
    apt-get install -y \
        python3.10 \
        python3-pip \
        git \
        espeak \
        libsndfile1-dev && \
    apt-get install -y --no-install-recommends \
        cuda-cupti-11-7 \
        cuda-cudart-11-7 \
        libcufft-11-7 \
        libcublas-11-7 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python3 /usr/bin/python

ENV LD_LIBRARY_PATH=/usr/local/cuda-11.7/targets/x86_64-linux/lib:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

# Poetry install Python libs
WORKDIR $POETRY_HOME
COPY ./poetry/* ./
RUN pip install --no-cache-dir poetry && \
    poetry lock && \
    poetry install --no-root --no-interaction --no-ansi --no-directory && \
    rm -rf ~/.cache/pip && \
    rm -rf ~/.cache/pypoetry

RUN git clone --depth 1 -b console https://github.com/vbyno/voice-changer.git $PROJECT_PATH
WORKDIR $PROJECT_SERVER_PATH
