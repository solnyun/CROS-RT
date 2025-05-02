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
ros2 run evaluation_3_randomdag uunifast_node -n node48_0_1 -p 91 -st topic48_0_0 -pt topic48_0_1 -u 0.025312102136478776 > ./result_10chains/node48_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node48_1_1 -p 113 -st topic48_1_0 -pt topic48_1_1 -u 0.01529235185255301 > ./result_10chains/node48_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node48_2_1 -p 189 -st topic48_2_0 -pt topic48_2_1 -u 0.014428950865102763 > ./result_10chains/node48_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node48_3_1 -p 480 -st topic48_3_0 -pt topic48_3_1 -u 0.006937363489197712 > ./result_10chains/node48_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node48_4_1 -p 488 -st topic48_4_0 -pt topic48_4_1 -u 0.0723589556144052 > ./result_10chains/node48_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node48_5_1 -p 507 -st topic48_5_0 -pt topic48_5_1 -u 0.005917246664202791 > ./result_10chains/node48_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node48_6_1 -p 597 -st topic48_6_0 -pt topic48_6_1 -u 0.017457024868070853 > ./result_10chains/node48_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node48_7_1 -p 622 -st topic48_7_0 -pt topic48_7_1 -u 0.01849330952154951 > ./result_10chains/node48_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node48_8_1 -p 751 -st topic48_8_0 -pt topic48_8_1 -u 0.03627101275250807 > ./result_10chains/node48_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node48_9_1 -p 778 -st topic48_9_0 -pt topic48_9_1 -u 0.006000724638987971 > ./result_10chains/node48_9_1.txt &
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
    "./result_10chains/node48_0_1.txt 90"
    "./result_10chains/node48_1_1.txt 89"
    "./result_10chains/node48_2_1.txt 88"
    "./result_10chains/node48_3_1.txt 87"
    "./result_10chains/node48_4_1.txt 86"
    "./result_10chains/node48_5_1.txt 85"
    "./result_10chains/node48_6_1.txt 84"
    "./result_10chains/node48_7_1.txt 83"
    "./result_10chains/node48_8_1.txt 82"
    "./result_10chains/node48_9_1.txt 81"
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
