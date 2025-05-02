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
ros2 run evaluation_3_randomdag uunifast_node -n node242_0_1 -p 119 -st topic242_0_0 -pt topic242_0_1 -u 0.030385832869216423 > ./result_10chains/node242_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_1_1 -p 222 -st topic242_1_0 -pt topic242_1_1 -u 0.017163865735789874 > ./result_10chains/node242_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_2_1 -p 270 -st topic242_2_0 -pt topic242_2_1 -u 0.0004297086069476874 > ./result_10chains/node242_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_3_1 -p 356 -st topic242_3_0 -pt topic242_3_1 -u 0.0065820316670224255 > ./result_10chains/node242_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_4_1 -p 393 -st topic242_4_0 -pt topic242_4_1 -u 0.040570502273557185 > ./result_10chains/node242_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_5_1 -p 503 -st topic242_5_0 -pt topic242_5_1 -u 0.016488469237709025 > ./result_10chains/node242_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_6_1 -p 764 -st topic242_6_0 -pt topic242_6_1 -u 0.030364316270986375 > ./result_10chains/node242_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_7_1 -p 828 -st topic242_7_0 -pt topic242_7_1 -u 0.020422930121369712 > ./result_10chains/node242_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_8_1 -p 892 -st topic242_8_0 -pt topic242_8_1 -u 0.01908886234200073 > ./result_10chains/node242_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_9_1 -p 910 -st topic242_9_0 -pt topic242_9_1 -u 0.018036085945645028 > ./result_10chains/node242_9_1.txt &
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
    "./result_10chains/node242_0_1.txt 90"
    "./result_10chains/node242_1_1.txt 89"
    "./result_10chains/node242_2_1.txt 88"
    "./result_10chains/node242_3_1.txt 87"
    "./result_10chains/node242_4_1.txt 86"
    "./result_10chains/node242_5_1.txt 85"
    "./result_10chains/node242_6_1.txt 84"
    "./result_10chains/node242_7_1.txt 83"
    "./result_10chains/node242_8_1.txt 82"
    "./result_10chains/node242_9_1.txt 81"
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
