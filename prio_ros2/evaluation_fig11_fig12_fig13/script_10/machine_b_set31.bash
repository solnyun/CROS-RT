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
ros2 run evaluation_3_randomdag uunifast_node -n node31_0_1 -p 226 -st topic31_0_0 -pt topic31_0_1 -u 0.009617175139532197 > ./result_10chains/node31_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_1_1 -p 439 -st topic31_1_0 -pt topic31_1_1 -u 0.04365763210663237 > ./result_10chains/node31_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_2_1 -p 560 -st topic31_2_0 -pt topic31_2_1 -u 0.020325778926824523 > ./result_10chains/node31_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_3_1 -p 627 -st topic31_3_0 -pt topic31_3_1 -u 0.0007462710928557992 > ./result_10chains/node31_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_4_1 -p 732 -st topic31_4_0 -pt topic31_4_1 -u 0.022361458518032756 > ./result_10chains/node31_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_5_1 -p 758 -st topic31_5_0 -pt topic31_5_1 -u 0.005091182013043566 > ./result_10chains/node31_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_6_1 -p 819 -st topic31_6_0 -pt topic31_6_1 -u 0.03279797845780508 > ./result_10chains/node31_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_7_1 -p 893 -st topic31_7_0 -pt topic31_7_1 -u 0.0012143946223968222 > ./result_10chains/node31_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_8_1 -p 943 -st topic31_8_0 -pt topic31_8_1 -u 0.018806875108690828 > ./result_10chains/node31_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_9_1 -p 960 -st topic31_9_0 -pt topic31_9_1 -u 0.0018920479076153691 > ./result_10chains/node31_9_1.txt &
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
    "./result_10chains/node31_0_1.txt 90"
    "./result_10chains/node31_1_1.txt 89"
    "./result_10chains/node31_2_1.txt 88"
    "./result_10chains/node31_3_1.txt 87"
    "./result_10chains/node31_4_1.txt 86"
    "./result_10chains/node31_5_1.txt 85"
    "./result_10chains/node31_6_1.txt 84"
    "./result_10chains/node31_7_1.txt 83"
    "./result_10chains/node31_8_1.txt 82"
    "./result_10chains/node31_9_1.txt 81"
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
