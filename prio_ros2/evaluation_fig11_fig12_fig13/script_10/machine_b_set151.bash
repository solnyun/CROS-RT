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
ros2 run evaluation_3_randomdag uunifast_node -n node151_0_1 -p 79 -st topic151_0_0 -pt topic151_0_1 -u 0.018354380578900487 > ./result_10chains/node151_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_1_1 -p 109 -st topic151_1_0 -pt topic151_1_1 -u 0.023040701799725394 > ./result_10chains/node151_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_2_1 -p 163 -st topic151_2_0 -pt topic151_2_1 -u 0.05524443222256514 > ./result_10chains/node151_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_3_1 -p 199 -st topic151_3_0 -pt topic151_3_1 -u 0.014637265689095513 > ./result_10chains/node151_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_4_1 -p 369 -st topic151_4_0 -pt topic151_4_1 -u 0.0018027125427885204 > ./result_10chains/node151_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_5_1 -p 623 -st topic151_5_0 -pt topic151_5_1 -u 0.0013412239862409248 > ./result_10chains/node151_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_6_1 -p 646 -st topic151_6_0 -pt topic151_6_1 -u 0.005191960145363911 > ./result_10chains/node151_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_7_1 -p 660 -st topic151_7_0 -pt topic151_7_1 -u 0.011950303126200615 > ./result_10chains/node151_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_8_1 -p 958 -st topic151_8_0 -pt topic151_8_1 -u 0.006290910091536192 > ./result_10chains/node151_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_9_1 -p 992 -st topic151_9_0 -pt topic151_9_1 -u 0.01814224015530594 > ./result_10chains/node151_9_1.txt &
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
    "./result_10chains/node151_0_1.txt 90"
    "./result_10chains/node151_1_1.txt 89"
    "./result_10chains/node151_2_1.txt 88"
    "./result_10chains/node151_3_1.txt 87"
    "./result_10chains/node151_4_1.txt 86"
    "./result_10chains/node151_5_1.txt 85"
    "./result_10chains/node151_6_1.txt 84"
    "./result_10chains/node151_7_1.txt 83"
    "./result_10chains/node151_8_1.txt 82"
    "./result_10chains/node151_9_1.txt 81"
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
