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
ros2 run evaluation_3_randomdag uunifast_node -n node485_0_1 -p 113 -st topic485_0_0 -pt topic485_0_1 -u 0.009968898097388601 > ./result_10chains/node485_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_1_1 -p 187 -st topic485_1_0 -pt topic485_1_1 -u 0.0006190548857417655 > ./result_10chains/node485_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_2_1 -p 209 -st topic485_2_0 -pt topic485_2_1 -u 0.02378675005662545 > ./result_10chains/node485_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_3_1 -p 234 -st topic485_3_0 -pt topic485_3_1 -u 0.04159919942589005 > ./result_10chains/node485_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_4_1 -p 362 -st topic485_4_0 -pt topic485_4_1 -u 0.013778723948164956 > ./result_10chains/node485_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_5_1 -p 440 -st topic485_5_0 -pt topic485_5_1 -u 0.017820320508240922 > ./result_10chains/node485_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_6_1 -p 498 -st topic485_6_0 -pt topic485_6_1 -u 0.005285649960026409 > ./result_10chains/node485_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_7_1 -p 531 -st topic485_7_0 -pt topic485_7_1 -u 0.016413966741462963 > ./result_10chains/node485_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_8_1 -p 749 -st topic485_8_0 -pt topic485_8_1 -u 0.0017470404596501773 > ./result_10chains/node485_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_9_1 -p 808 -st topic485_9_0 -pt topic485_9_1 -u 0.004589795379731573 > ./result_10chains/node485_9_1.txt &
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
    "./result_10chains/node485_0_1.txt 90"
    "./result_10chains/node485_1_1.txt 89"
    "./result_10chains/node485_2_1.txt 88"
    "./result_10chains/node485_3_1.txt 87"
    "./result_10chains/node485_4_1.txt 86"
    "./result_10chains/node485_5_1.txt 85"
    "./result_10chains/node485_6_1.txt 84"
    "./result_10chains/node485_7_1.txt 83"
    "./result_10chains/node485_8_1.txt 82"
    "./result_10chains/node485_9_1.txt 81"
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
