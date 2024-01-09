#!/bin/bash

# Compile the C++ program
g++ aes.cpp gmult.cpp main_omp.cpp -o omp_aes -std=c++17 -fopenmp -pthread -O3

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful."

    # Output file for storing results
    output_result="omp_scala_results.txt"
    
    # Initialize the output file with header
    echo "Threads Number: 1, 2, 4, 8, 16, 32, 64, 128" > ${output_result}
    echo "omp_aes Time: " >> ${output_result}

    for thread in 1 2 4 8 16 32 64 128 256
    do
        input_file="random_data12.txt"

        echo "Running encryption for ${input_file} with ${thread} threads..."
        
        # Run the omp_aes program with the current input file and thread count
        dur_time_omp=$(./omp_aes ${input_file} ${thread} | grep "AES Time:" | cut -d ' ' -f 3)

        # Append results to the output file
        echo -n "${dur_time_omp}, " >> ${output_result}

        echo "Encryption completed for ${input_file} with ${thread} threads."
        echo ""
    done

    echo "Results written to: ${output_result}"

else
    echo "Compilation failed. Please fix the compilation errors before running the script."
fi
