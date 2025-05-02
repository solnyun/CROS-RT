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
ros2 run evaluation_3_randomdag uunifast_node -n node15_0_1 -p 37 -st topic15_0_0 -pt topic15_0_1 -u 0.019453835399615205 > ./result_10chains/node15_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_1_1 -p 241 -st topic15_1_0 -pt topic15_1_1 -u 0.0024045703804280727 > ./result_10chains/node15_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_2_1 -p 249 -st topic15_2_0 -pt topic15_2_1 -u 0.0005499175699508752 > ./result_10chains/node15_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_3_1 -p 464 -st topic15_3_0 -pt topic15_3_1 -u 0.007292619370857123 > ./result_10chains/node15_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_4_1 -p 614 -st topic15_4_0 -pt topic15_4_1 -u 0.009168861654576588 > ./result_10chains/node15_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_5_1 -p 626 -st topic15_5_0 -pt topic15_5_1 -u 0.028623895641046337 > ./result_10chains/node15_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_6_1 -p 636 -st topic15_6_0 -pt topic15_6_1 -u 0.0033143102507818267 > ./result_10chains/node15_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_7_1 -p 748 -st topic15_7_0 -pt topic15_7_1 -u 0.012193920244379264 > ./result_10chains/node15_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_8_1 -p 789 -st topic15_8_0 -pt topic15_8_1 -u 0.009587069667295639 > ./result_10chains/node15_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_9_1 -p 874 -st topic15_9_0 -pt topic15_9_1 -u 0.008846092346954396 > ./result_10chains/node15_9_1.txt &
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
    "./result_10chains/node15_0_1.txt 90"
    "./result_10chains/node15_1_1.txt 89"
    "./result_10chains/node15_2_1.txt 88"
    "./result_10chains/node15_3_1.txt 87"
    "./result_10chains/node15_4_1.txt 86"
    "./result_10chains/node15_5_1.txt 85"
    "./result_10chains/node15_6_1.txt 84"
    "./result_10chains/node15_7_1.txt 83"
    "./result_10chains/node15_8_1.txt 82"
    "./result_10chains/node15_9_1.txt 81"
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
