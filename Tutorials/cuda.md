### CUDA Tutorial

CUDA (Compute Unified Device Architecture) is a parallel computing platform and API model developed by NVIDIA for general computing on its own GPUs (Graphics Processing Units).

---

### **1. Setup and Compilation**

To start writing and compiling CUDA programs, you need:
- A compatible NVIDIA GPU.
- The **CUDA Toolkit**, which includes the compiler **`nvcc`**.

#### **Compiling CUDA Code**:
```bash
nvcc -o my_cuda_program my_cuda_program.cu
```
- **Explanation**: `nvcc` is the NVIDIA CUDA compiler that compiles `.cu` files, which contain the CUDA C/C++ code.

---

### **2. CUDA Basics**

CUDA uses **kernels** that are functions executed in parallel across many GPU threads. Kernels are launched from the CPU (host) but executed on the GPU (device).

#### **Simple CUDA Program**

```cpp
#include <stdio.h>

// Kernel function that runs on the GPU
__global__ void my_kernel() {
    printf("Hello from GPU thread %d\n", threadIdx.x);
}

int main() {
    // Launch kernel with 10 threads
    my_kernel<<<1, 10>>>();

    // Synchronize GPU and CPU
    cudaDeviceSynchronize();

    return 0;
}
```
- **Explanation**:
  - `__global__` indicates that the function is a kernel that runs on the GPU.
  - `my_kernel<<<1, 10>>>();` launches 1 block with 10 threads.
  - `threadIdx.x` gives the thread ID within a block.

---

### **3. Memory Model**

CUDA distinguishes between **host memory** (CPU memory) and **device memory** (GPU memory). Data needs to be transferred between these two.

#### **Memory Transfer Example**

```cpp
#include <stdio.h>

__global__ void add(int *a, int *b, int *c) {
    int index = threadIdx.x;
    c[index] = a[index] + b[index];
}

int main() {
    int a[5], b[5], c[5];        // Host arrays
    int *d_a, *d_b, *d_c;        // Device pointers

    // Allocate memory on the device
    cudaMalloc((void **)&d_a, 5 * sizeof(int));
    cudaMalloc((void **)&d_b, 5 * sizeof(int));
    cudaMalloc((void **)&d_c, 5 * sizeof(int));

    // Initialize arrays on the host
    for (int i = 0; i < 5; i++) {
        a[i] = i;
        b[i] = i * 2;
    }

    // Copy data from host to device
    cudaMemcpy(d_a, a, 5 * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, 5 * sizeof(int), cudaMemcpyHostToDevice);

    // Launch the kernel on 1 block with 5 threads
    add<<<1, 5>>>(d_a, d_b, d_c);

    // Copy result back to host
    cudaMemcpy(c, d_c, 5 * sizeof(int), cudaMemcpyDeviceToHost);

    // Print the result
    for (int i = 0; i < 5; i++) {
        printf("c[%d] = %d\n", i, c[i]);
    }

    // Free device memory
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}
```
- **Explanation**:
  - **cudaMalloc()** allocates memory on the GPU.
  - **cudaMemcpy()** transfers data between host and device memory.
  - After computation, the result is copied back to the host and printed.

---

### **4. Thread Hierarchy**

In CUDA, threads are organized in **blocks**, and blocks are organized into a **grid**. Each thread and block have their own unique IDs, which help in indexing data for parallel execution.

#### **Thread and Block Indexing**

```cpp
__global__ void print_thread_info() {
    int threadId = threadIdx.x;
    int blockId = blockIdx.x;
    int globalId = blockId * blockDim.x + threadId;

    printf("Thread %d in Block %d (Global ID: %d)\n", threadId, blockId, globalId);
}

int main() {
    // Launch 2 blocks with 5 threads each
    print_thread_info<<<2, 5>>>();
    cudaDeviceSynchronize();

    return 0;
}
```
- **Explanation**:
  - **threadIdx.x**: The thread index within the block.
  - **blockIdx.x**: The block index within the grid.
  - **blockDim.x**: The number of threads per block.

