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
ros2 run evaluation_3_randomdag uunifast_node -n node61_0_1 -p 94 -st topic61_0_0 -pt topic61_0_1 -u 0.013061169820611063 > ./result_8chains/node61_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_1_1 -p 353 -st topic61_1_0 -pt topic61_1_1 -u 0.006041380509841543 > ./result_8chains/node61_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_2_1 -p 486 -st topic61_2_0 -pt topic61_2_1 -u 0.000284633656059019 > ./result_8chains/node61_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_3_1 -p 558 -st topic61_3_0 -pt topic61_3_1 -u 0.026996008583586084 > ./result_8chains/node61_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_4_1 -p 882 -st topic61_4_0 -pt topic61_4_1 -u 0.012759826603014446 > ./result_8chains/node61_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_5_1 -p 927 -st topic61_5_0 -pt topic61_5_1 -u 0.039838770563525444 > ./result_8chains/node61_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_6_1 -p 931 -st topic61_6_0 -pt topic61_6_1 -u 0.030870569663760436 > ./result_8chains/node61_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_7_1 -p 983 -st topic61_7_0 -pt topic61_7_1 -u 0.011547923254076421 > ./result_8chains/node61_7_1.txt &
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
    "./result_8chains/node61_0_1.txt 90"
    "./result_8chains/node61_1_1.txt 89"
    "./result_8chains/node61_2_1.txt 88"
    "./result_8chains/node61_3_1.txt 87"
    "./result_8chains/node61_4_1.txt 86"
    "./result_8chains/node61_5_1.txt 85"
    "./result_8chains/node61_6_1.txt 84"
    "./result_8chains/node61_7_1.txt 83"
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
