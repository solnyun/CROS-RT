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
ros2 run evaluation_3_randomdag uunifast_node -n node449_0_1 -p 121 -st topic449_0_0 -pt topic449_0_1 -u 0.02023579927605962 > ./result_10chains/node449_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_1_1 -p 158 -st topic449_1_0 -pt topic449_1_1 -u 0.017058271801001168 > ./result_10chains/node449_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_2_1 -p 214 -st topic449_2_0 -pt topic449_2_1 -u 0.011010873005799726 > ./result_10chains/node449_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_3_1 -p 258 -st topic449_3_0 -pt topic449_3_1 -u 0.0018686297177094024 > ./result_10chains/node449_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_4_1 -p 533 -st topic449_4_0 -pt topic449_4_1 -u 0.004096818993389206 > ./result_10chains/node449_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_5_1 -p 554 -st topic449_5_0 -pt topic449_5_1 -u 0.0021538866582636873 > ./result_10chains/node449_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_6_1 -p 750 -st topic449_6_0 -pt topic449_6_1 -u 0.012520649019318847 > ./result_10chains/node449_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_7_1 -p 782 -st topic449_7_0 -pt topic449_7_1 -u 0.031852800313042134 > ./result_10chains/node449_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_8_1 -p 815 -st topic449_8_0 -pt topic449_8_1 -u 0.0004515854851258744 > ./result_10chains/node449_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_9_1 -p 838 -st topic449_9_0 -pt topic449_9_1 -u 0.011478753186861312 > ./result_10chains/node449_9_1.txt &
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
    "./result_10chains/node449_0_1.txt 90"
    "./result_10chains/node449_1_1.txt 89"
    "./result_10chains/node449_2_1.txt 88"
    "./result_10chains/node449_3_1.txt 87"
    "./result_10chains/node449_4_1.txt 86"
    "./result_10chains/node449_5_1.txt 85"
    "./result_10chains/node449_6_1.txt 84"
    "./result_10chains/node449_7_1.txt 83"
    "./result_10chains/node449_8_1.txt 82"
    "./result_10chains/node449_9_1.txt 81"
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
