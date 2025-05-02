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
ros2 run evaluation_3_randomdag uunifast_node -n node465_0_1 -p 29 -st topic465_0_0 -pt topic465_0_1 -u 0.07095786919697739 > ./result_8chains/node465_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_1_1 -p 56 -st topic465_1_0 -pt topic465_1_1 -u 0.0017834773532087733 > ./result_8chains/node465_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_2_1 -p 82 -st topic465_2_0 -pt topic465_2_1 -u 0.025441374629654567 > ./result_8chains/node465_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_3_1 -p 579 -st topic465_3_0 -pt topic465_3_1 -u 0.008004854230384661 > ./result_8chains/node465_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_4_1 -p 619 -st topic465_4_0 -pt topic465_4_1 -u 0.003713860058859819 > ./result_8chains/node465_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_5_1 -p 640 -st topic465_5_0 -pt topic465_5_1 -u 0.0010224211729630145 > ./result_8chains/node465_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_6_1 -p 784 -st topic465_6_0 -pt topic465_6_1 -u 0.04133996115315613 > ./result_8chains/node465_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_7_1 -p 871 -st topic465_7_0 -pt topic465_7_1 -u 0.006943470186826714 > ./result_8chains/node465_7_1.txt &
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
    "./result_8chains/node465_0_1.txt 90"
    "./result_8chains/node465_1_1.txt 89"
    "./result_8chains/node465_2_1.txt 88"
    "./result_8chains/node465_3_1.txt 87"
    "./result_8chains/node465_4_1.txt 86"
    "./result_8chains/node465_5_1.txt 85"
    "./result_8chains/node465_6_1.txt 84"
    "./result_8chains/node465_7_1.txt 83"
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
