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
ros2 run evaluation_3_randomdag uunifast_node -n node370_0_1 -p 54 -st topic370_0_0 -pt topic370_0_1 -u 0.004933355782782367 > ./result_10chains/node370_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_1_1 -p 223 -st topic370_1_0 -pt topic370_1_1 -u 0.01568353736774908 > ./result_10chains/node370_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_2_1 -p 345 -st topic370_2_0 -pt topic370_2_1 -u 0.01587950819544587 > ./result_10chains/node370_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_3_1 -p 351 -st topic370_3_0 -pt topic370_3_1 -u 0.03533493339734756 > ./result_10chains/node370_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_4_1 -p 458 -st topic370_4_0 -pt topic370_4_1 -u 0.022295299946234998 > ./result_10chains/node370_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_5_1 -p 482 -st topic370_5_0 -pt topic370_5_1 -u 0.07212623490531522 > ./result_10chains/node370_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_6_1 -p 543 -st topic370_6_0 -pt topic370_6_1 -u 0.002711768251173363 > ./result_10chains/node370_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_7_1 -p 616 -st topic370_7_0 -pt topic370_7_1 -u 0.0021822758899067984 > ./result_10chains/node370_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_8_1 -p 629 -st topic370_8_0 -pt topic370_8_1 -u 0.011438820723622768 > ./result_10chains/node370_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_9_1 -p 742 -st topic370_9_0 -pt topic370_9_1 -u 0.009778747198816978 > ./result_10chains/node370_9_1.txt &
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
    "./result_10chains/node370_0_1.txt 90"
    "./result_10chains/node370_1_1.txt 89"
    "./result_10chains/node370_2_1.txt 88"
    "./result_10chains/node370_3_1.txt 87"
    "./result_10chains/node370_4_1.txt 86"
    "./result_10chains/node370_5_1.txt 85"
    "./result_10chains/node370_6_1.txt 84"
    "./result_10chains/node370_7_1.txt 83"
    "./result_10chains/node370_8_1.txt 82"
    "./result_10chains/node370_9_1.txt 81"
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
