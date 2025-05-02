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
ros2 run evaluation_3_randomdag uunifast_node -n node80_0_1 -p 121 -st topic80_0_0 -pt topic80_0_1 -u 0.022571119658529926 > ./result_8chains/node80_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_1_1 -p 206 -st topic80_1_0 -pt topic80_1_1 -u 0.007366562477339855 > ./result_8chains/node80_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_2_1 -p 352 -st topic80_2_0 -pt topic80_2_1 -u 0.03677763900147557 > ./result_8chains/node80_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_3_1 -p 384 -st topic80_3_0 -pt topic80_3_1 -u 0.06523310905879526 > ./result_8chains/node80_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_4_1 -p 385 -st topic80_4_0 -pt topic80_4_1 -u 0.008463824792409397 > ./result_8chains/node80_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_5_1 -p 411 -st topic80_5_0 -pt topic80_5_1 -u 0.026927399822228457 > ./result_8chains/node80_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_6_1 -p 503 -st topic80_6_0 -pt topic80_6_1 -u 0.018337230553628084 > ./result_8chains/node80_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node80_7_1 -p 556 -st topic80_7_0 -pt topic80_7_1 -u 0.015016392114726374 > ./result_8chains/node80_7_1.txt &
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
    "./result_8chains/node80_0_1.txt 90"
    "./result_8chains/node80_1_1.txt 89"
    "./result_8chains/node80_2_1.txt 88"
    "./result_8chains/node80_3_1.txt 87"
    "./result_8chains/node80_4_1.txt 86"
    "./result_8chains/node80_5_1.txt 85"
    "./result_8chains/node80_6_1.txt 84"
    "./result_8chains/node80_7_1.txt 83"
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
