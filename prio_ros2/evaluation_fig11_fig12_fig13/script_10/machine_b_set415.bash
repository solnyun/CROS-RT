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
ros2 run evaluation_3_randomdag uunifast_node -n node415_0_1 -p 91 -st topic415_0_0 -pt topic415_0_1 -u 0.0010458984220012013 > ./result_10chains/node415_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_1_1 -p 109 -st topic415_1_0 -pt topic415_1_1 -u 0.06372971276695977 > ./result_10chains/node415_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_2_1 -p 172 -st topic415_2_0 -pt topic415_2_1 -u 0.007178890177665154 > ./result_10chains/node415_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_3_1 -p 400 -st topic415_3_0 -pt topic415_3_1 -u 0.004074186075119668 > ./result_10chains/node415_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_4_1 -p 458 -st topic415_4_0 -pt topic415_4_1 -u 0.06683069510223813 > ./result_10chains/node415_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_5_1 -p 503 -st topic415_5_0 -pt topic415_5_1 -u 0.008971944831635603 > ./result_10chains/node415_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_6_1 -p 556 -st topic415_6_0 -pt topic415_6_1 -u 0.0012183517568249563 > ./result_10chains/node415_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_7_1 -p 606 -st topic415_7_0 -pt topic415_7_1 -u 0.007569984555703249 > ./result_10chains/node415_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_8_1 -p 941 -st topic415_8_0 -pt topic415_8_1 -u 0.016774567310183463 > ./result_10chains/node415_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_9_1 -p 951 -st topic415_9_0 -pt topic415_9_1 -u 0.007740359366616776 > ./result_10chains/node415_9_1.txt &
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
    "./result_10chains/node415_0_1.txt 90"
    "./result_10chains/node415_1_1.txt 89"
    "./result_10chains/node415_2_1.txt 88"
    "./result_10chains/node415_3_1.txt 87"
    "./result_10chains/node415_4_1.txt 86"
    "./result_10chains/node415_5_1.txt 85"
    "./result_10chains/node415_6_1.txt 84"
    "./result_10chains/node415_7_1.txt 83"
    "./result_10chains/node415_8_1.txt 82"
    "./result_10chains/node415_9_1.txt 81"
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
