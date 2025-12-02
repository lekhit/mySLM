# Model Profiling Report

## 1. Model Architecture
The model is a **Decoder-only Transformer** (GPT-style) designed for character-level language modeling.

### Components
- **Token Embedding (`wte`)**: Maps character indices to dense vectors.
- **Position Embedding (`wpe`)**: Learnable positional encodings.
- **Transformer Blocks (x4)**:
    - **LayerNorm 1**: Pre-attention normalization.
    - **Multi-Head Self-Attention (`attn`)**:
        - 4 heads.
        - Causal masking (autoregressive).
        - Projections: `c_attn` (Q, K, V) and `c_proj` (Output).
    - **LayerNorm 2**: Pre-MLP normalization.
    - **Feed-Forward Network (`mlp`)**:
        - Expansion factor of 4 (64 -> 256 -> 64).
        - GELU activation.
- **Final LayerNorm (`ln_f`)**: Normalizes output of the last block.
- **Language Model Head (`lm_head`)**: Linear projection to vocabulary size (logits).

## 2. Model Sizes & Dimensions

| Dimension | Value | Description |
| :--- | :--- | :--- |
| **Vocabulary Size** | 65 | Unique characters in `tiny-shakespere.txt` |
| **Embedding Dim (`n_embd`)** | 64 | Size of the vector representation for each token |
| **Context Length (`block_size`)** | 32 | Maximum sequence length the model can attend to |
| **Layers (`n_layer`)** | 4 | Number of Transformer blocks |
| **Heads (`n_head`)** | 4 | Number of attention heads (16 dim per head) |

### Parameter Count
| Component | Calculation | Parameters |
| :--- | :--- | :--- |
| **Token Embeddings** | 65 × 64 | 4,160 |
| **Position Embeddings** | 32 × 64 | 2,048 |
| **Transformer Block (x1)** | | ~50k |
| &nbsp;&nbsp; *LayerNorms* | (64+64) × 2 | 256 |
| &nbsp;&nbsp; *Attention* | (64×192 + 192) + (64×64 + 64) | 16,640 |
| &nbsp;&nbsp; *MLP* | (64×256 + 256) + (256×64 + 64) | 33,088 |
| **Transformer Blocks (x4)** | 49,984 × 4 | 199,936 |
| **Final LayerNorm** | 64 + 64 | 128 |
| **LM Head** | 64 × 65 + 65 | 4,225 |
| **TOTAL** | | **~210,497** |

## 3. Learning Hyperparameters

| Hyperparameter | Value | Notes |
| :--- | :--- | :--- |
| **Optimizer** | Simple SGD 
| **Learning Rate** | 0.0003 | Tuned for stability with  |
| **Batch Size** | 32 | Sequences per training step |
| **Batch Size (Tokens)** | 1,024 | 32 sequences × 32 tokens |
| **Training Steps** | 1,000 | Total weight updates |
| **Loss Function** | Cross Entropy | Standard for classification/LM |

## 4. Inference
- **Generation Method**: Temperature Sampling (default $T=0.8$)
- **Context Window**: Sliding window of up to 32 characters.
