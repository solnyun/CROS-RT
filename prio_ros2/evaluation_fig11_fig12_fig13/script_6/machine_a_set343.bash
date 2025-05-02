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
ros2 run evaluation_3_randomdag uunifast_node -n node343_0_2 -p 301 -st topic343_0_1 -pt None -u 0.06531381958922161 > ./result_6chains/node343_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_1_2 -p 375 -st topic343_1_1 -pt None -u 0.045502451713387515 > ./result_6chains/node343_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_2_2 -p 426 -st topic343_2_1 -pt None -u 0.007730449109616844 > ./result_6chains/node343_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_3_2 -p 434 -st topic343_3_1 -pt None -u 0.0505392671112829 > ./result_6chains/node343_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_4_2 -p 641 -st topic343_4_1 -pt None -u 0.029669105171411053 > ./result_6chains/node343_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_5_2 -p 665 -st topic343_5_1 -pt None -u 0.020167681986387836 > ./result_6chains/node343_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_0_0 -p 301 -st none -pt topic343_0_0 -u 0.01075812980655938 > ./result_6chains/node343_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_1_0 -p 375 -st none -pt topic343_1_0 -u 0.02325867693512723 > ./result_6chains/node343_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_2_0 -p 426 -st none -pt topic343_2_0 -u 0.00767476088755864 > ./result_6chains/node343_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_3_0 -p 434 -st none -pt topic343_3_0 -u 0.005380489558047041 > ./result_6chains/node343_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_4_0 -p 641 -st none -pt topic343_4_0 -u 0.020250818506143575 > ./result_6chains/node343_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node343_5_0 -p 665 -st none -pt topic343_5_0 -u 0.0737345965331456 > ./result_6chains/node343_5_0.txt &
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
    "./result_6chains/node343_0_0.txt 90"
    "./result_6chains/node343_0_2.txt 90"
    "./result_6chains/node343_1_0.txt 89"
    "./result_6chains/node343_1_2.txt 89"
    "./result_6chains/node343_2_0.txt 88"
    "./result_6chains/node343_2_2.txt 88"
    "./result_6chains/node343_3_0.txt 87"
    "./result_6chains/node343_3_2.txt 87"
    "./result_6chains/node343_4_0.txt 86"
    "./result_6chains/node343_4_2.txt 86"
    "./result_6chains/node343_5_0.txt 85"
    "./result_6chains/node343_5_2.txt 85"
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
