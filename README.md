
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

### Run GPU:
./gpu

## Expected Output
- Execution time printed in milliseconds
- Output edge image saved as output_cpu.pgm and output_gpu.pgm

