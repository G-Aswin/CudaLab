#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>

// kernel function that runs on the GPU hardware
__global__ void simpleKernel() {
    int blockidx = blockIdx.x, blockdim = blockDim.x, threadidx = threadIdx.x;
    int tid = blockdim*blockidx + threadidx;
    printf("Hello world, from global tid : %d (blockIdx : %d, threadIdx : %d)\n", tid, blockidx, threadidx);
}

int main() {
    // Launching 1 block and 1 thread
    simpleKernel<<<2, 4>>>();

    // Wait for the GPU to finish its task before the CPU closes the program
    cudaDeviceSynchronize();

    return 0;
}
