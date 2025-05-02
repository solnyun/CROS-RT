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
ros2 run evaluation_3_randomdag uunifast_node -n node404_0_2 -p 50 -st topic404_0_1 -pt None -u 0.028652692038824368 > ./result_4chains/node404_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_1_2 -p 298 -st topic404_1_1 -pt None -u 0.019673100516629904 > ./result_4chains/node404_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_2_2 -p 543 -st topic404_2_1 -pt None -u 0.05245176154062191 > ./result_4chains/node404_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_3_2 -p 858 -st topic404_3_1 -pt None -u 0.06786974419346434 > ./result_4chains/node404_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_0_0 -p 50 -st none -pt topic404_0_0 -u 0.04757796224464533 > ./result_4chains/node404_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_1_0 -p 298 -st none -pt topic404_1_0 -u 0.03433168982341189 > ./result_4chains/node404_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_2_0 -p 543 -st none -pt topic404_2_0 -u 0.018505008986442723 > ./result_4chains/node404_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node404_3_0 -p 858 -st none -pt topic404_3_0 -u 0.005703280727058863 > ./result_4chains/node404_3_0.txt &
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
    "./result_4chains/node404_0_0.txt 90"
    "./result_4chains/node404_0_2.txt 90"
    "./result_4chains/node404_1_0.txt 89"
    "./result_4chains/node404_1_2.txt 89"
    "./result_4chains/node404_2_0.txt 88"
    "./result_4chains/node404_2_2.txt 88"
    "./result_4chains/node404_3_0.txt 87"
    "./result_4chains/node404_3_2.txt 87"
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
