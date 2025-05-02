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
ros2 run evaluation_3_randomdag uunifast_node -n node133_0_1 -p 83 -st topic133_0_0 -pt topic133_0_1 -u 0.06340621339680441 > ./result_8chains/node133_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_1_1 -p 237 -st topic133_1_0 -pt topic133_1_1 -u 0.009453313524425744 > ./result_8chains/node133_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_2_1 -p 279 -st topic133_2_0 -pt topic133_2_1 -u 0.08480960689614031 > ./result_8chains/node133_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_3_1 -p 451 -st topic133_3_0 -pt topic133_3_1 -u 0.006873446657069654 > ./result_8chains/node133_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_4_1 -p 489 -st topic133_4_0 -pt topic133_4_1 -u 0.002031578521052374 > ./result_8chains/node133_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_5_1 -p 812 -st topic133_5_0 -pt topic133_5_1 -u 0.03269356965152685 > ./result_8chains/node133_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_6_1 -p 924 -st topic133_6_0 -pt topic133_6_1 -u 0.01912959691236829 > ./result_8chains/node133_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node133_7_1 -p 936 -st topic133_7_0 -pt topic133_7_1 -u 0.007313158938035667 > ./result_8chains/node133_7_1.txt &
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
    "./result_8chains/node133_0_1.txt 90"
    "./result_8chains/node133_1_1.txt 89"
    "./result_8chains/node133_2_1.txt 88"
    "./result_8chains/node133_3_1.txt 87"
    "./result_8chains/node133_4_1.txt 86"
    "./result_8chains/node133_5_1.txt 85"
    "./result_8chains/node133_6_1.txt 84"
    "./result_8chains/node133_7_1.txt 83"
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
