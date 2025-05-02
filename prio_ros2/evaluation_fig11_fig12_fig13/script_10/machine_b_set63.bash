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
ros2 run evaluation_3_randomdag uunifast_node -n node63_0_1 -p 153 -st topic63_0_0 -pt topic63_0_1 -u 0.03641023540181598 > ./result_10chains/node63_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_1_1 -p 159 -st topic63_1_0 -pt topic63_1_1 -u 0.011000876645814728 > ./result_10chains/node63_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_2_1 -p 169 -st topic63_2_0 -pt topic63_2_1 -u 0.0009799318219669284 > ./result_10chains/node63_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_3_1 -p 227 -st topic63_3_0 -pt topic63_3_1 -u 0.030760726411330597 > ./result_10chains/node63_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_4_1 -p 297 -st topic63_4_0 -pt topic63_4_1 -u 0.00022238491266263205 > ./result_10chains/node63_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_5_1 -p 467 -st topic63_5_0 -pt topic63_5_1 -u 0.03667645496081948 > ./result_10chains/node63_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_6_1 -p 579 -st topic63_6_0 -pt topic63_6_1 -u 0.0012764275597130226 > ./result_10chains/node63_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_7_1 -p 686 -st topic63_7_0 -pt topic63_7_1 -u 0.01774732653443664 > ./result_10chains/node63_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_8_1 -p 876 -st topic63_8_0 -pt topic63_8_1 -u 0.049063733373808684 > ./result_10chains/node63_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_9_1 -p 951 -st topic63_9_0 -pt topic63_9_1 -u 0.0052256931595939995 > ./result_10chains/node63_9_1.txt &
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
    "./result_10chains/node63_0_1.txt 90"
    "./result_10chains/node63_1_1.txt 89"
    "./result_10chains/node63_2_1.txt 88"
    "./result_10chains/node63_3_1.txt 87"
    "./result_10chains/node63_4_1.txt 86"
    "./result_10chains/node63_5_1.txt 85"
    "./result_10chains/node63_6_1.txt 84"
    "./result_10chains/node63_7_1.txt 83"
    "./result_10chains/node63_8_1.txt 82"
    "./result_10chains/node63_9_1.txt 81"
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
