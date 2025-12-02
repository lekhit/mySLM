# mySLM - Custom C++ LLM

A GPT-style Language Model implemented from scratch in C++ using a custom tensor library (`myTorch`).

## Prerequisites

*   C++17 compatible compiler (e.g., `clang++`, `g++`)
*   Unix-like environment (macOS/Linux)

## Building

The project includes a convenience script to build both the tensor library and the model.

1.  **Make the script executable (first time only):**
    ```bash
    chmod +x build_all.sh
    ```

2.  **Run the build script:**
    ```bash
    ./build_all.sh
    ```

This will compile:
*   `myTorch` library (CPU only by default)
*   `mySLM` executable

The output executable will be located at `mySLM/build/mySLM`.

## Usage

### Training

To train the model on the provided dataset:

```bash
./mySLM/build/mySLM train mySLM/tiny-shakespere.txt
```

This will:
*   Train the tokenizer on the text.
*   Train the GPT model (default: 1000 steps).
*   Save the model to `model.bin` and tokenizer to `tokenizer.bin`.

### Text Generation (Query)

To generate text using the trained model:

```bash
./mySLM/build/mySLM query mySLM/model.bin "Your prompt here"
```

Example:
```bash
./mySLM/build/mySLM query mySLM/model.bin "The "
```

## Project Structure

*   `myTorch/`: Custom tensor library (tensors, layers, ops).
*   `mySLM/`: Language model implementation (transformer blocks, tokenizer, training loop).
*   `build_all.sh`: Build script.
