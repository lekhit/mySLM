#!/bin/bash
set -e

# Build script for Google Colab (CUDA enabled)

# 1. Build myTorch Library
echo "Building myTorch (CUDA)..."
mkdir -p build

# Compile CUDA kernels
nvcc -std=c++17 -I myTorch/include -c myTorch/src/ops_cuda.cu -o build/ops_cuda.o
# Compile CPU ops (still needed for some fallbacks or mixed usage)
nvcc -std=c++17 -I myTorch/include -DUSE_CUDA -c myTorch/src/ops_cpu.cpp -o build/ops_cpu.o
# Compile Tensor class
nvcc -std=c++17 -I myTorch/include -DUSE_CUDA -c myTorch/src/tensor.cpp -o build/tensor.o
# Compile Layers
nvcc -std=c++17 -I myTorch/include -DUSE_CUDA -c myTorch/src/layers.cpp -o build/layers.o

# Archive into a static library
ar rcs build/libmytorch.a build/ops_cuda.o build/ops_cpu.o build/tensor.o build/layers.o

echo "myTorch built."

# 2. Build mySLM Application
echo "Building mySLM..."
mkdir -p mySLM/build

# Compile mySLM sources
nvcc -std=c++17 -I myTorch/include -I mySLM/include -DUSE_CUDA \
    mySLM/src/main.cpp \
    mySLM/src/tokenizer.cpp \
    mySLM/src/model.cpp \
    -L build -lmytorch \
    -o mySLM/build/mySLM

echo "mySLM built."
