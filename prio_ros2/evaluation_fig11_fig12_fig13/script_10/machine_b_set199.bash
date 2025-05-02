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
ros2 run evaluation_3_randomdag uunifast_node -n node199_0_1 -p 224 -st topic199_0_0 -pt topic199_0_1 -u 0.02744181941826651 > ./result_10chains/node199_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_1_1 -p 297 -st topic199_1_0 -pt topic199_1_1 -u 0.016542105980378974 > ./result_10chains/node199_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_2_1 -p 355 -st topic199_2_0 -pt topic199_2_1 -u 0.03440873481675388 > ./result_10chains/node199_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_3_1 -p 378 -st topic199_3_0 -pt topic199_3_1 -u 0.007874030576194846 > ./result_10chains/node199_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_4_1 -p 525 -st topic199_4_0 -pt topic199_4_1 -u 0.026048585587432505 > ./result_10chains/node199_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_5_1 -p 546 -st topic199_5_0 -pt topic199_5_1 -u 0.004041074423953572 > ./result_10chains/node199_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_6_1 -p 578 -st topic199_6_0 -pt topic199_6_1 -u 0.010542205753778122 > ./result_10chains/node199_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_7_1 -p 756 -st topic199_7_0 -pt topic199_7_1 -u 0.013342566548150414 > ./result_10chains/node199_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_8_1 -p 856 -st topic199_8_0 -pt topic199_8_1 -u 0.018191491839353723 > ./result_10chains/node199_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node199_9_1 -p 916 -st topic199_9_0 -pt topic199_9_1 -u 0.038704731834649925 > ./result_10chains/node199_9_1.txt &
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
    "./result_10chains/node199_0_1.txt 90"
    "./result_10chains/node199_1_1.txt 89"
    "./result_10chains/node199_2_1.txt 88"
    "./result_10chains/node199_3_1.txt 87"
    "./result_10chains/node199_4_1.txt 86"
    "./result_10chains/node199_5_1.txt 85"
    "./result_10chains/node199_6_1.txt 84"
    "./result_10chains/node199_7_1.txt 83"
    "./result_10chains/node199_8_1.txt 82"
    "./result_10chains/node199_9_1.txt 81"
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
