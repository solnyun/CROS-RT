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
ros2 run evaluation_3_randomdag uunifast_node -n node180_0_1 -p 108 -st topic180_0_0 -pt topic180_0_1 -u 0.005624775062484488 > ./result_8chains/node180_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_1_1 -p 290 -st topic180_1_0 -pt topic180_1_1 -u 0.0005738304420968565 > ./result_8chains/node180_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_2_1 -p 451 -st topic180_2_0 -pt topic180_2_1 -u 0.020017470163327333 > ./result_8chains/node180_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_3_1 -p 623 -st topic180_3_0 -pt topic180_3_1 -u 0.011701959318917932 > ./result_8chains/node180_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_4_1 -p 830 -st topic180_4_0 -pt topic180_4_1 -u 0.040316663309450024 > ./result_8chains/node180_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_5_1 -p 862 -st topic180_5_0 -pt topic180_5_1 -u 0.015234347108265961 > ./result_8chains/node180_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_6_1 -p 889 -st topic180_6_0 -pt topic180_6_1 -u 0.00995533873684211 > ./result_8chains/node180_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_7_1 -p 955 -st topic180_7_0 -pt topic180_7_1 -u 0.02090984813639836 > ./result_8chains/node180_7_1.txt &
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
    "./result_8chains/node180_0_1.txt 90"
    "./result_8chains/node180_1_1.txt 89"
    "./result_8chains/node180_2_1.txt 88"
    "./result_8chains/node180_3_1.txt 87"
    "./result_8chains/node180_4_1.txt 86"
    "./result_8chains/node180_5_1.txt 85"
    "./result_8chains/node180_6_1.txt 84"
    "./result_8chains/node180_7_1.txt 83"
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
