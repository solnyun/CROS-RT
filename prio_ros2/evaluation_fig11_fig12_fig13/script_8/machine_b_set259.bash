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
ros2 run evaluation_3_randomdag uunifast_node -n node259_0_1 -p 113 -st topic259_0_0 -pt topic259_0_1 -u 0.0013246085897984927 > ./result_8chains/node259_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_1_1 -p 163 -st topic259_1_0 -pt topic259_1_1 -u 0.002358125384071763 > ./result_8chains/node259_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_2_1 -p 363 -st topic259_2_0 -pt topic259_2_1 -u 0.0033631036817949322 > ./result_8chains/node259_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_3_1 -p 502 -st topic259_3_0 -pt topic259_3_1 -u 0.007836115827378698 > ./result_8chains/node259_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_4_1 -p 632 -st topic259_4_0 -pt topic259_4_1 -u 0.008237215893626804 > ./result_8chains/node259_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_5_1 -p 890 -st topic259_5_0 -pt topic259_5_1 -u 0.005425655252630418 > ./result_8chains/node259_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_6_1 -p 926 -st topic259_6_0 -pt topic259_6_1 -u 0.05682050505976963 > ./result_8chains/node259_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_7_1 -p 948 -st topic259_7_0 -pt topic259_7_1 -u 0.05703649314175443 > ./result_8chains/node259_7_1.txt &
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
    "./result_8chains/node259_0_1.txt 90"
    "./result_8chains/node259_1_1.txt 89"
    "./result_8chains/node259_2_1.txt 88"
    "./result_8chains/node259_3_1.txt 87"
    "./result_8chains/node259_4_1.txt 86"
    "./result_8chains/node259_5_1.txt 85"
    "./result_8chains/node259_6_1.txt 84"
    "./result_8chains/node259_7_1.txt 83"
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
