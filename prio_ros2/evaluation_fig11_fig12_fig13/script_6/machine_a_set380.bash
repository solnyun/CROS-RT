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
ros2 run evaluation_3_randomdag uunifast_node -n node380_0_2 -p 123 -st topic380_0_1 -pt None -u 0.04623976756023007 > ./result_6chains/node380_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_1_2 -p 255 -st topic380_1_1 -pt None -u 0.03935243398629751 > ./result_6chains/node380_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_2_2 -p 374 -st topic380_2_1 -pt None -u 0.0246275582398576 > ./result_6chains/node380_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_3_2 -p 583 -st topic380_3_1 -pt None -u 0.009133844490074025 > ./result_6chains/node380_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_4_2 -p 918 -st topic380_4_1 -pt None -u 0.002311793037887481 > ./result_6chains/node380_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_5_2 -p 942 -st topic380_5_1 -pt None -u 0.007893997292038492 > ./result_6chains/node380_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_0_0 -p 123 -st none -pt topic380_0_0 -u 0.02646067975515537 > ./result_6chains/node380_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_1_0 -p 255 -st none -pt topic380_1_0 -u 0.044697967760491675 > ./result_6chains/node380_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_2_0 -p 374 -st none -pt topic380_2_0 -u 0.07122835328101315 > ./result_6chains/node380_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_3_0 -p 583 -st none -pt topic380_3_0 -u 0.12863791950725528 > ./result_6chains/node380_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_4_0 -p 918 -st none -pt topic380_4_0 -u 0.0056911162772459445 > ./result_6chains/node380_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_5_0 -p 942 -st none -pt topic380_5_0 -u 0.015516627924385282 > ./result_6chains/node380_5_0.txt &
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
    "./result_6chains/node380_0_0.txt 90"
    "./result_6chains/node380_0_2.txt 90"
    "./result_6chains/node380_1_0.txt 89"
    "./result_6chains/node380_1_2.txt 89"
    "./result_6chains/node380_2_0.txt 88"
    "./result_6chains/node380_2_2.txt 88"
    "./result_6chains/node380_3_0.txt 87"
    "./result_6chains/node380_3_2.txt 87"
    "./result_6chains/node380_4_0.txt 86"
    "./result_6chains/node380_4_2.txt 86"
    "./result_6chains/node380_5_0.txt 85"
    "./result_6chains/node380_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
