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
ros2 run evaluation_3_randomdag uunifast_node -n node328_0_1 -p 52 -st topic328_0_0 -pt topic328_0_1 -u 0.02969021074924416 > ./result_10chains/node328_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_1_1 -p 56 -st topic328_1_0 -pt topic328_1_1 -u 0.01036929995577629 > ./result_10chains/node328_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_2_1 -p 94 -st topic328_2_0 -pt topic328_2_1 -u 0.016262386147103347 > ./result_10chains/node328_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_3_1 -p 126 -st topic328_3_0 -pt topic328_3_1 -u 0.028864853362428222 > ./result_10chains/node328_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_4_1 -p 359 -st topic328_4_0 -pt topic328_4_1 -u 0.00042043773896455194 > ./result_10chains/node328_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_5_1 -p 591 -st topic328_5_0 -pt topic328_5_1 -u 0.015070217029230865 > ./result_10chains/node328_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_6_1 -p 596 -st topic328_6_0 -pt topic328_6_1 -u 0.010411131632752507 > ./result_10chains/node328_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_7_1 -p 700 -st topic328_7_0 -pt topic328_7_1 -u 0.00189645059052361 > ./result_10chains/node328_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_8_1 -p 803 -st topic328_8_0 -pt topic328_8_1 -u 0.001784624531703305 > ./result_10chains/node328_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node328_9_1 -p 830 -st topic328_9_0 -pt topic328_9_1 -u 0.027662553223094227 > ./result_10chains/node328_9_1.txt &
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
    "./result_10chains/node328_0_1.txt 90"
    "./result_10chains/node328_1_1.txt 89"
    "./result_10chains/node328_2_1.txt 88"
    "./result_10chains/node328_3_1.txt 87"
    "./result_10chains/node328_4_1.txt 86"
    "./result_10chains/node328_5_1.txt 85"
    "./result_10chains/node328_6_1.txt 84"
    "./result_10chains/node328_7_1.txt 83"
    "./result_10chains/node328_8_1.txt 82"
    "./result_10chains/node328_9_1.txt 81"
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
