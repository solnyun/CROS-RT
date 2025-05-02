#include <chrono>
#include <iostream>
#include <string>

void dummy_task(long load) {
    for (long i = 0; i < load; i++) {
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
        __asm__ volatile ("nop");
    }
}

double measure_execution_time(long load) {
    auto start = std::chrono::high_resolution_clock::now();
    dummy_task(load);
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double, std::milli> execution_time = end - start;
    return execution_time.count();
}

double measure_average_execution_time(long load, int num_measurements = 10) {
    double total_time = 0.0;
    for (int i = 0; i < num_measurements; i++) {
        total_time += measure_execution_time(load);
    }
    return total_time / num_measurements;
}

long calculate_load_for_target_time(double target_time, double initial_time, long initial_load) {
    double ratio = target_time / initial_time;
    return static_cast<long>(initial_load * ratio);
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <target_time_ms>" << std::endl;
        return 1;
    }

    double target_time = std::stod(argv[1]);

    long initial_load = 100;

    double average_initial_time = measure_average_execution_time(initial_load);

    long estimated_load = calculate_load_for_target_time(target_time, average_initial_time, initial_load);

    std::cout << "Measured execution time for initial load " << initial_load << ": " << average_initial_time << " ms" << std::endl;
    std::cout << "For a target time of " << target_time << " ms, the estimated load is: " << estimated_load << std::endl;

    return 0;
}

