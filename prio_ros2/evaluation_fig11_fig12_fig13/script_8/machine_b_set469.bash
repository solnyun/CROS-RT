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
ros2 run evaluation_3_randomdag uunifast_node -n node469_0_1 -p 80 -st topic469_0_0 -pt topic469_0_1 -u 0.04016391666514102 > ./result_8chains/node469_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_1_1 -p 251 -st topic469_1_0 -pt topic469_1_1 -u 0.03618830784337296 > ./result_8chains/node469_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_2_1 -p 354 -st topic469_2_0 -pt topic469_2_1 -u 0.0003034652159437101 > ./result_8chains/node469_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_3_1 -p 395 -st topic469_3_0 -pt topic469_3_1 -u 0.0012342237161482306 > ./result_8chains/node469_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_4_1 -p 607 -st topic469_4_0 -pt topic469_4_1 -u 0.0018939585800031022 > ./result_8chains/node469_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_5_1 -p 690 -st topic469_5_0 -pt topic469_5_1 -u 0.008177723380035168 > ./result_8chains/node469_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_6_1 -p 757 -st topic469_6_0 -pt topic469_6_1 -u 0.004718391480643236 > ./result_8chains/node469_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_7_1 -p 879 -st topic469_7_0 -pt topic469_7_1 -u 0.021410246724202355 > ./result_8chains/node469_7_1.txt &
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
    "./result_8chains/node469_0_1.txt 90"
    "./result_8chains/node469_1_1.txt 89"
    "./result_8chains/node469_2_1.txt 88"
    "./result_8chains/node469_3_1.txt 87"
    "./result_8chains/node469_4_1.txt 86"
    "./result_8chains/node469_5_1.txt 85"
    "./result_8chains/node469_6_1.txt 84"
    "./result_8chains/node469_7_1.txt 83"
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
