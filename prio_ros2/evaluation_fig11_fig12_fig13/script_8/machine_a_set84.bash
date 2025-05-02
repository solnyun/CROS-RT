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
ros2 run evaluation_3_randomdag uunifast_node -n node84_0_2 -p 73 -st topic84_0_1 -pt None -u 0.018891666777515026 > ./result_8chains/node84_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_1_2 -p 127 -st topic84_1_1 -pt None -u 0.009244698637703497 > ./result_8chains/node84_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_2_2 -p 211 -st topic84_2_1 -pt None -u 0.0061297865564171605 > ./result_8chains/node84_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_3_2 -p 302 -st topic84_3_1 -pt None -u 0.013690676596266493 > ./result_8chains/node84_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_4_2 -p 423 -st topic84_4_1 -pt None -u 0.03857757254933497 > ./result_8chains/node84_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_5_2 -p 449 -st topic84_5_1 -pt None -u 0.03616751528214518 > ./result_8chains/node84_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_6_2 -p 450 -st topic84_6_1 -pt None -u 0.041572352965831 > ./result_8chains/node84_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_7_2 -p 719 -st topic84_7_1 -pt None -u 0.0031252853902760443 > ./result_8chains/node84_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_0_0 -p 73 -st none -pt topic84_0_0 -u 0.01858007303429232 > ./result_8chains/node84_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_1_0 -p 127 -st none -pt topic84_1_0 -u 0.011667929899359386 > ./result_8chains/node84_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_2_0 -p 211 -st none -pt topic84_2_0 -u 0.051366893554167015 > ./result_8chains/node84_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_3_0 -p 302 -st none -pt topic84_3_0 -u 0.0017064208746750409 > ./result_8chains/node84_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_4_0 -p 423 -st none -pt topic84_4_0 -u 0.01226439637249882 > ./result_8chains/node84_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_5_0 -p 449 -st none -pt topic84_5_0 -u 0.08308362205955333 > ./result_8chains/node84_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_6_0 -p 450 -st none -pt topic84_6_0 -u 0.04028174209765886 > ./result_8chains/node84_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_7_0 -p 719 -st none -pt topic84_7_0 -u 0.005754042048279711 > ./result_8chains/node84_7_0.txt &
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
    "./result_8chains/node84_0_0.txt 90"
    "./result_8chains/node84_0_2.txt 90"
    "./result_8chains/node84_1_0.txt 89"
    "./result_8chains/node84_1_2.txt 89"
    "./result_8chains/node84_2_0.txt 88"
    "./result_8chains/node84_2_2.txt 88"
    "./result_8chains/node84_3_0.txt 87"
    "./result_8chains/node84_3_2.txt 87"
    "./result_8chains/node84_4_0.txt 86"
    "./result_8chains/node84_4_2.txt 86"
    "./result_8chains/node84_5_0.txt 85"
    "./result_8chains/node84_5_2.txt 85"
    "./result_8chains/node84_6_0.txt 84"
    "./result_8chains/node84_6_2.txt 84"
    "./result_8chains/node84_7_0.txt 83"
    "./result_8chains/node84_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
