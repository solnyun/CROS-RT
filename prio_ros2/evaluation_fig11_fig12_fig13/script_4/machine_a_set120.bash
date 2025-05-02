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
ros2 run evaluation_3_randomdag uunifast_node -n node120_0_2 -p 90 -st topic120_0_1 -pt None -u 0.0544593931674876 > ./result_4chains/node120_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_1_2 -p 305 -st topic120_1_1 -pt None -u 0.0005838775207578917 > ./result_4chains/node120_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_2_2 -p 317 -st topic120_2_1 -pt None -u 0.03387951191787894 > ./result_4chains/node120_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_3_2 -p 783 -st topic120_3_1 -pt None -u 0.012357953608040085 > ./result_4chains/node120_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_0_0 -p 90 -st none -pt topic120_0_0 -u 0.020510265853470433 > ./result_4chains/node120_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_1_0 -p 305 -st none -pt topic120_1_0 -u 0.02615117611389911 > ./result_4chains/node120_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_2_0 -p 317 -st none -pt topic120_2_0 -u 0.052087377141107255 > ./result_4chains/node120_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_3_0 -p 783 -st none -pt topic120_3_0 -u 0.03574029208808284 > ./result_4chains/node120_3_0.txt &
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
    "./result_4chains/node120_0_0.txt 90"
    "./result_4chains/node120_0_2.txt 90"
    "./result_4chains/node120_1_0.txt 89"
    "./result_4chains/node120_1_2.txt 89"
    "./result_4chains/node120_2_0.txt 88"
    "./result_4chains/node120_2_2.txt 88"
    "./result_4chains/node120_3_0.txt 87"
    "./result_4chains/node120_3_2.txt 87"
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
