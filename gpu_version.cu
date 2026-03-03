
#include <iostream>
#include <cuda.h>
#include <cmath>

#define WIDTH 512
#define HEIGHT 512

__global__ void sobel(unsigned char *input, unsigned char *output) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;

    if (x > 0 && x < WIDTH-1 && y > 0 && y < HEIGHT-1) {

        int idx = y * WIDTH + x;

        int Gx = -input[(y-1)*WIDTH + (x-1)]
                 -2*input[y*WIDTH + (x-1)]
                 -input[(y+1)*WIDTH + (x-1)]
                 +input[(y-1)*WIDTH + (x+1)]
                 +2*input[y*WIDTH + (x+1)]
                 +input[(y+1)*WIDTH + (x+1)];

        int Gy = -input[(y-1)*WIDTH + (x-1)]
                 -2*input[(y-1)*WIDTH + x]
                 -input[(y-1)*WIDTH + (x+1)]
                 +input[(y+1)*WIDTH + (x-1)]
                 +2*input[(y+1)*WIDTH + x]
                 +input[(y+1)*WIDTH + (x+1)];

        output[idx] = min(255, (int)sqrtf(Gx*Gx + Gy*Gy));
    }
}

int main() {
    unsigned char *h_input = new unsigned char[WIDTH*HEIGHT];
    unsigned char *h_output = new unsigned char[WIDTH*HEIGHT];

    for(int i=0;i<WIDTH*HEIGHT;i++)
        h_input[i] = rand() % 256;

    unsigned char *d_input, *d_output;
    cudaMalloc(&d_input, WIDTH*HEIGHT);
    cudaMalloc(&d_output, WIDTH*HEIGHT);

    cudaMemcpy(d_input, h_input, WIDTH*HEIGHT, cudaMemcpyHostToDevice);

    dim3 threads(16,16);
    dim3 blocks(WIDTH/16, HEIGHT/16);

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);
    sobel<<<blocks, threads>>>(d_input, d_output);
    cudaEventRecord(stop);

    cudaEventSynchronize(stop);

    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);

    std::cout << "GPU Execution Time: " << milliseconds << " ms\n";

    cudaMemcpy(h_output, d_output, WIDTH*HEIGHT, cudaMemcpyDeviceToHost);

    cudaFree(d_input);
    cudaFree(d_output);
}
