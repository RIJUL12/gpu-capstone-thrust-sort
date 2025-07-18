#include <thrust/device_vector.h>
#include <thrust/sort.h>
#include <iostream>
#include <cstdlib>
#include <ctime>

int main() {
    const int N = 10;
    int host_data[N];

    std::srand(unsigned(std::time(0)));
    std::cout << "Original array:\n";
    for (int i = 0; i < N; i++) {
        host_data[i] = std::rand() % 100;
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

    return 0;
}
