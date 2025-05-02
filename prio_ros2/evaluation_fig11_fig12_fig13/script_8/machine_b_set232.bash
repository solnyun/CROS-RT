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
ros2 run evaluation_3_randomdag uunifast_node -n node232_0_1 -p 149 -st topic232_0_0 -pt topic232_0_1 -u 0.004378192555783367 > ./result_8chains/node232_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_1_1 -p 189 -st topic232_1_0 -pt topic232_1_1 -u 0.00018009365643884 > ./result_8chains/node232_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_2_1 -p 450 -st topic232_2_0 -pt topic232_2_1 -u 0.04182172812817514 > ./result_8chains/node232_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_3_1 -p 501 -st topic232_3_0 -pt topic232_3_1 -u 0.038516020289490804 > ./result_8chains/node232_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_4_1 -p 625 -st topic232_4_0 -pt topic232_4_1 -u 0.060629913882898484 > ./result_8chains/node232_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_5_1 -p 638 -st topic232_5_0 -pt topic232_5_1 -u 0.00502754499958874 > ./result_8chains/node232_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_6_1 -p 769 -st topic232_6_0 -pt topic232_6_1 -u 0.023922806749770598 > ./result_8chains/node232_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_7_1 -p 843 -st topic232_7_0 -pt topic232_7_1 -u 0.01950507414559559 > ./result_8chains/node232_7_1.txt &
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
    "./result_8chains/node232_0_1.txt 90"
    "./result_8chains/node232_1_1.txt 89"
    "./result_8chains/node232_2_1.txt 88"
    "./result_8chains/node232_3_1.txt 87"
    "./result_8chains/node232_4_1.txt 86"
    "./result_8chains/node232_5_1.txt 85"
    "./result_8chains/node232_6_1.txt 84"
    "./result_8chains/node232_7_1.txt 83"
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
