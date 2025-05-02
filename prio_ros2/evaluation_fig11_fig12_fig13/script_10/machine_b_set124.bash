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
ros2 run evaluation_3_randomdag uunifast_node -n node124_0_1 -p 123 -st topic124_0_0 -pt topic124_0_1 -u 0.07111553023368061 > ./result_10chains/node124_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_1_1 -p 158 -st topic124_1_0 -pt topic124_1_1 -u 0.002003050248029603 > ./result_10chains/node124_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_2_1 -p 187 -st topic124_2_0 -pt topic124_2_1 -u 0.030975765607079764 > ./result_10chains/node124_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_3_1 -p 231 -st topic124_3_0 -pt topic124_3_1 -u 0.012889651445944783 > ./result_10chains/node124_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_4_1 -p 626 -st topic124_4_0 -pt topic124_4_1 -u 0.03899014972718279 > ./result_10chains/node124_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_5_1 -p 654 -st topic124_5_0 -pt topic124_5_1 -u 0.009654022145929753 > ./result_10chains/node124_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_6_1 -p 705 -st topic124_6_0 -pt topic124_6_1 -u 0.00986159742522738 > ./result_10chains/node124_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_7_1 -p 774 -st topic124_7_0 -pt topic124_7_1 -u 0.02082037527678672 > ./result_10chains/node124_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_8_1 -p 961 -st topic124_8_0 -pt topic124_8_1 -u 0.017180539732549543 > ./result_10chains/node124_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node124_9_1 -p 997 -st topic124_9_0 -pt topic124_9_1 -u 0.002909640658249245 > ./result_10chains/node124_9_1.txt &
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
    "./result_10chains/node124_0_1.txt 90"
    "./result_10chains/node124_1_1.txt 89"
    "./result_10chains/node124_2_1.txt 88"
    "./result_10chains/node124_3_1.txt 87"
    "./result_10chains/node124_4_1.txt 86"
    "./result_10chains/node124_5_1.txt 85"
    "./result_10chains/node124_6_1.txt 84"
    "./result_10chains/node124_7_1.txt 83"
    "./result_10chains/node124_8_1.txt 82"
    "./result_10chains/node124_9_1.txt 81"
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
