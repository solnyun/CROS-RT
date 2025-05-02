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
ros2 run evaluation_3_randomdag uunifast_node -n node387_0_1 -p 54 -st topic387_0_0 -pt topic387_0_1 -u 0.0002512496743302117 > ./result_10chains/node387_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_1_1 -p 96 -st topic387_1_0 -pt topic387_1_1 -u 0.07403006419370806 > ./result_10chains/node387_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_2_1 -p 159 -st topic387_2_0 -pt topic387_2_1 -u 0.02232982406253564 > ./result_10chains/node387_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_3_1 -p 337 -st topic387_3_0 -pt topic387_3_1 -u 0.001179557477182902 > ./result_10chains/node387_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_4_1 -p 469 -st topic387_4_0 -pt topic387_4_1 -u 0.01919923252971817 > ./result_10chains/node387_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_5_1 -p 633 -st topic387_5_0 -pt topic387_5_1 -u 0.0009543250659929114 > ./result_10chains/node387_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_6_1 -p 676 -st topic387_6_0 -pt topic387_6_1 -u 0.08113208080396164 > ./result_10chains/node387_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_7_1 -p 721 -st topic387_7_0 -pt topic387_7_1 -u 0.046134670593876034 > ./result_10chains/node387_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_8_1 -p 873 -st topic387_8_0 -pt topic387_8_1 -u 0.014625591751350746 > ./result_10chains/node387_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_9_1 -p 984 -st topic387_9_0 -pt topic387_9_1 -u 0.016064109583016066 > ./result_10chains/node387_9_1.txt &
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
    "./result_10chains/node387_0_1.txt 90"
    "./result_10chains/node387_1_1.txt 89"
    "./result_10chains/node387_2_1.txt 88"
    "./result_10chains/node387_3_1.txt 87"
    "./result_10chains/node387_4_1.txt 86"
    "./result_10chains/node387_5_1.txt 85"
    "./result_10chains/node387_6_1.txt 84"
    "./result_10chains/node387_7_1.txt 83"
    "./result_10chains/node387_8_1.txt 82"
    "./result_10chains/node387_9_1.txt 81"
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
