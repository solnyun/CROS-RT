#!/bin/bash

# Print usage information and exit
print_usage() {
    echo "Usage: $0 <vanilla|framework> <num_chain> <only_RT|with_nonRT>"
    exit 1
}

# Main function to execute the script logic
main() {
    if [ "$#" -ne 3 ]; then
        print_usage
    fi

    type=$1
    num_chain=$2
    model=$3

    # Create a directory to store the result data
    CreateDIR=result
    if [ ! -d "$CreateDIR" ]; then
        mkdir "$CreateDIR"
    fi

    # Node identifiers
    declare -a nodes=("90" "80" "70" "60" "50" "40" "30" "20" "10" "1")

    # Handling different models based on the input
    if [ "${model}" == "with_nonRT" ]; then
        handle_with_nonRT
    elif [ "${model}" == "only_RT" ]; then
        handle_only_RT
    fi

    # Finalize by sleeping and then killing any remaining processes
    sleep 600s
    finalize_process
}

# Handles the 'with_nonRT' model
handle_with_nonRT() {
    echo "Nodes start to run"
    file_name_controller="${CreateDIR}/${type}_controller.txt"
    pendulum_controller -r controller -pt comm -st sensor -setpoint setpoint > "${file_name_controller}" &

    sleep 2s

    # Assign priority based on the controller type
    if [ "${type}" == "vanilla" ] || [ "${type}" == "framework" ]; then
        python3 pri_assign.py "${file_name_controller}" 90
    fi
}

# Handles the 'only_RT' model
handle_only_RT() {
    for (( i=0; i<$num_chain; i++ )); do
        node=${nodes[$i]}
        file_name_controller="${CreateDIR}/${type}_controller_${node}.txt"
        
        # If i is not 0, add the -period 19000000 option
        if [ "$i" -ne 0 ]; then
            echo "RT pendulum_$node start with custom period"
            pendulum_controller -r controller_"$node" -pt comm_"$node" -st sensor_"$node" -setpoint setpoint > "${file_name_controller}" &
        else
            echo "RT pendulum_$node start with default period"
            pendulum_controller -r controller_"$node" -pt comm_"$node" -st sensor_"$node" -setpoint setpoint > "${file_name_controller}" &
        fi
        
        sleep 2s
        # Assign priority
        python3 pri_assign.py "${file_name_controller}" "$node"
    done
}

# Finalize the process by killing any remaining processes
finalize_process() {
    sudo pkill pendulum_*
    sudo pkill talker
}

# Start the main function
main "$@"

