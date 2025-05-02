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
ros2 run evaluation_3_randomdag uunifast_node -n node38_0_1 -p 182 -st topic38_0_0 -pt topic38_0_1 -u 0.02089655074715563 > ./result_8chains/node38_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_1_1 -p 238 -st topic38_1_0 -pt topic38_1_1 -u 0.033883844352055326 > ./result_8chains/node38_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_2_1 -p 547 -st topic38_2_0 -pt topic38_2_1 -u 0.0056204599386043275 > ./result_8chains/node38_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_3_1 -p 623 -st topic38_3_0 -pt topic38_3_1 -u 0.026988678277657885 > ./result_8chains/node38_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_4_1 -p 673 -st topic38_4_0 -pt topic38_4_1 -u 0.01933536005184555 > ./result_8chains/node38_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_5_1 -p 688 -st topic38_5_0 -pt topic38_5_1 -u 0.013321364554860105 > ./result_8chains/node38_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_6_1 -p 886 -st topic38_6_0 -pt topic38_6_1 -u 0.011094163993539588 > ./result_8chains/node38_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_7_1 -p 962 -st topic38_7_0 -pt topic38_7_1 -u 0.0051865446250884545 > ./result_8chains/node38_7_1.txt &
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
    "./result_8chains/node38_0_1.txt 90"
    "./result_8chains/node38_1_1.txt 89"
    "./result_8chains/node38_2_1.txt 88"
    "./result_8chains/node38_3_1.txt 87"
    "./result_8chains/node38_4_1.txt 86"
    "./result_8chains/node38_5_1.txt 85"
    "./result_8chains/node38_6_1.txt 84"
    "./result_8chains/node38_7_1.txt 83"
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
