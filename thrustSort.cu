#include <thrust/device_vector.h>
#include <thrust/sort.h>
#include <iostream>
#include <cstdlib>
#include <ctime>

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <array_size>\n";
        return 1;
    }

    int N = std::atoi(argv[1]);
    if (N <= 0) {
        std::cerr << "Invalid array size.\n";
        return 1;
    }

    int* host_data = new int[N];

    std::srand(unsigned(std::time(0)));
    std::cout << "Original array:\n";
    for (int i = 0; i < N; i++) {
        host_data[i] = std::rand() % 1000;
        std::cout << host_data[i] << " ";
    }
    std::cout << "\n";

    thrust::device_vector<int> d_vec(host_data, host_data + N);
    thrust::sort(d_vec.begin(), d_vec.end());
    thrust::copy(d_vec.begin(), d_vec.end(), host_data);

    std::cout << "Sorted array:\n";
    for (int i = 0; i < N; i++) {
        std::cout << host_data[i] << " ";
    }
    std::cout << "\n";

    delete[] host_data;
    return 0;
}
