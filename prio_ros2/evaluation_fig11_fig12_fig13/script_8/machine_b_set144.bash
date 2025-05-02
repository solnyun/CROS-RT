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
ros2 run evaluation_3_randomdag uunifast_node -n node144_0_1 -p 23 -st topic144_0_0 -pt topic144_0_1 -u 2.4225291309132313e-05 > ./result_8chains/node144_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_1_1 -p 114 -st topic144_1_0 -pt topic144_1_1 -u 0.012734442722794281 > ./result_8chains/node144_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_2_1 -p 210 -st topic144_2_0 -pt topic144_2_1 -u 0.0352296133727511 > ./result_8chains/node144_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_3_1 -p 225 -st topic144_3_0 -pt topic144_3_1 -u 0.014222150052610627 > ./result_8chains/node144_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_4_1 -p 329 -st topic144_4_0 -pt topic144_4_1 -u 0.0037062707207580203 > ./result_8chains/node144_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_5_1 -p 395 -st topic144_5_0 -pt topic144_5_1 -u 0.0049306395209040565 > ./result_8chains/node144_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_6_1 -p 736 -st topic144_6_0 -pt topic144_6_1 -u 0.033143592873503075 > ./result_8chains/node144_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_7_1 -p 894 -st topic144_7_0 -pt topic144_7_1 -u 0.0032003953004660947 > ./result_8chains/node144_7_1.txt &
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
    "./result_8chains/node144_0_1.txt 90"
    "./result_8chains/node144_1_1.txt 89"
    "./result_8chains/node144_2_1.txt 88"
    "./result_8chains/node144_3_1.txt 87"
    "./result_8chains/node144_4_1.txt 86"
    "./result_8chains/node144_5_1.txt 85"
    "./result_8chains/node144_6_1.txt 84"
    "./result_8chains/node144_7_1.txt 83"
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
