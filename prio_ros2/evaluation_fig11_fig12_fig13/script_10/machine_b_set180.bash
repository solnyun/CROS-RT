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
ros2 run evaluation_3_randomdag uunifast_node -n node180_0_1 -p 140 -st topic180_0_0 -pt topic180_0_1 -u 0.00810331825861299 > ./result_10chains/node180_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_1_1 -p 179 -st topic180_1_0 -pt topic180_1_1 -u 0.0043384272408439895 > ./result_10chains/node180_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_2_1 -p 193 -st topic180_2_0 -pt topic180_2_1 -u 0.0032289611391239093 > ./result_10chains/node180_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_3_1 -p 233 -st topic180_3_0 -pt topic180_3_1 -u 0.00263152834974012 > ./result_10chains/node180_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_4_1 -p 308 -st topic180_4_0 -pt topic180_4_1 -u 0.006626362018015586 > ./result_10chains/node180_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_5_1 -p 441 -st topic180_5_0 -pt topic180_5_1 -u 0.007848799256380712 > ./result_10chains/node180_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_6_1 -p 738 -st topic180_6_0 -pt topic180_6_1 -u 0.011820537856932822 > ./result_10chains/node180_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_7_1 -p 832 -st topic180_7_0 -pt topic180_7_1 -u 0.06863863834959139 > ./result_10chains/node180_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_8_1 -p 862 -st topic180_8_0 -pt topic180_8_1 -u 0.0024446036489421535 > ./result_10chains/node180_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_9_1 -p 888 -st topic180_9_0 -pt topic180_9_1 -u 0.012605479193293287 > ./result_10chains/node180_9_1.txt &
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
    "./result_10chains/node180_0_1.txt 90"
    "./result_10chains/node180_1_1.txt 89"
    "./result_10chains/node180_2_1.txt 88"
    "./result_10chains/node180_3_1.txt 87"
    "./result_10chains/node180_4_1.txt 86"
    "./result_10chains/node180_5_1.txt 85"
    "./result_10chains/node180_6_1.txt 84"
    "./result_10chains/node180_7_1.txt 83"
    "./result_10chains/node180_8_1.txt 82"
    "./result_10chains/node180_9_1.txt 81"
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
