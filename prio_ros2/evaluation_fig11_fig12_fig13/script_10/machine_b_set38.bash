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
ros2 run evaluation_3_randomdag uunifast_node -n node38_0_1 -p 68 -st topic38_0_0 -pt topic38_0_1 -u 0.014292259153063147 > ./result_10chains/node38_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_1_1 -p 195 -st topic38_1_0 -pt topic38_1_1 -u 0.016422981931888736 > ./result_10chains/node38_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_2_1 -p 222 -st topic38_2_0 -pt topic38_2_1 -u 0.0033849343178402047 > ./result_10chains/node38_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_3_1 -p 286 -st topic38_3_0 -pt topic38_3_1 -u 0.004615414054399969 > ./result_10chains/node38_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_4_1 -p 599 -st topic38_4_0 -pt topic38_4_1 -u 0.019315711053046192 > ./result_10chains/node38_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_5_1 -p 623 -st topic38_5_0 -pt topic38_5_1 -u 0.0005672497314246627 > ./result_10chains/node38_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_6_1 -p 635 -st topic38_6_0 -pt topic38_6_1 -u 0.010971477409140146 > ./result_10chains/node38_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_7_1 -p 852 -st topic38_7_0 -pt topic38_7_1 -u 0.018177447584395476 > ./result_10chains/node38_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_8_1 -p 878 -st topic38_8_0 -pt topic38_8_1 -u 0.0027750030963662464 > ./result_10chains/node38_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node38_9_1 -p 997 -st topic38_9_0 -pt topic38_9_1 -u 0.005120229530260558 > ./result_10chains/node38_9_1.txt &
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
    "./result_10chains/node38_0_1.txt 90"
    "./result_10chains/node38_1_1.txt 89"
    "./result_10chains/node38_2_1.txt 88"
    "./result_10chains/node38_3_1.txt 87"
    "./result_10chains/node38_4_1.txt 86"
    "./result_10chains/node38_5_1.txt 85"
    "./result_10chains/node38_6_1.txt 84"
    "./result_10chains/node38_7_1.txt 83"
    "./result_10chains/node38_8_1.txt 82"
    "./result_10chains/node38_9_1.txt 81"
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
