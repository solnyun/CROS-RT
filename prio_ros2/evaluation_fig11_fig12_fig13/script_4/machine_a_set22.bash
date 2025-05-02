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
ros2 run evaluation_3_randomdag uunifast_node -n node22_0_2 -p 141 -st topic22_0_1 -pt None -u 0.012694202975096491 > ./result_4chains/node22_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_1_2 -p 444 -st topic22_1_1 -pt None -u 0.0029108549890480284 > ./result_4chains/node22_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_2_2 -p 653 -st topic22_2_1 -pt None -u 0.21216438027071474 > ./result_4chains/node22_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_3_2 -p 694 -st topic22_3_1 -pt None -u 0.03379483079414708 > ./result_4chains/node22_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_0_0 -p 141 -st none -pt topic22_0_0 -u 0.012244438651052236 > ./result_4chains/node22_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_1_0 -p 444 -st none -pt topic22_1_0 -u 0.006164610560500938 > ./result_4chains/node22_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node22_2_0 -p 653 -st none -pt topic22_2_0 -u 0.05567518441881186 > ./result_4chains/node22_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node22_3_0 -p 694 -st none -pt topic22_3_0 -u 0.01648524573941701 > ./result_4chains/node22_3_0.txt &
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
    "./result_4chains/node22_0_0.txt 90"
    "./result_4chains/node22_0_2.txt 90"
    "./result_4chains/node22_1_0.txt 89"
    "./result_4chains/node22_1_2.txt 89"
    "./result_4chains/node22_2_0.txt 88"
    "./result_4chains/node22_2_2.txt 88"
    "./result_4chains/node22_3_0.txt 87"
    "./result_4chains/node22_3_2.txt 87"
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
