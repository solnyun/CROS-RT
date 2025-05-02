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
ros2 run evaluation_3_randomdag uunifast_node -n node85_0_1 -p 34 -st topic85_0_0 -pt topic85_0_1 -u 0.0038491989915223623 > ./result_10chains/node85_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_1_1 -p 158 -st topic85_1_0 -pt topic85_1_1 -u 0.005364519139298474 > ./result_10chains/node85_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_2_1 -p 171 -st topic85_2_0 -pt topic85_2_1 -u 0.05355738412804267 > ./result_10chains/node85_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_3_1 -p 261 -st topic85_3_0 -pt topic85_3_1 -u 0.02403390557642565 > ./result_10chains/node85_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_4_1 -p 357 -st topic85_4_0 -pt topic85_4_1 -u 0.020209426552261517 > ./result_10chains/node85_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_5_1 -p 388 -st topic85_5_0 -pt topic85_5_1 -u 0.018299231799225657 > ./result_10chains/node85_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_6_1 -p 444 -st topic85_6_0 -pt topic85_6_1 -u 0.013576872442063237 > ./result_10chains/node85_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_7_1 -p 583 -st topic85_7_0 -pt topic85_7_1 -u 0.007661745280365437 > ./result_10chains/node85_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_8_1 -p 830 -st topic85_8_0 -pt topic85_8_1 -u 0.010122806827018424 > ./result_10chains/node85_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_9_1 -p 847 -st topic85_9_0 -pt topic85_9_1 -u 0.001831969904279071 > ./result_10chains/node85_9_1.txt &
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
    "./result_10chains/node85_0_1.txt 90"
    "./result_10chains/node85_1_1.txt 89"
    "./result_10chains/node85_2_1.txt 88"
    "./result_10chains/node85_3_1.txt 87"
    "./result_10chains/node85_4_1.txt 86"
    "./result_10chains/node85_5_1.txt 85"
    "./result_10chains/node85_6_1.txt 84"
    "./result_10chains/node85_7_1.txt 83"
    "./result_10chains/node85_8_1.txt 82"
    "./result_10chains/node85_9_1.txt 81"
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
