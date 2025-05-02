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
ros2 run evaluation_3_randomdag uunifast_node -n node234_0_1 -p 108 -st topic234_0_0 -pt topic234_0_1 -u 0.03706898737641412 > ./result_10chains/node234_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_1_1 -p 296 -st topic234_1_0 -pt topic234_1_1 -u 0.004727403415153819 > ./result_10chains/node234_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_2_1 -p 345 -st topic234_2_0 -pt topic234_2_1 -u 0.0198782958169354 > ./result_10chains/node234_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_3_1 -p 372 -st topic234_3_0 -pt topic234_3_1 -u 0.014379448461307565 > ./result_10chains/node234_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_4_1 -p 418 -st topic234_4_0 -pt topic234_4_1 -u 0.009092044217051287 > ./result_10chains/node234_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_5_1 -p 531 -st topic234_5_0 -pt topic234_5_1 -u 0.019792503601017142 > ./result_10chains/node234_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_6_1 -p 578 -st topic234_6_0 -pt topic234_6_1 -u 0.00479481366744644 > ./result_10chains/node234_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_7_1 -p 692 -st topic234_7_0 -pt topic234_7_1 -u 0.0651652483549511 > ./result_10chains/node234_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_8_1 -p 731 -st topic234_8_0 -pt topic234_8_1 -u 0.012920277175788933 > ./result_10chains/node234_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_9_1 -p 787 -st topic234_9_0 -pt topic234_9_1 -u 0.0016330776313541909 > ./result_10chains/node234_9_1.txt &
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
    "./result_10chains/node234_0_1.txt 90"
    "./result_10chains/node234_1_1.txt 89"
    "./result_10chains/node234_2_1.txt 88"
    "./result_10chains/node234_3_1.txt 87"
    "./result_10chains/node234_4_1.txt 86"
    "./result_10chains/node234_5_1.txt 85"
    "./result_10chains/node234_6_1.txt 84"
    "./result_10chains/node234_7_1.txt 83"
    "./result_10chains/node234_8_1.txt 82"
    "./result_10chains/node234_9_1.txt 81"
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
