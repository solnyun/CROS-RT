#!/bin/bash

# Function to print usage instructions
print_usage() {
    echo "Usage: $0 <vanilla|framework> <num_chain> <only_RT|with_nonRT>"
    exit 1
}

# Main function to control the flow of the script
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

    declare -a nodes=("90" "80" "70" "60" "50" "40" "30" "20" "10" "1")

    # Handle the 'with_nonRT' model
    if [ "${model}" == "with_nonRT" ]; then
        handle_with_nonRT
    elif [ "${model}" == "only_RT" ]; then
        handle_only_RT
    fi

    sleep 500s

    # Finalize and cleanup if the framework type is used
    finalize_framework

    # Kill any remaining pendulum or listener processes
    sudo pkill pendulum_*
    sudo pkill listener
}

# Function to handle the 'with_nonRT' model
handle_with_nonRT() {
    declare -a periods=("100" "200" "300" "400" "500" "600" "700" "800" "900" "1000")

    for (( i=0; i<$num_chain; i++ )); do
        node=${nodes[$i]}
        period=${periods[$i]}
        util=0.05
        echo "NonRT sub_$node start"
        ros2 run motivation listener -r __node:=sub_"$node" -t sub_"$node" -u "$util" -p "$period" > "$CreateDIR/sub_$node.txt" &
        sleep 3s
    done

    if [ "${type}" == "framework" ]; then
        for (( i=0; i<$num_chain; i++ )); do
            node=${nodes[$i]}
            python3 pri_identifier.py "$CreateDIR/sub_$node.txt" 100
            sleep 2s
        done
    fi

    echo "Nodes start to run"
    file_name_motor="${CreateDIR}/${type}_motor.txt"
    pendulum_motor -r motor -st comm -pt sensor > "${file_name_motor}" &
    sleep 2s

    assign_priority "${file_name_motor}" 90
}

# Function to handle the 'only_RT' model
handle_only_RT() {
    for (( i=$num_chain-1; i>=0; i-- )); do
        node=${nodes[$i]}
        file_name_motor="${CreateDIR}/${type}_motor_${node}.txt"
        echo "RT pendulum_$node start"

        # If i is not 0, add the -period 20000000 option
        if [ "$i" -ne 0 ]; then
            pendulum_motor -r motor_"$node" -st comm_"$node" -pt sensor_"$node" -period 20000000 > "${file_name_motor}" &
        else
            pendulum_motor -r motor_"$node" -st comm_"$node" -pt sensor_"$node" > "${file_name_motor}" &
        fi

        sleep 2s
        assign_priority "${file_name_motor}" "${node}"
    done
}

# Function to assign priority using the appropriate method
assign_priority() {
    file_name_motor=$1
    node=$2

    if [ "${type}" == "vanilla" ]; then
        python3 pri_assign.py "${file_name_motor}" "${node}"
    elif [ "${type}" == "framework" ]; then
        python3 pri_identifier.py "${file_name_motor}" "${node}"
    fi
}

# Function to finalize and clean up based on the framework
finalize_framework() {
    if [ "${type}" == "framework" ]; then
        if [ "${model}" == "with_nonRT" ]; then
            python3 pri_remove.py "$file_name_motor"
        elif [ "${model}" == "only_RT" ]; then
            for (( i=0; i<$num_chain; i++ )); do
                node=${nodes[$i]}
                file_name_motor="${CreateDIR}/${type}_motor_${node}.txt"
                python3 pri_remove.py "$file_name_motor"
            done
        fi
    fi
}

# Call the main function to start the script
main "$@"

