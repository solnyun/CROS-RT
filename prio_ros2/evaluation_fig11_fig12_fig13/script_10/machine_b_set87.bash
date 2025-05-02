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
ros2 run evaluation_3_randomdag uunifast_node -n node87_0_1 -p 94 -st topic87_0_0 -pt topic87_0_1 -u 0.03592155897582011 > ./result_10chains/node87_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_1_1 -p 150 -st topic87_1_0 -pt topic87_1_1 -u 0.00955570854708604 > ./result_10chains/node87_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_2_1 -p 444 -st topic87_2_0 -pt topic87_2_1 -u 0.0045428496566944365 > ./result_10chains/node87_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_3_1 -p 452 -st topic87_3_0 -pt topic87_3_1 -u 0.004380263119603045 > ./result_10chains/node87_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_4_1 -p 476 -st topic87_4_0 -pt topic87_4_1 -u 0.02306462548908328 > ./result_10chains/node87_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_5_1 -p 512 -st topic87_5_0 -pt topic87_5_1 -u 0.013259146809606742 > ./result_10chains/node87_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_6_1 -p 595 -st topic87_6_0 -pt topic87_6_1 -u 0.020783492708143836 > ./result_10chains/node87_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_7_1 -p 794 -st topic87_7_0 -pt topic87_7_1 -u 0.0027712078201201223 > ./result_10chains/node87_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_8_1 -p 881 -st topic87_8_0 -pt topic87_8_1 -u 0.009999051949079386 > ./result_10chains/node87_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node87_9_1 -p 893 -st topic87_9_0 -pt topic87_9_1 -u 0.007840839718984237 > ./result_10chains/node87_9_1.txt &
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
    "./result_10chains/node87_0_1.txt 90"
    "./result_10chains/node87_1_1.txt 89"
    "./result_10chains/node87_2_1.txt 88"
    "./result_10chains/node87_3_1.txt 87"
    "./result_10chains/node87_4_1.txt 86"
    "./result_10chains/node87_5_1.txt 85"
    "./result_10chains/node87_6_1.txt 84"
    "./result_10chains/node87_7_1.txt 83"
    "./result_10chains/node87_8_1.txt 82"
    "./result_10chains/node87_9_1.txt 81"
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
