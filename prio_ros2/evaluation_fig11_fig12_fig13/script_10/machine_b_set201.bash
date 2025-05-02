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
ros2 run evaluation_3_randomdag uunifast_node -n node201_0_1 -p 44 -st topic201_0_0 -pt topic201_0_1 -u 0.010228350457017699 > ./result_10chains/node201_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_1_1 -p 217 -st topic201_1_0 -pt topic201_1_1 -u 0.010070474164726728 > ./result_10chains/node201_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_2_1 -p 225 -st topic201_2_0 -pt topic201_2_1 -u 0.005013517361742104 > ./result_10chains/node201_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_3_1 -p 240 -st topic201_3_0 -pt topic201_3_1 -u 0.01229209082962407 > ./result_10chains/node201_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_4_1 -p 267 -st topic201_4_0 -pt topic201_4_1 -u 0.02698473573156915 > ./result_10chains/node201_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_5_1 -p 490 -st topic201_5_0 -pt topic201_5_1 -u 0.009458974335490561 > ./result_10chains/node201_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_6_1 -p 528 -st topic201_6_0 -pt topic201_6_1 -u 0.02215992803167338 > ./result_10chains/node201_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_7_1 -p 739 -st topic201_7_0 -pt topic201_7_1 -u 0.0009899532164160396 > ./result_10chains/node201_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_8_1 -p 822 -st topic201_8_0 -pt topic201_8_1 -u 0.0010671631579665802 > ./result_10chains/node201_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node201_9_1 -p 900 -st topic201_9_0 -pt topic201_9_1 -u 0.03835618694606697 > ./result_10chains/node201_9_1.txt &
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
    "./result_10chains/node201_0_1.txt 90"
    "./result_10chains/node201_1_1.txt 89"
    "./result_10chains/node201_2_1.txt 88"
    "./result_10chains/node201_3_1.txt 87"
    "./result_10chains/node201_4_1.txt 86"
    "./result_10chains/node201_5_1.txt 85"
    "./result_10chains/node201_6_1.txt 84"
    "./result_10chains/node201_7_1.txt 83"
    "./result_10chains/node201_8_1.txt 82"
    "./result_10chains/node201_9_1.txt 81"
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
