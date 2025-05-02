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
ros2 run evaluation_3_randomdag uunifast_node -n node499_0_1 -p 132 -st topic499_0_0 -pt topic499_0_1 -u 0.027516630050890778 > ./result_8chains/node499_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_1_1 -p 231 -st topic499_1_0 -pt topic499_1_1 -u 0.012242444227319349 > ./result_8chains/node499_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_2_1 -p 415 -st topic499_2_0 -pt topic499_2_1 -u 0.0295105056590233 > ./result_8chains/node499_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_3_1 -p 527 -st topic499_3_0 -pt topic499_3_1 -u 0.005367215775514356 > ./result_8chains/node499_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_4_1 -p 531 -st topic499_4_0 -pt topic499_4_1 -u 0.0005582849138732193 > ./result_8chains/node499_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_5_1 -p 689 -st topic499_5_0 -pt topic499_5_1 -u 0.03605273885584767 > ./result_8chains/node499_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_6_1 -p 835 -st topic499_6_0 -pt topic499_6_1 -u 0.017105506324474412 > ./result_8chains/node499_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_7_1 -p 863 -st topic499_7_0 -pt topic499_7_1 -u 0.016177245600883447 > ./result_8chains/node499_7_1.txt &
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
    "./result_8chains/node499_0_1.txt 90"
    "./result_8chains/node499_1_1.txt 89"
    "./result_8chains/node499_2_1.txt 88"
    "./result_8chains/node499_3_1.txt 87"
    "./result_8chains/node499_4_1.txt 86"
    "./result_8chains/node499_5_1.txt 85"
    "./result_8chains/node499_6_1.txt 84"
    "./result_8chains/node499_7_1.txt 83"
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
