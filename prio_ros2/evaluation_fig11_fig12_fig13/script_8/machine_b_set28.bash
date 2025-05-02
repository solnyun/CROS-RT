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
ros2 run evaluation_3_randomdag uunifast_node -n node28_0_1 -p 152 -st topic28_0_0 -pt topic28_0_1 -u 0.0014418044028953747 > ./result_8chains/node28_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_1_1 -p 176 -st topic28_1_0 -pt topic28_1_1 -u 0.008068236168914833 > ./result_8chains/node28_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_2_1 -p 412 -st topic28_2_0 -pt topic28_2_1 -u 0.08218233237689232 > ./result_8chains/node28_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_3_1 -p 474 -st topic28_3_0 -pt topic28_3_1 -u 0.04280419906307337 > ./result_8chains/node28_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_4_1 -p 560 -st topic28_4_0 -pt topic28_4_1 -u 0.002606777446758357 > ./result_8chains/node28_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_5_1 -p 633 -st topic28_5_0 -pt topic28_5_1 -u 0.01423824269462079 > ./result_8chains/node28_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_6_1 -p 761 -st topic28_6_0 -pt topic28_6_1 -u 0.010312231089604718 > ./result_8chains/node28_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_7_1 -p 781 -st topic28_7_0 -pt topic28_7_1 -u 0.030575846917952718 > ./result_8chains/node28_7_1.txt &
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
    "./result_8chains/node28_0_1.txt 90"
    "./result_8chains/node28_1_1.txt 89"
    "./result_8chains/node28_2_1.txt 88"
    "./result_8chains/node28_3_1.txt 87"
    "./result_8chains/node28_4_1.txt 86"
    "./result_8chains/node28_5_1.txt 85"
    "./result_8chains/node28_6_1.txt 84"
    "./result_8chains/node28_7_1.txt 83"
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
