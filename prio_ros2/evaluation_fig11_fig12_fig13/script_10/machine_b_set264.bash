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
ros2 run evaluation_3_randomdag uunifast_node -n node264_0_1 -p 164 -st topic264_0_0 -pt topic264_0_1 -u 0.00040293060732998764 > ./result_10chains/node264_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_1_1 -p 357 -st topic264_1_0 -pt topic264_1_1 -u 0.0004750000851884151 > ./result_10chains/node264_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_2_1 -p 473 -st topic264_2_0 -pt topic264_2_1 -u 0.004574416596638375 > ./result_10chains/node264_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_3_1 -p 489 -st topic264_3_0 -pt topic264_3_1 -u 0.04141497327666771 > ./result_10chains/node264_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_4_1 -p 521 -st topic264_4_0 -pt topic264_4_1 -u 0.004135565227484206 > ./result_10chains/node264_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_5_1 -p 859 -st topic264_5_0 -pt topic264_5_1 -u 0.00725663941742738 > ./result_10chains/node264_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_6_1 -p 875 -st topic264_6_0 -pt topic264_6_1 -u 0.04435532110154233 > ./result_10chains/node264_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_7_1 -p 937 -st topic264_7_0 -pt topic264_7_1 -u 0.02258738784581893 > ./result_10chains/node264_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_8_1 -p 957 -st topic264_8_0 -pt topic264_8_1 -u 0.036292938588912034 > ./result_10chains/node264_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_9_1 -p 991 -st topic264_9_0 -pt topic264_9_1 -u 0.0203988931771659 > ./result_10chains/node264_9_1.txt &
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
    "./result_10chains/node264_0_1.txt 90"
    "./result_10chains/node264_1_1.txt 89"
    "./result_10chains/node264_2_1.txt 88"
    "./result_10chains/node264_3_1.txt 87"
    "./result_10chains/node264_4_1.txt 86"
    "./result_10chains/node264_5_1.txt 85"
    "./result_10chains/node264_6_1.txt 84"
    "./result_10chains/node264_7_1.txt 83"
    "./result_10chains/node264_8_1.txt 82"
    "./result_10chains/node264_9_1.txt 81"
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
