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
ros2 run evaluation_3_randomdag uunifast_node -n node312_0_1 -p 109 -st topic312_0_0 -pt topic312_0_1 -u 0.010207813124356757 > ./result_8chains/node312_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_1_1 -p 180 -st topic312_1_0 -pt topic312_1_1 -u 0.0035926796332966804 > ./result_8chains/node312_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_2_1 -p 184 -st topic312_2_0 -pt topic312_2_1 -u 0.13120668169129635 > ./result_8chains/node312_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_3_1 -p 524 -st topic312_3_0 -pt topic312_3_1 -u 0.0282928235209447 > ./result_8chains/node312_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_4_1 -p 582 -st topic312_4_0 -pt topic312_4_1 -u 0.004955452668925359 > ./result_8chains/node312_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_5_1 -p 826 -st topic312_5_0 -pt topic312_5_1 -u 0.023365609053404728 > ./result_8chains/node312_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_6_1 -p 947 -st topic312_6_0 -pt topic312_6_1 -u 0.02195992686569892 > ./result_8chains/node312_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_7_1 -p 998 -st topic312_7_0 -pt topic312_7_1 -u 0.015421040598061174 > ./result_8chains/node312_7_1.txt &
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
    "./result_8chains/node312_0_1.txt 90"
    "./result_8chains/node312_1_1.txt 89"
    "./result_8chains/node312_2_1.txt 88"
    "./result_8chains/node312_3_1.txt 87"
    "./result_8chains/node312_4_1.txt 86"
    "./result_8chains/node312_5_1.txt 85"
    "./result_8chains/node312_6_1.txt 84"
    "./result_8chains/node312_7_1.txt 83"
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
