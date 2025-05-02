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
ros2 run evaluation_3_randomdag uunifast_node -n node413_0_1 -p 177 -st topic413_0_0 -pt topic413_0_1 -u 0.01529997388303106 > ./result_6chains/node413_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_1_1 -p 307 -st topic413_1_0 -pt topic413_1_1 -u 0.05613799812428805 > ./result_6chains/node413_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_2_1 -p 735 -st topic413_2_0 -pt topic413_2_1 -u 0.018963509341303753 > ./result_6chains/node413_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_3_1 -p 756 -st topic413_3_0 -pt topic413_3_1 -u 0.08799988622142949 > ./result_6chains/node413_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_4_1 -p 838 -st topic413_4_0 -pt topic413_4_1 -u 0.028146732157559265 > ./result_6chains/node413_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_5_1 -p 862 -st topic413_5_0 -pt topic413_5_1 -u 0.016858163327142385 > ./result_6chains/node413_5_1.txt &
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
    "./result_6chains/node413_0_1.txt 90"
    "./result_6chains/node413_1_1.txt 89"
    "./result_6chains/node413_2_1.txt 88"
    "./result_6chains/node413_3_1.txt 87"
    "./result_6chains/node413_4_1.txt 86"
    "./result_6chains/node413_5_1.txt 85"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
