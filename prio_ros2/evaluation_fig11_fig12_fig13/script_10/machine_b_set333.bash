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
ros2 run evaluation_3_randomdag uunifast_node -n node333_0_1 -p 10 -st topic333_0_0 -pt topic333_0_1 -u 0.01554264363853497 > ./result_10chains/node333_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_1_1 -p 101 -st topic333_1_0 -pt topic333_1_1 -u 0.005190852037946281 > ./result_10chains/node333_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_2_1 -p 110 -st topic333_2_0 -pt topic333_2_1 -u 0.04892033584932237 > ./result_10chains/node333_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_3_1 -p 207 -st topic333_3_0 -pt topic333_3_1 -u 0.030779684904300775 > ./result_10chains/node333_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_4_1 -p 368 -st topic333_4_0 -pt topic333_4_1 -u 0.006596406804338151 > ./result_10chains/node333_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_5_1 -p 475 -st topic333_5_0 -pt topic333_5_1 -u 0.009657604112866647 > ./result_10chains/node333_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_6_1 -p 780 -st topic333_6_0 -pt topic333_6_1 -u 0.012443426195055146 > ./result_10chains/node333_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_7_1 -p 860 -st topic333_7_0 -pt topic333_7_1 -u 0.06731734337891138 > ./result_10chains/node333_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_8_1 -p 924 -st topic333_8_0 -pt topic333_8_1 -u 0.017632204728963805 > ./result_10chains/node333_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_9_1 -p 965 -st topic333_9_0 -pt topic333_9_1 -u 0.03619653206075354 > ./result_10chains/node333_9_1.txt &
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
    "./result_10chains/node333_0_1.txt 90"
    "./result_10chains/node333_1_1.txt 89"
    "./result_10chains/node333_2_1.txt 88"
    "./result_10chains/node333_3_1.txt 87"
    "./result_10chains/node333_4_1.txt 86"
    "./result_10chains/node333_5_1.txt 85"
    "./result_10chains/node333_6_1.txt 84"
    "./result_10chains/node333_7_1.txt 83"
    "./result_10chains/node333_8_1.txt 82"
    "./result_10chains/node333_9_1.txt 81"
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
