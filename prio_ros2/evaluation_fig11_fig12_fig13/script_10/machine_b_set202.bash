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
ros2 run evaluation_3_randomdag uunifast_node -n node202_0_1 -p 10 -st topic202_0_0 -pt topic202_0_1 -u 0.0021092363817127313 > ./result_10chains/node202_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_1_1 -p 28 -st topic202_1_0 -pt topic202_1_1 -u 0.00853022016439936 > ./result_10chains/node202_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_2_1 -p 172 -st topic202_2_0 -pt topic202_2_1 -u 0.002226247735361009 > ./result_10chains/node202_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_3_1 -p 287 -st topic202_3_0 -pt topic202_3_1 -u 0.0068956430792784795 > ./result_10chains/node202_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_4_1 -p 385 -st topic202_4_0 -pt topic202_4_1 -u 0.01275491003875992 > ./result_10chains/node202_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_5_1 -p 463 -st topic202_5_0 -pt topic202_5_1 -u 0.0002590967310795722 > ./result_10chains/node202_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_6_1 -p 493 -st topic202_6_0 -pt topic202_6_1 -u 0.0531029376375626 > ./result_10chains/node202_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_7_1 -p 669 -st topic202_7_0 -pt topic202_7_1 -u 0.021581078778127066 > ./result_10chains/node202_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_8_1 -p 769 -st topic202_8_0 -pt topic202_8_1 -u 0.00199223835632676 > ./result_10chains/node202_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_9_1 -p 923 -st topic202_9_0 -pt topic202_9_1 -u 0.0030045810986378376 > ./result_10chains/node202_9_1.txt &
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
    "./result_10chains/node202_0_1.txt 90"
    "./result_10chains/node202_1_1.txt 89"
    "./result_10chains/node202_2_1.txt 88"
    "./result_10chains/node202_3_1.txt 87"
    "./result_10chains/node202_4_1.txt 86"
    "./result_10chains/node202_5_1.txt 85"
    "./result_10chains/node202_6_1.txt 84"
    "./result_10chains/node202_7_1.txt 83"
    "./result_10chains/node202_8_1.txt 82"
    "./result_10chains/node202_9_1.txt 81"
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
