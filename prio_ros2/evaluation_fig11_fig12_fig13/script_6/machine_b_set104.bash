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
ros2 run evaluation_3_randomdag uunifast_node -n node104_0_1 -p 104 -st topic104_0_0 -pt topic104_0_1 -u 0.017549642336341154 > ./result_6chains/node104_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_1_1 -p 230 -st topic104_1_0 -pt topic104_1_1 -u 0.0018227321423391896 > ./result_6chains/node104_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_2_1 -p 682 -st topic104_2_0 -pt topic104_2_1 -u 0.05317627801100944 > ./result_6chains/node104_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_3_1 -p 723 -st topic104_3_0 -pt topic104_3_1 -u 0.008701979862998421 > ./result_6chains/node104_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_4_1 -p 956 -st topic104_4_0 -pt topic104_4_1 -u 0.021834710550940065 > ./result_6chains/node104_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_5_1 -p 995 -st topic104_5_0 -pt topic104_5_1 -u 0.023104505968923283 > ./result_6chains/node104_5_1.txt &
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
    "./result_6chains/node104_0_1.txt 90"
    "./result_6chains/node104_1_1.txt 89"
    "./result_6chains/node104_2_1.txt 88"
    "./result_6chains/node104_3_1.txt 87"
    "./result_6chains/node104_4_1.txt 86"
    "./result_6chains/node104_5_1.txt 85"
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
