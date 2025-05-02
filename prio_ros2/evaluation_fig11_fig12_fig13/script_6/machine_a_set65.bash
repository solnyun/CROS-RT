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
ros2 run evaluation_3_randomdag uunifast_node -n node65_0_2 -p 113 -st topic65_0_1 -pt None -u 0.023574020147582586 > ./result_6chains/node65_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_1_2 -p 229 -st topic65_1_1 -pt None -u 0.01412201657468648 > ./result_6chains/node65_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_2_2 -p 315 -st topic65_2_1 -pt None -u 0.07687825829946987 > ./result_6chains/node65_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_3_2 -p 366 -st topic65_3_1 -pt None -u 0.01391125711748048 > ./result_6chains/node65_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_4_2 -p 930 -st topic65_4_1 -pt None -u 0.01818290626563489 > ./result_6chains/node65_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_5_2 -p 979 -st topic65_5_1 -pt None -u 0.007455518020473711 > ./result_6chains/node65_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_0_0 -p 113 -st none -pt topic65_0_0 -u 0.04108656980270414 > ./result_6chains/node65_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_1_0 -p 229 -st none -pt topic65_1_0 -u 0.05277759908556062 > ./result_6chains/node65_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_2_0 -p 315 -st none -pt topic65_2_0 -u 0.028647154890509785 > ./result_6chains/node65_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_3_0 -p 366 -st none -pt topic65_3_0 -u 0.03674464798159466 > ./result_6chains/node65_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_4_0 -p 930 -st none -pt topic65_4_0 -u 0.028562811009925818 > ./result_6chains/node65_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node65_5_0 -p 979 -st none -pt topic65_5_0 -u 0.007521928786516439 > ./result_6chains/node65_5_0.txt &
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
    "./result_6chains/node65_0_0.txt 90"
    "./result_6chains/node65_0_2.txt 90"
    "./result_6chains/node65_1_0.txt 89"
    "./result_6chains/node65_1_2.txt 89"
    "./result_6chains/node65_2_0.txt 88"
    "./result_6chains/node65_2_2.txt 88"
    "./result_6chains/node65_3_0.txt 87"
    "./result_6chains/node65_3_2.txt 87"
    "./result_6chains/node65_4_0.txt 86"
    "./result_6chains/node65_4_2.txt 86"
    "./result_6chains/node65_5_0.txt 85"
    "./result_6chains/node65_5_2.txt 85"
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
