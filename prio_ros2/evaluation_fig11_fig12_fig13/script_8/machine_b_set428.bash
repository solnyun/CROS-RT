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
ros2 run evaluation_3_randomdag uunifast_node -n node428_0_1 -p 275 -st topic428_0_0 -pt topic428_0_1 -u 0.03142354501850908 > ./result_8chains/node428_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_1_1 -p 361 -st topic428_1_0 -pt topic428_1_1 -u 0.0030662371463466287 > ./result_8chains/node428_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_2_1 -p 466 -st topic428_2_0 -pt topic428_2_1 -u 0.04521080539630751 > ./result_8chains/node428_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_3_1 -p 837 -st topic428_3_0 -pt topic428_3_1 -u 0.010622141431462895 > ./result_8chains/node428_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_4_1 -p 857 -st topic428_4_0 -pt topic428_4_1 -u 0.008186245260259961 > ./result_8chains/node428_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_5_1 -p 860 -st topic428_5_0 -pt topic428_5_1 -u 0.019792916347136702 > ./result_8chains/node428_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_6_1 -p 922 -st topic428_6_0 -pt topic428_6_1 -u 0.04729134258250739 > ./result_8chains/node428_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_7_1 -p 953 -st topic428_7_0 -pt topic428_7_1 -u 0.04698120271986683 > ./result_8chains/node428_7_1.txt &
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
    "./result_8chains/node428_0_1.txt 90"
    "./result_8chains/node428_1_1.txt 89"
    "./result_8chains/node428_2_1.txt 88"
    "./result_8chains/node428_3_1.txt 87"
    "./result_8chains/node428_4_1.txt 86"
    "./result_8chains/node428_5_1.txt 85"
    "./result_8chains/node428_6_1.txt 84"
    "./result_8chains/node428_7_1.txt 83"
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
