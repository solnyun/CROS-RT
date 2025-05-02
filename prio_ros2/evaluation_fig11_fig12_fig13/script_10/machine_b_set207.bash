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
ros2 run evaluation_3_randomdag uunifast_node -n node207_0_1 -p 123 -st topic207_0_0 -pt topic207_0_1 -u 0.0008357535660756255 > ./result_10chains/node207_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_1_1 -p 124 -st topic207_1_0 -pt topic207_1_1 -u 0.013678430905660455 > ./result_10chains/node207_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_2_1 -p 180 -st topic207_2_0 -pt topic207_2_1 -u 0.020986387375125093 > ./result_10chains/node207_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_3_1 -p 286 -st topic207_3_0 -pt topic207_3_1 -u 0.00440441902894223 > ./result_10chains/node207_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_4_1 -p 446 -st topic207_4_0 -pt topic207_4_1 -u 0.004222275438155065 > ./result_10chains/node207_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_5_1 -p 544 -st topic207_5_0 -pt topic207_5_1 -u 0.001572382087474622 > ./result_10chains/node207_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_6_1 -p 572 -st topic207_6_0 -pt topic207_6_1 -u 0.009519421421858548 > ./result_10chains/node207_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_7_1 -p 577 -st topic207_7_0 -pt topic207_7_1 -u 0.00373508188496649 > ./result_10chains/node207_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_8_1 -p 637 -st topic207_8_0 -pt topic207_8_1 -u 0.006505467125243955 > ./result_10chains/node207_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node207_9_1 -p 773 -st topic207_9_0 -pt topic207_9_1 -u 0.02374208959059593 > ./result_10chains/node207_9_1.txt &
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
    "./result_10chains/node207_0_1.txt 90"
    "./result_10chains/node207_1_1.txt 89"
    "./result_10chains/node207_2_1.txt 88"
    "./result_10chains/node207_3_1.txt 87"
    "./result_10chains/node207_4_1.txt 86"
    "./result_10chains/node207_5_1.txt 85"
    "./result_10chains/node207_6_1.txt 84"
    "./result_10chains/node207_7_1.txt 83"
    "./result_10chains/node207_8_1.txt 82"
    "./result_10chains/node207_9_1.txt 81"
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
