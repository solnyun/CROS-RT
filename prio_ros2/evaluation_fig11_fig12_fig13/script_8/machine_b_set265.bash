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
ros2 run evaluation_3_randomdag uunifast_node -n node265_0_1 -p 113 -st topic265_0_0 -pt topic265_0_1 -u 0.027380834015637068 > ./result_8chains/node265_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_1_1 -p 395 -st topic265_1_0 -pt topic265_1_1 -u 0.012953550985964124 > ./result_8chains/node265_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_2_1 -p 692 -st topic265_2_0 -pt topic265_2_1 -u 0.02543443116068722 > ./result_8chains/node265_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_3_1 -p 800 -st topic265_3_0 -pt topic265_3_1 -u 0.004483955743147416 > ./result_8chains/node265_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_4_1 -p 859 -st topic265_4_0 -pt topic265_4_1 -u 0.05158156154911603 > ./result_8chains/node265_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_5_1 -p 869 -st topic265_5_0 -pt topic265_5_1 -u 0.010613732532975012 > ./result_8chains/node265_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_6_1 -p 966 -st topic265_6_0 -pt topic265_6_1 -u 0.00869326070082553 > ./result_8chains/node265_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_7_1 -p 973 -st topic265_7_0 -pt topic265_7_1 -u 0.019696060229824557 > ./result_8chains/node265_7_1.txt &
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
    "./result_8chains/node265_0_1.txt 90"
    "./result_8chains/node265_1_1.txt 89"
    "./result_8chains/node265_2_1.txt 88"
    "./result_8chains/node265_3_1.txt 87"
    "./result_8chains/node265_4_1.txt 86"
    "./result_8chains/node265_5_1.txt 85"
    "./result_8chains/node265_6_1.txt 84"
    "./result_8chains/node265_7_1.txt 83"
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
