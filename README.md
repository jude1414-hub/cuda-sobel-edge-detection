
# GPU Accelerated Sobel Edge Detection using CUDA

## Overview
This project implements Sobel Edge Detection using:
- CPU (C++)
- GPU (CUDA)

It compares performance between CPU and GPU implementations.

## Requirements
- NVIDIA GPU
- CUDA Toolkit installed
- nvcc compiler
- g++

## Compilation

### Compile CPU version:
g++ cpu_version.cpp -o cpu

### Compile GPU version:
nvcc gpu_version.cu -o gpu

## Execution

### Run CPU:
./cpu
<img width="257" height="34" alt="image" src="https://github.com/user-attachments/assets/8f467f9c-d534-4855-9d0b-ea0c9c27cc51" />

### Run GPU:
./gpu
<img width="1698" height="60" alt="image" src="https://github.com/user-attachments/assets/b40ac142-5c7c-462b-afe9-513c52eb0091" />

## Expected Output
- Execution time printed in milliseconds
- Output edge image saved as output_cpu.pgm and output_gpu.pgm
<img width="1559" height="510" alt="image" src="https://github.com/user-attachments/assets/f7bbe96a-e497-439b-a5ed-425858477b5d" />

