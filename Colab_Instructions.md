# Running mySLM on Google Colab

Follow these steps to train your model on Google Colab using a GPU.

## 1. Prepare your files
1.  Compress your entire `LLM` folder into a zip file named `LLM.zip`.

## 2. Set up Google Colab
1.  Open [Google Colab](https://colab.research.google.com/).
2.  Create a new notebook.
3.  **Enable GPU**: Go to `Runtime` > `Change runtime type` > Select `T4 GPU` (or any available GPU).

## 3. Upload and Extract
Run the following code in a notebook cell to upload your zip file:

```python
from google.colab import files
uploaded = files.upload()
```

(Click "Choose Files" and select your `LLM.zip`)

Then unzip it:
```bash
!unzip LLM.zip
%cd LLM
```

## 4. Build with CUDA
Run the build script to compile the project with GPU support:

```bash
!chmod +x colab_build.sh
!./colab_build.sh
```

## 5. Train
Run the training command. The code is optimized to detect the GPU automatically.

```bash
!./mySLM/build/mySLM train mySLM/tiny-shakespere.txt
```

## 6. Query
Generate text with your trained model:

```bash
!./mySLM/build/mySLM query mySLM/model.bin "The "
```
