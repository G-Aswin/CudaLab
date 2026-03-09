# CudaLab
Repo for my practice cuda programs, google colab notebooks

## GPU Setup
### Option 1 : Google Colab
- Open the notebook in google colab
- Runtime > Change runtime type > T4 GPU
### Option 2 : VSCode + colab extension
- Install Colab extension from https://marketplace.visualstudio.com/items?itemName=Google.colab
- Open a notebook, click on "Select Kernel" > Colab > Sign In. 
- Select new colab server > GPU > T4. 
- From next time around, same GPU option should be available. 

## Run commands
### Directly from the code cell
```bash
# 1. Install nvcc4jupyter (only needed once per runtime GPU)
!pip install nvcc4jupyter
# 2. Load extension (needed everytime the notebook is loaded)
%load_ext nvcc4jupyter
# Ensure the cuda code cell starts with %%cuda. Clicking the run button should work as is.  
```
### Compiling and running the object file
```bash
# This method requires no additional package, as nvcc is preinstalled. 
# 1. Write into a cuda(.cu) file into the workspace
%%writefile test.cu
# 2. Compile with nvcc
!nvcc test.cu -o test -Wno-deprecated-gpu-targets
# 3.  Run the generated object file
!./test
```