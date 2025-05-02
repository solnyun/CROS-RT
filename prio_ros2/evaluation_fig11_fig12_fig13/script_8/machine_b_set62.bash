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
ros2 run evaluation_3_randomdag uunifast_node -n node62_0_1 -p 14 -st topic62_0_0 -pt topic62_0_1 -u 0.006434959914839222 > ./result_8chains/node62_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_1_1 -p 117 -st topic62_1_0 -pt topic62_1_1 -u 0.05707302643806067 > ./result_8chains/node62_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_2_1 -p 242 -st topic62_2_0 -pt topic62_2_1 -u 0.011377140342057779 > ./result_8chains/node62_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_3_1 -p 426 -st topic62_3_0 -pt topic62_3_1 -u 0.025300041611983293 > ./result_8chains/node62_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_4_1 -p 494 -st topic62_4_0 -pt topic62_4_1 -u 0.0036020705167800204 > ./result_8chains/node62_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_5_1 -p 561 -st topic62_5_0 -pt topic62_5_1 -u 0.05201790852668045 > ./result_8chains/node62_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_6_1 -p 643 -st topic62_6_0 -pt topic62_6_1 -u 0.002342066029245554 > ./result_8chains/node62_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_7_1 -p 855 -st topic62_7_0 -pt topic62_7_1 -u 0.04240548662689938 > ./result_8chains/node62_7_1.txt &
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
    "./result_8chains/node62_0_1.txt 90"
    "./result_8chains/node62_1_1.txt 89"
    "./result_8chains/node62_2_1.txt 88"
    "./result_8chains/node62_3_1.txt 87"
    "./result_8chains/node62_4_1.txt 86"
    "./result_8chains/node62_5_1.txt 85"
    "./result_8chains/node62_6_1.txt 84"
    "./result_8chains/node62_7_1.txt 83"
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
