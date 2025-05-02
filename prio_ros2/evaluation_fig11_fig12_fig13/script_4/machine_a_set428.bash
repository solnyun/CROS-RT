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
ros2 run evaluation_3_randomdag uunifast_node -n node428_0_2 -p 37 -st topic428_0_1 -pt None -u 0.023027927070962184 > ./result_4chains/node428_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_1_2 -p 194 -st topic428_1_1 -pt None -u 0.008672705260557162 > ./result_4chains/node428_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_2_2 -p 611 -st topic428_2_1 -pt None -u 0.006923052324815895 > ./result_4chains/node428_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_3_2 -p 789 -st topic428_3_1 -pt None -u 0.012787634201409343 > ./result_4chains/node428_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_0_0 -p 37 -st none -pt topic428_0_0 -u 0.1323647697232806 > ./result_4chains/node428_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_1_0 -p 194 -st none -pt topic428_1_0 -u 0.051844355112928286 > ./result_4chains/node428_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_2_0 -p 611 -st none -pt topic428_2_0 -u 0.004984843775790143 > ./result_4chains/node428_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_3_0 -p 789 -st none -pt topic428_3_0 -u 0.025392058095469152 > ./result_4chains/node428_3_0.txt &
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
    "./result_4chains/node428_0_0.txt 90"
    "./result_4chains/node428_0_2.txt 90"
    "./result_4chains/node428_1_0.txt 89"
    "./result_4chains/node428_1_2.txt 89"
    "./result_4chains/node428_2_0.txt 88"
    "./result_4chains/node428_2_2.txt 88"
    "./result_4chains/node428_3_0.txt 87"
    "./result_4chains/node428_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