---

### **5. Synchronization**

#### **__syncthreads()**

This is a barrier that synchronizes all threads within a block. When one thread reaches this barrier, it waits for all other threads in the block to reach it.

```cpp
__global__ void sync_example() {
    int tid = threadIdx.x;
    
    // Perform computation before sync
    printf("Thread %d before sync\n", tid);
    
    // Synchronize all threads in the block
    __syncthreads();
    
    // Perform computation after sync
    printf("Thread %d after sync\n", tid);
}

int main() {
    sync_example<<<1, 10>>>();
    cudaDeviceSynchronize();

    return 0;
}
```

---

### **6. Shared Memory**

CUDA also provides **shared memory**, which is memory shared between all threads in the same block. It is faster than global memory, but it's limited in size.

#### **Shared Memory Example**

```cpp
__global__ void shared_memory_example() {
    __shared__ int shared_data[10];

    int tid = threadIdx.x;
    shared_data[tid] = tid * 2;

    __syncthreads(); // Ensure all threads write their data

    // Print the data from shared memory
    printf("Thread %d, Shared Data: %d\n", tid, shared_data[tid]);
}

int main() {
    shared_memory_example<<<1, 10>>>();
    cudaDeviceSynchronize();

    return 0;
}
```
- **Explanation**: Shared memory is declared with the `__shared__` keyword and is accessible by all threads in the block.

---

### **7. Reduction Example**

Reduction is a common parallel pattern, where a result is accumulated across many threads. In this example, we sum all the elements of an array using CUDA.

```cpp
__global__ void sum_reduction(int *input, int *output) {
    __shared__ int shared_data[1024];
    
    int tid = threadIdx.x;
    int i = blockIdx.x * blockDim.x + tid;
    
    shared_data[tid] = input[i];
    __syncthreads();

    // Perform reduction within the block
    for (int s = blockDim.x / 2; s > 0; s >>= 1) {
        if (tid < s) {
            shared_data[tid] += shared_data[tid + s];
        }
        __syncthreads();
    }

    // Write the result for this block
    if (tid == 0) output[blockIdx.x] = shared_data[0];
}

int main() {
    int n = 1024;
    int input[1024], output[32];
    int *d_input, *d_output;

    // Initialize input data
    for (int i = 0; i < n; i++) input[i] = 1;  // Simple example, all ones

    // Allocate memory on the device
    cudaMalloc((void **)&d_input, n * sizeof(int));
    cudaMalloc((void **)&d_output, 32 * sizeof(int));

    // Copy input data to the device
    cudaMemcpy(d_input, input, n * sizeof(int), cudaMemcpyHostToDevice);

    // Launch kernel with 32 blocks of 32 threads each
    sum_reduction<<<32, 32>>>(d_input, d_output);

    // Copy output data back to the host
    cudaMemcpy(output, d_output, 32 * sizeof(int), cudaMemcpyDeviceToHost);

    // Final sum reduction on CPU
    int sum = 0;
    for (int i = 0; i < 32; i++) {
        sum += output[i];
    }

    printf("Sum: %d\n", sum);

    // Free device memory
    cudaFree(d_input);
    cudaFree(d_output);

    return 0;
}
```
- **Explanation**: This program performs a block-wise reduction, summing elements of the input array.

---

### **8. Error Handling**

CUDA functions often return errors that need to be handled. The function `cudaGetLastError()` can be used to check for any error during execution.

#### **Error Checking Example**
```cpp
#include <stdio.h>

__global__ void kernel() {
    // An example kernel that does nothing
}

int main() {
    kernel<<<-1, -1>>>();  // Invalid kernel launch (negative values)

    // Check for errors
    cudaError_t err = cudaGetLastError();
    if (err != cudaSuccess) {
        printf("CUDA error: %s\n", cudaGetErrorString(err));
    }

    return 0;
}
