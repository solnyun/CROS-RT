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
ros2 run evaluation_3_randomdag uunifast_node -n node335_0_1 -p 52 -st topic335_0_0 -pt topic335_0_1 -u 0.02608824850367686 > ./result_10chains/node335_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_1_1 -p 123 -st topic335_1_0 -pt topic335_1_1 -u 0.02042480058215751 > ./result_10chains/node335_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_2_1 -p 130 -st topic335_2_0 -pt topic335_2_1 -u 0.024561738877919626 > ./result_10chains/node335_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_3_1 -p 276 -st topic335_3_0 -pt topic335_3_1 -u 0.017512063926968413 > ./result_10chains/node335_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_4_1 -p 287 -st topic335_4_0 -pt topic335_4_1 -u 0.011696555194492197 > ./result_10chains/node335_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_5_1 -p 338 -st topic335_5_0 -pt topic335_5_1 -u 0.011454196475172707 > ./result_10chains/node335_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_6_1 -p 385 -st topic335_6_0 -pt topic335_6_1 -u 0.02788225094107813 > ./result_10chains/node335_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_7_1 -p 449 -st topic335_7_0 -pt topic335_7_1 -u 0.008054281869805169 > ./result_10chains/node335_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_8_1 -p 567 -st topic335_8_0 -pt topic335_8_1 -u 0.009668657336431047 > ./result_10chains/node335_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_9_1 -p 805 -st topic335_9_0 -pt topic335_9_1 -u 0.03970257381570519 > ./result_10chains/node335_9_1.txt &
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
    "./result_10chains/node335_0_1.txt 90"
    "./result_10chains/node335_1_1.txt 89"
    "./result_10chains/node335_2_1.txt 88"
    "./result_10chains/node335_3_1.txt 87"
    "./result_10chains/node335_4_1.txt 86"
    "./result_10chains/node335_5_1.txt 85"
    "./result_10chains/node335_6_1.txt 84"
    "./result_10chains/node335_7_1.txt 83"
    "./result_10chains/node335_8_1.txt 82"
    "./result_10chains/node335_9_1.txt 81"
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
