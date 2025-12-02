#!/bin/bash
set -e

echo "Building myTorch (CPU only)..."
cd myTorch
mkdir -p build
clang++ -std=c++17 -I include -c src/tensor.cpp -o build/tensor.o
clang++ -std=c++17 -I include -c src/ops_cpu.cpp -o build/ops_cpu.o
clang++ -std=c++17 -I include -c src/ops_cuda_stub.cpp -o build/ops_cuda_stub.o
clang++ -std=c++17 -I include -c src/layers.cpp -o build/layers.o
ar rcs build/libmyTorch.a build/tensor.o build/ops_cpu.o build/ops_cuda_stub.o build/layers.o
echo "myTorch built."

echo "Building mySLM..."
cd ../mySLM
mkdir -p build
clang++ -std=c++17 -I ../myTorch/include -I include src/tokenizer.cpp src/model.cpp src/main.cpp -L ../myTorch/build -lmyTorch -o build/mySLM
echo "mySLM built."

# ./build/mySLM
