#!/bin/bash

# Print usage information and exit
print_usage() {
    echo "Usage: $0 <vanilla|framework> <with_nonRT_pl|no>"
    exit 1
}

if [ "$#" -ne 2 ]; then
    print_usage
fi

type=$1
model=$2

# Create a directory to store the result data
# CreateDIR=result/
# if [ ! -d "$CreateDIR" ]; then
#    mkdir "$CreateDIR"
# fi
ros2 run evaluation_3_randomdag uunifast_node -n node186_0_2 -p 53 -st topic186_0_1 -pt None -u 0.08666277869148725 > ./result_6chains/node186_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_1_2 -p 79 -st topic186_1_1 -pt None -u 0.010469344500849465 > ./result_6chains/node186_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_2_2 -p 86 -st topic186_2_1 -pt None -u 0.002305360459701422 > ./result_6chains/node186_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_3_2 -p 113 -st topic186_3_1 -pt None -u 0.01735829430238911 > ./result_6chains/node186_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_4_2 -p 498 -st topic186_4_1 -pt None -u 0.00569940402208427 > ./result_6chains/node186_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_5_2 -p 906 -st topic186_5_1 -pt None -u 0.02189271117085189 > ./result_6chains/node186_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_0_0 -p 53 -st none -pt topic186_0_0 -u 0.010932167219643185 > ./result_6chains/node186_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_1_0 -p 79 -st none -pt topic186_1_0 -u 0.011791092643320289 > ./result_6chains/node186_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_2_0 -p 86 -st none -pt topic186_2_0 -u 0.026088995551649063 > ./result_6chains/node186_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_3_0 -p 113 -st none -pt topic186_3_0 -u 0.10238215309372128 > ./result_6chains/node186_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_4_0 -p 498 -st none -pt topic186_4_0 -u 0.011050911265133828 > ./result_6chains/node186_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_5_0 -p 906 -st none -pt topic186_5_0 -u 0.06713256649042612 > ./result_6chains/node186_5_0.txt &
sleep 20
finalize_framework() {
    if [ "$type" == "framework" ]; then
        if [ "$model" == "with_nonRT" ]; then
            python3 pri_remove.py "$file_name_motor"
        fi
        for filepath in "${files[@]}"; do
            file=$(echo "$filepath" | cut -d' ' -f1)
            python3 pri_remove.py "$file"
        done
    fi
}


# Priority Assignments
declare -a files=(
    "./result_6chains/node186_0_0.txt 90"
    "./result_6chains/node186_0_2.txt 90"
    "./result_6chains/node186_1_0.txt 89"
    "./result_6chains/node186_1_2.txt 89"
    "./result_6chains/node186_2_0.txt 88"
    "./result_6chains/node186_2_2.txt 88"
    "./result_6chains/node186_3_0.txt 87"
    "./result_6chains/node186_3_2.txt 87"
    "./result_6chains/node186_4_0.txt 86"
    "./result_6chains/node186_4_2.txt 86"
    "./result_6chains/node186_5_0.txt 85"
    "./result_6chains/node186_5_2.txt 85"
)

for filepath in "${files[@]}"; do
    file=$(echo "$filepath" | cut -d' ' -f1)
    priority=$(echo "$filepath" | cut -d' ' -f2)
    if [ "$type" == "vanilla" ]; then
        python3 pri_assign.py $file $priority
    elif [ "$type" == "framework" ]; then
        python3 pri_identifier.py $file $priority
    fi
done
echo "End Priority Assignment"

# Finalize by performing a final command and killing any remaining processes
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
