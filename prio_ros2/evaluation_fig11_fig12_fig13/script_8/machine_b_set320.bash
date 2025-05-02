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
ros2 run evaluation_3_randomdag uunifast_node -n node320_0_1 -p 99 -st topic320_0_0 -pt topic320_0_1 -u 0.010422028750784296 > ./result_8chains/node320_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_1_1 -p 389 -st topic320_1_0 -pt topic320_1_1 -u 0.08275906764677282 > ./result_8chains/node320_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_2_1 -p 649 -st topic320_2_0 -pt topic320_2_1 -u 0.05821748836560098 > ./result_8chains/node320_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_3_1 -p 873 -st topic320_3_0 -pt topic320_3_1 -u 0.030991478761948132 > ./result_8chains/node320_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_4_1 -p 908 -st topic320_4_0 -pt topic320_4_1 -u 0.03011843518620333 > ./result_8chains/node320_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_5_1 -p 910 -st topic320_5_0 -pt topic320_5_1 -u 0.025410084567105112 > ./result_8chains/node320_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_6_1 -p 969 -st topic320_6_0 -pt topic320_6_1 -u 0.05501477576146685 > ./result_8chains/node320_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_7_1 -p 990 -st topic320_7_0 -pt topic320_7_1 -u 0.02977821295264856 > ./result_8chains/node320_7_1.txt &
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
    "./result_8chains/node320_0_1.txt 90"
    "./result_8chains/node320_1_1.txt 89"
    "./result_8chains/node320_2_1.txt 88"
    "./result_8chains/node320_3_1.txt 87"
    "./result_8chains/node320_4_1.txt 86"
    "./result_8chains/node320_5_1.txt 85"
    "./result_8chains/node320_6_1.txt 84"
    "./result_8chains/node320_7_1.txt 83"
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
