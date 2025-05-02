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
ros2 run evaluation_3_randomdag uunifast_node -n node444_0_1 -p 15 -st topic444_0_0 -pt topic444_0_1 -u 0.04275855586157212 > ./result_8chains/node444_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_1_1 -p 30 -st topic444_1_0 -pt topic444_1_1 -u 0.004625180883488067 > ./result_8chains/node444_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_2_1 -p 262 -st topic444_2_0 -pt topic444_2_1 -u 0.0030705262118972954 > ./result_8chains/node444_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_3_1 -p 306 -st topic444_3_0 -pt topic444_3_1 -u 0.002084779353252464 > ./result_8chains/node444_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_4_1 -p 500 -st topic444_4_0 -pt topic444_4_1 -u 0.006430190449835421 > ./result_8chains/node444_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_5_1 -p 771 -st topic444_5_0 -pt topic444_5_1 -u 0.006758954940631334 > ./result_8chains/node444_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_6_1 -p 934 -st topic444_6_0 -pt topic444_6_1 -u 0.006400871388991536 > ./result_8chains/node444_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_7_1 -p 959 -st topic444_7_0 -pt topic444_7_1 -u 0.06341888662632894 > ./result_8chains/node444_7_1.txt &
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
    "./result_8chains/node444_0_1.txt 90"
    "./result_8chains/node444_1_1.txt 89"
    "./result_8chains/node444_2_1.txt 88"
    "./result_8chains/node444_3_1.txt 87"
    "./result_8chains/node444_4_1.txt 86"
    "./result_8chains/node444_5_1.txt 85"
    "./result_8chains/node444_6_1.txt 84"
    "./result_8chains/node444_7_1.txt 83"
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
