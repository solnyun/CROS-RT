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
ros2 run evaluation_3_randomdag uunifast_node -n node25_0_2 -p 484 -st topic25_0_1 -pt None -u 0.014010505492833114 > ./result_4chains/node25_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_1_2 -p 552 -st topic25_1_1 -pt None -u 0.10853828130334778 > ./result_4chains/node25_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_2_2 -p 786 -st topic25_2_1 -pt None -u 0.04808626389742449 > ./result_4chains/node25_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_3_2 -p 943 -st topic25_3_1 -pt None -u 0.00506344371105264 > ./result_4chains/node25_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_0_0 -p 484 -st none -pt topic25_0_0 -u 0.11217526632154429 > ./result_4chains/node25_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_1_0 -p 552 -st none -pt topic25_1_0 -u 0.04842898969903342 > ./result_4chains/node25_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_2_0 -p 786 -st none -pt topic25_2_0 -u 0.05151106680097467 > ./result_4chains/node25_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_3_0 -p 943 -st none -pt topic25_3_0 -u 0.0004186207751514029 > ./result_4chains/node25_3_0.txt &
sleep 10
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
    "./result_4chains/node25_0_0.txt 90"
    "./result_4chains/node25_0_2.txt 90"
    "./result_4chains/node25_1_0.txt 89"
    "./result_4chains/node25_1_2.txt 89"
    "./result_4chains/node25_2_0.txt 88"
    "./result_4chains/node25_2_2.txt 88"
    "./result_4chains/node25_3_0.txt 87"
    "./result_4chains/node25_3_2.txt 87"
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
sleep 70s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 40s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
