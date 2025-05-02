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
ros2 run evaluation_3_randomdag uunifast_node -n node385_0_1 -p 257 -st topic385_0_0 -pt topic385_0_1 -u 0.0014076052195446387 > ./result_6chains/node385_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_1_1 -p 349 -st topic385_1_0 -pt topic385_1_1 -u 0.000221733700763449 > ./result_6chains/node385_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_2_1 -p 358 -st topic385_2_0 -pt topic385_2_1 -u 0.0014166502217604071 > ./result_6chains/node385_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_3_1 -p 521 -st topic385_3_0 -pt topic385_3_1 -u 0.05618574238363361 > ./result_6chains/node385_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_4_1 -p 721 -st topic385_4_0 -pt topic385_4_1 -u 0.050926723861394005 > ./result_6chains/node385_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_5_1 -p 735 -st topic385_5_0 -pt topic385_5_1 -u 0.008961166321621927 > ./result_6chains/node385_5_1.txt &
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
    "./result_6chains/node385_0_1.txt 90"
    "./result_6chains/node385_1_1.txt 89"
    "./result_6chains/node385_2_1.txt 88"
    "./result_6chains/node385_3_1.txt 87"
    "./result_6chains/node385_4_1.txt 86"
    "./result_6chains/node385_5_1.txt 85"
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
