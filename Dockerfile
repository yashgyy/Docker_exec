# Use NVIDIA's CUDA base image with Ubuntu 20.04
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Set environment variable to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and Python 3.9
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    build-essential \
    software-properties-common \
    python3.9 \
    python3.9-distutils \
    python3.9-venv \
    python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip for Python 3.9
RUN python3.9 -m pip install --upgrade pip

# Install PyTorch with CUDA support for Python 3.9
RUN python3.9 -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Install TensorFlow with GPU support
RUN python3.9 -m pip install tensorflow-gpu

# Clean up APT caches to reduce image size
RUN rm -rf /var/lib/apt/lists/*

# Add a non-root user and give sudo access (optional)
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# Switch to the non-root user (optional)
USER docker
