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
ros2 run evaluation_3_randomdag uunifast_node -n node422_0_1 -p 123 -st topic422_0_0 -pt topic422_0_1 -u 0.0021778926697882395 > ./result_8chains/node422_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_1_1 -p 312 -st topic422_1_0 -pt topic422_1_1 -u 0.007915527571915493 > ./result_8chains/node422_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_2_1 -p 438 -st topic422_2_0 -pt topic422_2_1 -u 0.01729637351491492 > ./result_8chains/node422_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_3_1 -p 503 -st topic422_3_0 -pt topic422_3_1 -u 0.0037400536053108224 > ./result_8chains/node422_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_4_1 -p 737 -st topic422_4_0 -pt topic422_4_1 -u 0.06269164112080311 > ./result_8chains/node422_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_5_1 -p 801 -st topic422_5_0 -pt topic422_5_1 -u 0.011393922938874756 > ./result_8chains/node422_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_6_1 -p 927 -st topic422_6_0 -pt topic422_6_1 -u 0.00922125137218692 > ./result_8chains/node422_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_7_1 -p 991 -st topic422_7_0 -pt topic422_7_1 -u 0.046201090902137504 > ./result_8chains/node422_7_1.txt &
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
    "./result_8chains/node422_0_1.txt 90"
    "./result_8chains/node422_1_1.txt 89"
    "./result_8chains/node422_2_1.txt 88"
    "./result_8chains/node422_3_1.txt 87"
    "./result_8chains/node422_4_1.txt 86"
    "./result_8chains/node422_5_1.txt 85"
    "./result_8chains/node422_6_1.txt 84"
    "./result_8chains/node422_7_1.txt 83"
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
