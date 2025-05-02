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
ros2 run evaluation_3_randomdag uunifast_node -n node326_0_1 -p 19 -st topic326_0_0 -pt topic326_0_1 -u 0.02475957537022888 > ./result_8chains/node326_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_1_1 -p 526 -st topic326_1_0 -pt topic326_1_1 -u 0.001756978915170293 > ./result_8chains/node326_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_2_1 -p 572 -st topic326_2_0 -pt topic326_2_1 -u 0.014894452067012287 > ./result_8chains/node326_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_3_1 -p 600 -st topic326_3_0 -pt topic326_3_1 -u 0.0031424904012362087 > ./result_8chains/node326_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_4_1 -p 638 -st topic326_4_0 -pt topic326_4_1 -u 0.0016630438874595255 > ./result_8chains/node326_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_5_1 -p 869 -st topic326_5_0 -pt topic326_5_1 -u 0.004929813211751205 > ./result_8chains/node326_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_6_1 -p 892 -st topic326_6_0 -pt topic326_6_1 -u 0.00758869887265988 > ./result_8chains/node326_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_7_1 -p 899 -st topic326_7_0 -pt topic326_7_1 -u 0.0025938722833539624 > ./result_8chains/node326_7_1.txt &
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
    "./result_8chains/node326_0_1.txt 90"
    "./result_8chains/node326_1_1.txt 89"
    "./result_8chains/node326_2_1.txt 88"
    "./result_8chains/node326_3_1.txt 87"
    "./result_8chains/node326_4_1.txt 86"
    "./result_8chains/node326_5_1.txt 85"
    "./result_8chains/node326_6_1.txt 84"
    "./result_8chains/node326_7_1.txt 83"
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
