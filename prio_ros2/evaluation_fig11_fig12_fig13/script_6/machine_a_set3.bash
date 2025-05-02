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
ros2 run evaluation_3_randomdag uunifast_node -n node3_0_2 -p 19 -st topic3_0_1 -pt None -u 0.020983829862881664 > ./result_6chains/node3_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_1_2 -p 93 -st topic3_1_1 -pt None -u 0.018960795656948193 > ./result_6chains/node3_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_2_2 -p 507 -st topic3_2_1 -pt None -u 0.013778908130352763 > ./result_6chains/node3_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_3_2 -p 662 -st topic3_3_1 -pt None -u 0.009952536931576716 > ./result_6chains/node3_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_4_2 -p 910 -st topic3_4_1 -pt None -u 0.026868932836984674 > ./result_6chains/node3_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_5_2 -p 933 -st topic3_5_1 -pt None -u 0.010218040520774232 > ./result_6chains/node3_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_0_0 -p 19 -st none -pt topic3_0_0 -u 0.024830701648101028 > ./result_6chains/node3_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_1_0 -p 93 -st none -pt topic3_1_0 -u 0.041415046210064144 > ./result_6chains/node3_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_2_0 -p 507 -st none -pt topic3_2_0 -u 0.06593930902838957 > ./result_6chains/node3_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_3_0 -p 662 -st none -pt topic3_3_0 -u 0.05260797689845895 > ./result_6chains/node3_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node3_4_0 -p 910 -st none -pt topic3_4_0 -u 0.023336830912390805 > ./result_6chains/node3_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node3_5_0 -p 933 -st none -pt topic3_5_0 -u 0.018765707342724203 > ./result_6chains/node3_5_0.txt &
sleep 10
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
    "./result_6chains/node3_0_0.txt 90"
    "./result_6chains/node3_0_2.txt 90"
    "./result_6chains/node3_1_0.txt 89"
    "./result_6chains/node3_1_2.txt 89"
    "./result_6chains/node3_2_0.txt 88"
    "./result_6chains/node3_2_2.txt 88"
    "./result_6chains/node3_3_0.txt 87"
    "./result_6chains/node3_3_2.txt 87"
    "./result_6chains/node3_4_0.txt 86"
    "./result_6chains/node3_4_2.txt 86"
    "./result_6chains/node3_5_0.txt 85"
    "./result_6chains/node3_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
