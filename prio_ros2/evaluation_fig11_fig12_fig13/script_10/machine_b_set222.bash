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
ros2 run evaluation_3_randomdag uunifast_node -n node222_0_1 -p 243 -st topic222_0_0 -pt topic222_0_1 -u 0.0037673642559306053 > ./result_10chains/node222_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_1_1 -p 286 -st topic222_1_0 -pt topic222_1_1 -u 0.009421786646247654 > ./result_10chains/node222_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_2_1 -p 335 -st topic222_2_0 -pt topic222_2_1 -u 0.011630203781852477 > ./result_10chains/node222_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_3_1 -p 442 -st topic222_3_0 -pt topic222_3_1 -u 0.011359643903128713 > ./result_10chains/node222_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_4_1 -p 481 -st topic222_4_0 -pt topic222_4_1 -u 0.06269806372844255 > ./result_10chains/node222_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_5_1 -p 510 -st topic222_5_0 -pt topic222_5_1 -u 0.06790469175214878 > ./result_10chains/node222_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_6_1 -p 677 -st topic222_6_0 -pt topic222_6_1 -u 0.01662140467833037 > ./result_10chains/node222_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_7_1 -p 759 -st topic222_7_0 -pt topic222_7_1 -u 0.009143750391791966 > ./result_10chains/node222_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_8_1 -p 936 -st topic222_8_0 -pt topic222_8_1 -u 0.014321205298459198 > ./result_10chains/node222_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_9_1 -p 965 -st topic222_9_0 -pt topic222_9_1 -u 0.018135237385731102 > ./result_10chains/node222_9_1.txt &
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
    "./result_10chains/node222_0_1.txt 90"
    "./result_10chains/node222_1_1.txt 89"
    "./result_10chains/node222_2_1.txt 88"
    "./result_10chains/node222_3_1.txt 87"
    "./result_10chains/node222_4_1.txt 86"
    "./result_10chains/node222_5_1.txt 85"
    "./result_10chains/node222_6_1.txt 84"
    "./result_10chains/node222_7_1.txt 83"
    "./result_10chains/node222_8_1.txt 82"
    "./result_10chains/node222_9_1.txt 81"
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
