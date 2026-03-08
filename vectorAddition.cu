
#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>


// CUDA kernel for vector addition
__global__ void vectorAdd(float *A, float *B, float *C, int N) {
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    if (i < N) {
        C[i] = A[i] + B[i];
    }
}


int main()
{
    int N = 256; // Size of the vectors

    // Declare and allocate memory for host vectors h_A, h_B, and h_C
    float h_A[N], h_B[N], h_C[N];

    // Initialize the host vectors h_A and h_B with some values
    for (int i = 0; i < N; i++) {
        h_A[i] = i;
        h_B[i] = i*2;
    }

    // Allocate memory using cudaMalloc
    float *d_A, *d_B, *d_C;

    cudaMalloc((void**)&d_A, sizeof(float) * N);
    cudaMalloc((void**)&d_B, sizeof(float) * N);
    cudaMalloc((void**)&d_C, sizeof(float) * N);

    // Move data into this allocated space using cudaMemcpy
    cudaMemcpy(d_A, h_A, sizeof(float) * N, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, sizeof(float) * N, cudaMemcpyHostToDevice);

    // Invoke the vector addition kernel
    vectorAdd<<<(N + 255) / 256, 256>>>(d_A, d_B, d_C, N);

    // Copy back the data from device to host using cudaMemcpy
    cudaMemcpy(h_C, d_C, sizeof(float) * N, cudaMemcpyDeviceToHost);

    // Print the results
    for (int i = 0; i < N; i++) {
        printf("h_C[%d] = %f\n", i, h_C[i]);
    }

    // Free the device memory allocation using cudaFree
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
}
