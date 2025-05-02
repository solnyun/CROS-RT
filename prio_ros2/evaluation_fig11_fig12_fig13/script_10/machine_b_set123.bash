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
ros2 run evaluation_3_randomdag uunifast_node -n node123_0_1 -p 60 -st topic123_0_0 -pt topic123_0_1 -u 0.0012289080214122339 > ./result_10chains/node123_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_1_1 -p 79 -st topic123_1_0 -pt topic123_1_1 -u 0.0016301042179123204 > ./result_10chains/node123_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_2_1 -p 167 -st topic123_2_0 -pt topic123_2_1 -u 0.021546349324095437 > ./result_10chains/node123_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_3_1 -p 448 -st topic123_3_0 -pt topic123_3_1 -u 0.008994882723721509 > ./result_10chains/node123_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_4_1 -p 490 -st topic123_4_0 -pt topic123_4_1 -u 0.013756995599157329 > ./result_10chains/node123_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_5_1 -p 708 -st topic123_5_0 -pt topic123_5_1 -u 0.009750556916898717 > ./result_10chains/node123_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_6_1 -p 834 -st topic123_6_0 -pt topic123_6_1 -u 0.04348445646963042 > ./result_10chains/node123_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_7_1 -p 883 -st topic123_7_0 -pt topic123_7_1 -u 0.005397352616162851 > ./result_10chains/node123_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_8_1 -p 893 -st topic123_8_0 -pt topic123_8_1 -u 0.05151662435262238 > ./result_10chains/node123_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_9_1 -p 941 -st topic123_9_0 -pt topic123_9_1 -u 0.019842414842126354 > ./result_10chains/node123_9_1.txt &
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
    "./result_10chains/node123_0_1.txt 90"
    "./result_10chains/node123_1_1.txt 89"
    "./result_10chains/node123_2_1.txt 88"
    "./result_10chains/node123_3_1.txt 87"
    "./result_10chains/node123_4_1.txt 86"
    "./result_10chains/node123_5_1.txt 85"
    "./result_10chains/node123_6_1.txt 84"
    "./result_10chains/node123_7_1.txt 83"
    "./result_10chains/node123_8_1.txt 82"
    "./result_10chains/node123_9_1.txt 81"
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
