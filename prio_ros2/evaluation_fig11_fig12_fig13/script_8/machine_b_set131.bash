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
ros2 run evaluation_3_randomdag uunifast_node -n node131_0_1 -p 93 -st topic131_0_0 -pt topic131_0_1 -u 0.00037627920372473866 > ./result_8chains/node131_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_1_1 -p 253 -st topic131_1_0 -pt topic131_1_1 -u 0.04850613661717723 > ./result_8chains/node131_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_2_1 -p 314 -st topic131_2_0 -pt topic131_2_1 -u 0.013309210538694216 > ./result_8chains/node131_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_3_1 -p 407 -st topic131_3_0 -pt topic131_3_1 -u 0.02359404067976867 > ./result_8chains/node131_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_4_1 -p 515 -st topic131_4_0 -pt topic131_4_1 -u 0.0011430175462151526 > ./result_8chains/node131_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_5_1 -p 530 -st topic131_5_0 -pt topic131_5_1 -u 0.0014892882919844697 > ./result_8chains/node131_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_6_1 -p 656 -st topic131_6_0 -pt topic131_6_1 -u 0.021828442243319007 > ./result_8chains/node131_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_7_1 -p 751 -st topic131_7_0 -pt topic131_7_1 -u 0.03327505066137116 > ./result_8chains/node131_7_1.txt &
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
    "./result_8chains/node131_0_1.txt 90"
    "./result_8chains/node131_1_1.txt 89"
    "./result_8chains/node131_2_1.txt 88"
    "./result_8chains/node131_3_1.txt 87"
    "./result_8chains/node131_4_1.txt 86"
    "./result_8chains/node131_5_1.txt 85"
    "./result_8chains/node131_6_1.txt 84"
    "./result_8chains/node131_7_1.txt 83"
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
