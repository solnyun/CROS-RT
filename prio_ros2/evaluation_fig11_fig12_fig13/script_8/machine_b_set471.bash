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
ros2 run evaluation_3_randomdag uunifast_node -n node471_0_1 -p 18 -st topic471_0_0 -pt topic471_0_1 -u 0.025259218863154853 > ./result_8chains/node471_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_1_1 -p 259 -st topic471_1_0 -pt topic471_1_1 -u 0.010997711986202197 > ./result_8chains/node471_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_2_1 -p 266 -st topic471_2_0 -pt topic471_2_1 -u 0.00016345563719732947 > ./result_8chains/node471_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_3_1 -p 395 -st topic471_3_0 -pt topic471_3_1 -u 0.005208796507444047 > ./result_8chains/node471_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_4_1 -p 457 -st topic471_4_0 -pt topic471_4_1 -u 0.04027393934922513 > ./result_8chains/node471_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_5_1 -p 555 -st topic471_5_0 -pt topic471_5_1 -u 0.0077807736700548635 > ./result_8chains/node471_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_6_1 -p 630 -st topic471_6_0 -pt topic471_6_1 -u 0.11084726765671955 > ./result_8chains/node471_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_7_1 -p 759 -st topic471_7_0 -pt topic471_7_1 -u 0.016353383925497282 > ./result_8chains/node471_7_1.txt &
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
    "./result_8chains/node471_0_1.txt 90"
    "./result_8chains/node471_1_1.txt 89"
    "./result_8chains/node471_2_1.txt 88"
    "./result_8chains/node471_3_1.txt 87"
    "./result_8chains/node471_4_1.txt 86"
    "./result_8chains/node471_5_1.txt 85"
    "./result_8chains/node471_6_1.txt 84"
    "./result_8chains/node471_7_1.txt 83"
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
