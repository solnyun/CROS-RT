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
ros2 run evaluation_3_randomdag uunifast_node -n node79_0_1 -p 246 -st topic79_0_0 -pt topic79_0_1 -u 0.007593363967172584 > ./result_10chains/node79_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_1_1 -p 296 -st topic79_1_0 -pt topic79_1_1 -u 0.018021957687874512 > ./result_10chains/node79_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_2_1 -p 370 -st topic79_2_0 -pt topic79_2_1 -u 0.018541384179649845 > ./result_10chains/node79_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_3_1 -p 417 -st topic79_3_0 -pt topic79_3_1 -u 0.007878574801081561 > ./result_10chains/node79_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_4_1 -p 544 -st topic79_4_0 -pt topic79_4_1 -u 0.011778214345385507 > ./result_10chains/node79_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_5_1 -p 655 -st topic79_5_0 -pt topic79_5_1 -u 0.0013752990793006459 > ./result_10chains/node79_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_6_1 -p 710 -st topic79_6_0 -pt topic79_6_1 -u 0.007943044435826913 > ./result_10chains/node79_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_7_1 -p 845 -st topic79_7_0 -pt topic79_7_1 -u 0.010820820249054591 > ./result_10chains/node79_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_8_1 -p 968 -st topic79_8_0 -pt topic79_8_1 -u 0.0037557382013485505 > ./result_10chains/node79_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node79_9_1 -p 998 -st topic79_9_0 -pt topic79_9_1 -u 0.028805264615332976 > ./result_10chains/node79_9_1.txt &
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
    "./result_10chains/node79_0_1.txt 90"
    "./result_10chains/node79_1_1.txt 89"
    "./result_10chains/node79_2_1.txt 88"
    "./result_10chains/node79_3_1.txt 87"
    "./result_10chains/node79_4_1.txt 86"
    "./result_10chains/node79_5_1.txt 85"
    "./result_10chains/node79_6_1.txt 84"
    "./result_10chains/node79_7_1.txt 83"
    "./result_10chains/node79_8_1.txt 82"
    "./result_10chains/node79_9_1.txt 81"
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
