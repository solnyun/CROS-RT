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
ros2 run evaluation_3_randomdag uunifast_node -n node68_0_1 -p 761 -st topic68_0_0 -pt topic68_0_1 -u 0.004402277580902669 > ./result_6chains/node68_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_1_1 -p 816 -st topic68_1_0 -pt topic68_1_1 -u 0.035689309001265324 > ./result_6chains/node68_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_2_1 -p 873 -st topic68_2_0 -pt topic68_2_1 -u 0.005199560730799191 > ./result_6chains/node68_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_3_1 -p 896 -st topic68_3_0 -pt topic68_3_1 -u 0.011965852387105957 > ./result_6chains/node68_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_4_1 -p 899 -st topic68_4_0 -pt topic68_4_1 -u 0.0006677369620720353 > ./result_6chains/node68_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_5_1 -p 923 -st topic68_5_0 -pt topic68_5_1 -u 0.04971514086260048 > ./result_6chains/node68_5_1.txt &
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
    "./result_6chains/node68_0_1.txt 90"
    "./result_6chains/node68_1_1.txt 89"
    "./result_6chains/node68_2_1.txt 88"
    "./result_6chains/node68_3_1.txt 87"
    "./result_6chains/node68_4_1.txt 86"
    "./result_6chains/node68_5_1.txt 85"
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
