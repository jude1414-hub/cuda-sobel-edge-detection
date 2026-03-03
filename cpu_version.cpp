
#include <iostream>
#include <fstream>
#include <cmath>
#include <chrono>

#define WIDTH 512
#define HEIGHT 512

unsigned char input[HEIGHT][WIDTH];
unsigned char output[HEIGHT][WIDTH];

void generateImage() {
    for(int i=0;i<HEIGHT;i++)
        for(int j=0;j<WIDTH;j++)
            input[i][j] = rand() % 256;
}

void sobel() {
    int Gx, Gy;
    for(int i=1;i<HEIGHT-1;i++) {
        for(int j=1;j<WIDTH-1;j++) {
            Gx = -input[i-1][j-1] -2*input[i][j-1] -input[i+1][j-1]
                 +input[i-1][j+1] +2*input[i][j+1] +input[i+1][j+1];

            Gy = -input[i-1][j-1] -2*input[i-1][j] -input[i-1][j+1]
                 +input[i+1][j-1] +2*input[i+1][j] +input[i+1][j+1];

            output[i][j] = std::min(255, (int)sqrt(Gx*Gx + Gy*Gy));
        }
    }
}

int main() {
    generateImage();
    auto start = std::chrono::high_resolution_clock::now();
    sobel();
    auto end = std::chrono::high_resolution_clock::now();

    std::chrono::duration<double, std::milli> duration = end - start;
    std::cout << "CPU Execution Time: " << duration.count() << " ms\n";
}
