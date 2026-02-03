# mySLM - Custom C++ LLM

A GPT-style Language Model implemented from scratch in C++ using a custom tensor library (`myTorch`).
for more details [paper](https://drive.google.com/file/d/1D81ekNx0kE75X4pL2kh1R-KjkYK9Vhiq/view?usp=drive_link)

## Results

<img width="626" height="298" alt="Screenshot 2026-02-02 at 11 28 07 PM" src="https://github.com/user-attachments/assets/586389bd-1923-4f5e-9527-88963e5c73bb" />

<img width="626" height="310" alt="Screenshot 2026-02-02 at 11 28 24 PM" src="https://github.com/user-attachments/assets/0f4f567d-ff6a-48d8-9500-26151cdf9efa" />
<img width="626" height="368" alt="Screenshot 2026-02-02 at 11 28 35 PM" src="https://github.com/user-attachments/assets/dcd468cc-4455-4418-ad89-0cc3a67a62e7" />



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
