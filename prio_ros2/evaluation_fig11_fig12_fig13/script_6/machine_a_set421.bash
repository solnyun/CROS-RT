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
ros2 run evaluation_3_randomdag uunifast_node -n node421_0_2 -p 384 -st topic421_0_1 -pt None -u 0.020745602143767916 > ./result_6chains/node421_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_1_2 -p 402 -st topic421_1_1 -pt None -u 0.036259735878796884 > ./result_6chains/node421_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_2_2 -p 455 -st topic421_2_1 -pt None -u 0.09344256632500236 > ./result_6chains/node421_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_3_2 -p 627 -st topic421_3_1 -pt None -u 0.01140210035355016 > ./result_6chains/node421_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_4_2 -p 649 -st topic421_4_1 -pt None -u 0.007766136870431983 > ./result_6chains/node421_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_5_2 -p 892 -st topic421_5_1 -pt None -u 0.060049625880031876 > ./result_6chains/node421_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_0_0 -p 384 -st none -pt topic421_0_0 -u 0.002529491438575948 > ./result_6chains/node421_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_1_0 -p 402 -st none -pt topic421_1_0 -u 0.014778504067153253 > ./result_6chains/node421_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_2_0 -p 455 -st none -pt topic421_2_0 -u 0.019012711900377455 > ./result_6chains/node421_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_3_0 -p 627 -st none -pt topic421_3_0 -u 0.0017219526514566375 > ./result_6chains/node421_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node421_4_0 -p 649 -st none -pt topic421_4_0 -u 0.04639438376705092 > ./result_6chains/node421_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node421_5_0 -p 892 -st none -pt topic421_5_0 -u 0.011018326233756537 > ./result_6chains/node421_5_0.txt &
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
    "./result_6chains/node421_0_0.txt 90"
    "./result_6chains/node421_0_2.txt 90"
    "./result_6chains/node421_1_0.txt 89"
    "./result_6chains/node421_1_2.txt 89"
    "./result_6chains/node421_2_0.txt 88"
    "./result_6chains/node421_2_2.txt 88"
    "./result_6chains/node421_3_0.txt 87"
    "./result_6chains/node421_3_2.txt 87"
    "./result_6chains/node421_4_0.txt 86"
    "./result_6chains/node421_4_2.txt 86"
    "./result_6chains/node421_5_0.txt 85"
    "./result_6chains/node421_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
