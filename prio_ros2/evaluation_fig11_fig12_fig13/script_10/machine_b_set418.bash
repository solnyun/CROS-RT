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
ros2 run evaluation_3_randomdag uunifast_node -n node418_0_1 -p 53 -st topic418_0_0 -pt topic418_0_1 -u 0.01197423631878708 > ./result_10chains/node418_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_1_1 -p 126 -st topic418_1_0 -pt topic418_1_1 -u 0.0006712735568605854 > ./result_10chains/node418_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_2_1 -p 151 -st topic418_2_0 -pt topic418_2_1 -u 0.002204659346836446 > ./result_10chains/node418_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_3_1 -p 217 -st topic418_3_0 -pt topic418_3_1 -u 0.015348536531473833 > ./result_10chains/node418_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_4_1 -p 419 -st topic418_4_0 -pt topic418_4_1 -u 0.006802027764780838 > ./result_10chains/node418_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_5_1 -p 444 -st topic418_5_0 -pt topic418_5_1 -u 0.012941295308232625 > ./result_10chains/node418_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_6_1 -p 579 -st topic418_6_0 -pt topic418_6_1 -u 0.016963881312797385 > ./result_10chains/node418_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_7_1 -p 588 -st topic418_7_0 -pt topic418_7_1 -u 0.007569689791812037 > ./result_10chains/node418_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_8_1 -p 794 -st topic418_8_0 -pt topic418_8_1 -u 0.02392164450104476 > ./result_10chains/node418_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_9_1 -p 986 -st topic418_9_0 -pt topic418_9_1 -u 0.0005231684219204661 > ./result_10chains/node418_9_1.txt &
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
    "./result_10chains/node418_0_1.txt 90"
    "./result_10chains/node418_1_1.txt 89"
    "./result_10chains/node418_2_1.txt 88"
    "./result_10chains/node418_3_1.txt 87"
    "./result_10chains/node418_4_1.txt 86"
    "./result_10chains/node418_5_1.txt 85"
    "./result_10chains/node418_6_1.txt 84"
    "./result_10chains/node418_7_1.txt 83"
    "./result_10chains/node418_8_1.txt 82"
    "./result_10chains/node418_9_1.txt 81"
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
