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
ros2 run evaluation_3_randomdag uunifast_node -n node59_0_1 -p 174 -st topic59_0_0 -pt topic59_0_1 -u 0.031246648296541446 > ./result_10chains/node59_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_1_1 -p 486 -st topic59_1_0 -pt topic59_1_1 -u 0.026979199813953747 > ./result_10chains/node59_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_2_1 -p 528 -st topic59_2_0 -pt topic59_2_1 -u 0.004271946497993673 > ./result_10chains/node59_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_3_1 -p 656 -st topic59_3_0 -pt topic59_3_1 -u 0.0016823922128947344 > ./result_10chains/node59_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_4_1 -p 675 -st topic59_4_0 -pt topic59_4_1 -u 0.017040562646201962 > ./result_10chains/node59_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_5_1 -p 808 -st topic59_5_0 -pt topic59_5_1 -u 0.008474913295347969 > ./result_10chains/node59_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_6_1 -p 835 -st topic59_6_0 -pt topic59_6_1 -u 0.013512064090899112 > ./result_10chains/node59_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_7_1 -p 953 -st topic59_7_0 -pt topic59_7_1 -u 0.014306159730249984 > ./result_10chains/node59_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_8_1 -p 966 -st topic59_8_0 -pt topic59_8_1 -u 0.004702752532666728 > ./result_10chains/node59_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node59_9_1 -p 996 -st topic59_9_0 -pt topic59_9_1 -u 0.002283791753972291 > ./result_10chains/node59_9_1.txt &
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
    "./result_10chains/node59_0_1.txt 90"
    "./result_10chains/node59_1_1.txt 89"
    "./result_10chains/node59_2_1.txt 88"
    "./result_10chains/node59_3_1.txt 87"
    "./result_10chains/node59_4_1.txt 86"
    "./result_10chains/node59_5_1.txt 85"
    "./result_10chains/node59_6_1.txt 84"
    "./result_10chains/node59_7_1.txt 83"
    "./result_10chains/node59_8_1.txt 82"
    "./result_10chains/node59_9_1.txt 81"
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
