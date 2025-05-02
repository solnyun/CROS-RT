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
ros2 run evaluation_3_randomdag uunifast_node -n node437_0_1 -p 145 -st topic437_0_0 -pt topic437_0_1 -u 0.009134621245134478 > ./result_10chains/node437_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_1_1 -p 267 -st topic437_1_0 -pt topic437_1_1 -u 0.0005322073266490479 > ./result_10chains/node437_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_2_1 -p 443 -st topic437_2_0 -pt topic437_2_1 -u 0.06404983802375863 > ./result_10chains/node437_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_3_1 -p 599 -st topic437_3_0 -pt topic437_3_1 -u 0.07154945373757451 > ./result_10chains/node437_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_4_1 -p 622 -st topic437_4_0 -pt topic437_4_1 -u 0.02277760531401779 > ./result_10chains/node437_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_5_1 -p 694 -st topic437_5_0 -pt topic437_5_1 -u 0.001296335496232634 > ./result_10chains/node437_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_6_1 -p 781 -st topic437_6_0 -pt topic437_6_1 -u 0.004407872280291561 > ./result_10chains/node437_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_7_1 -p 793 -st topic437_7_0 -pt topic437_7_1 -u 0.003528404374783925 > ./result_10chains/node437_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_8_1 -p 888 -st topic437_8_0 -pt topic437_8_1 -u 0.019644576071958776 > ./result_10chains/node437_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_9_1 -p 893 -st topic437_9_0 -pt topic437_9_1 -u 0.0034213676168008867 > ./result_10chains/node437_9_1.txt &
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
    "./result_10chains/node437_0_1.txt 90"
    "./result_10chains/node437_1_1.txt 89"
    "./result_10chains/node437_2_1.txt 88"
    "./result_10chains/node437_3_1.txt 87"
    "./result_10chains/node437_4_1.txt 86"
    "./result_10chains/node437_5_1.txt 85"
    "./result_10chains/node437_6_1.txt 84"
    "./result_10chains/node437_7_1.txt 83"
    "./result_10chains/node437_8_1.txt 82"
    "./result_10chains/node437_9_1.txt 81"
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
