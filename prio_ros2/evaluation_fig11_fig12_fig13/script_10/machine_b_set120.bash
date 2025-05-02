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
ros2 run evaluation_3_randomdag uunifast_node -n node120_0_1 -p 23 -st topic120_0_0 -pt topic120_0_1 -u 0.025917871691465866 > ./result_10chains/node120_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_1_1 -p 27 -st topic120_1_0 -pt topic120_1_1 -u 0.0005199262100927804 > ./result_10chains/node120_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_2_1 -p 241 -st topic120_2_0 -pt topic120_2_1 -u 0.05808015919447196 > ./result_10chains/node120_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_3_1 -p 282 -st topic120_3_0 -pt topic120_3_1 -u 0.024954739991084884 > ./result_10chains/node120_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_4_1 -p 375 -st topic120_4_0 -pt topic120_4_1 -u 0.0006389853635256904 > ./result_10chains/node120_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_5_1 -p 549 -st topic120_5_0 -pt topic120_5_1 -u 0.03915744043308145 > ./result_10chains/node120_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_6_1 -p 553 -st topic120_6_0 -pt topic120_6_1 -u 0.0047805713233937674 > ./result_10chains/node120_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_7_1 -p 558 -st topic120_7_0 -pt topic120_7_1 -u 0.023655808018703026 > ./result_10chains/node120_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_8_1 -p 699 -st topic120_8_0 -pt topic120_8_1 -u 1.949909384785231e-05 > ./result_10chains/node120_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_9_1 -p 797 -st topic120_9_0 -pt topic120_9_1 -u 0.014576056489608016 > ./result_10chains/node120_9_1.txt &
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
    "./result_10chains/node120_0_1.txt 90"
    "./result_10chains/node120_1_1.txt 89"
    "./result_10chains/node120_2_1.txt 88"
    "./result_10chains/node120_3_1.txt 87"
    "./result_10chains/node120_4_1.txt 86"
    "./result_10chains/node120_5_1.txt 85"
    "./result_10chains/node120_6_1.txt 84"
    "./result_10chains/node120_7_1.txt 83"
    "./result_10chains/node120_8_1.txt 82"
    "./result_10chains/node120_9_1.txt 81"
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
