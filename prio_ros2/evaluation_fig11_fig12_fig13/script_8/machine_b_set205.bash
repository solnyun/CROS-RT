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
ros2 run evaluation_3_randomdag uunifast_node -n node205_0_1 -p 125 -st topic205_0_0 -pt topic205_0_1 -u 0.009262805115353823 > ./result_8chains/node205_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_1_1 -p 237 -st topic205_1_0 -pt topic205_1_1 -u 0.05155871984289939 > ./result_8chains/node205_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_2_1 -p 255 -st topic205_2_0 -pt topic205_2_1 -u 0.02225196214550007 > ./result_8chains/node205_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_3_1 -p 375 -st topic205_3_0 -pt topic205_3_1 -u 0.007816451767445332 > ./result_8chains/node205_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_4_1 -p 539 -st topic205_4_0 -pt topic205_4_1 -u 0.006927432281910201 > ./result_8chains/node205_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_5_1 -p 860 -st topic205_5_0 -pt topic205_5_1 -u 0.007826047725128654 > ./result_8chains/node205_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_6_1 -p 882 -st topic205_6_0 -pt topic205_6_1 -u 0.027916684176941348 > ./result_8chains/node205_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_7_1 -p 984 -st topic205_7_0 -pt topic205_7_1 -u 0.017743671750417266 > ./result_8chains/node205_7_1.txt &
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
    "./result_8chains/node205_0_1.txt 90"
    "./result_8chains/node205_1_1.txt 89"
    "./result_8chains/node205_2_1.txt 88"
    "./result_8chains/node205_3_1.txt 87"
    "./result_8chains/node205_4_1.txt 86"
    "./result_8chains/node205_5_1.txt 85"
    "./result_8chains/node205_6_1.txt 84"
    "./result_8chains/node205_7_1.txt 83"
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
