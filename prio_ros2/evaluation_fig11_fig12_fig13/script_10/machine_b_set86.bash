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
ros2 run evaluation_3_randomdag uunifast_node -n node86_0_1 -p 145 -st topic86_0_0 -pt topic86_0_1 -u 0.025614557280370265 > ./result_10chains/node86_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_1_1 -p 240 -st topic86_1_0 -pt topic86_1_1 -u 0.00956496194227241 > ./result_10chains/node86_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_2_1 -p 244 -st topic86_2_0 -pt topic86_2_1 -u 0.016290315192270866 > ./result_10chains/node86_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_3_1 -p 258 -st topic86_3_0 -pt topic86_3_1 -u 0.006332659908518945 > ./result_10chains/node86_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_4_1 -p 400 -st topic86_4_0 -pt topic86_4_1 -u 0.002215316963480818 > ./result_10chains/node86_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_5_1 -p 705 -st topic86_5_0 -pt topic86_5_1 -u 0.03143478285289175 > ./result_10chains/node86_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_6_1 -p 758 -st topic86_6_0 -pt topic86_6_1 -u 0.0038254391919698982 > ./result_10chains/node86_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_7_1 -p 816 -st topic86_7_0 -pt topic86_7_1 -u 0.004760197537202526 > ./result_10chains/node86_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_8_1 -p 830 -st topic86_8_0 -pt topic86_8_1 -u 0.0014889790910121853 > ./result_10chains/node86_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_9_1 -p 862 -st topic86_9_0 -pt topic86_9_1 -u 0.01226730543661015 > ./result_10chains/node86_9_1.txt &
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
    "./result_10chains/node86_0_1.txt 90"
    "./result_10chains/node86_1_1.txt 89"
    "./result_10chains/node86_2_1.txt 88"
    "./result_10chains/node86_3_1.txt 87"
    "./result_10chains/node86_4_1.txt 86"
    "./result_10chains/node86_5_1.txt 85"
    "./result_10chains/node86_6_1.txt 84"
    "./result_10chains/node86_7_1.txt 83"
    "./result_10chains/node86_8_1.txt 82"
    "./result_10chains/node86_9_1.txt 81"
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
