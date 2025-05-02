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
ros2 run evaluation_3_randomdag uunifast_node -n node86_0_2 -p 145 -st topic86_0_1 -pt None -u 0.006277100283430981 > ./result_10chains/node86_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_1_2 -p 240 -st topic86_1_1 -pt None -u 0.04268268614099807 > ./result_10chains/node86_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_2_2 -p 244 -st topic86_2_1 -pt None -u 0.0013993761649095937 > ./result_10chains/node86_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_3_2 -p 258 -st topic86_3_1 -pt None -u 0.0018747309661985012 > ./result_10chains/node86_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_4_2 -p 400 -st topic86_4_1 -pt None -u 0.020434324856684394 > ./result_10chains/node86_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_5_2 -p 705 -st topic86_5_1 -pt None -u 0.04820118093485801 > ./result_10chains/node86_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_6_2 -p 758 -st topic86_6_1 -pt None -u 0.010899253024960087 > ./result_10chains/node86_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_7_2 -p 816 -st topic86_7_1 -pt None -u 0.001433224290150359 > ./result_10chains/node86_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_8_2 -p 830 -st topic86_8_1 -pt None -u 0.06351493075176853 > ./result_10chains/node86_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_9_2 -p 862 -st topic86_9_1 -pt None -u 0.006992066455133737 > ./result_10chains/node86_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_0_0 -p 145 -st none -pt topic86_0_0 -u 0.04515139813577468 > ./result_10chains/node86_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_1_0 -p 240 -st none -pt topic86_1_0 -u 0.00010094336573257534 > ./result_10chains/node86_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_2_0 -p 244 -st none -pt topic86_2_0 -u 0.008315886115135673 > ./result_10chains/node86_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_3_0 -p 258 -st none -pt topic86_3_0 -u 0.030513461726800972 > ./result_10chains/node86_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_4_0 -p 400 -st none -pt topic86_4_0 -u 0.022091620701543413 > ./result_10chains/node86_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_5_0 -p 705 -st none -pt topic86_5_0 -u 0.01740141416506441 > ./result_10chains/node86_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_6_0 -p 758 -st none -pt topic86_6_0 -u 0.000739603089141283 > ./result_10chains/node86_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_7_0 -p 816 -st none -pt topic86_7_0 -u 0.007615618653944528 > ./result_10chains/node86_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_8_0 -p 830 -st none -pt topic86_8_0 -u 0.019465585285217316 > ./result_10chains/node86_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_9_0 -p 862 -st none -pt topic86_9_0 -u 0.031101079495953077 > ./result_10chains/node86_9_0.txt &
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
    "./result_10chains/node86_0_0.txt 90"
    "./result_10chains/node86_0_2.txt 90"
    "./result_10chains/node86_1_0.txt 89"
    "./result_10chains/node86_1_2.txt 89"
    "./result_10chains/node86_2_0.txt 88"
    "./result_10chains/node86_2_2.txt 88"
    "./result_10chains/node86_3_0.txt 87"
    "./result_10chains/node86_3_2.txt 87"
    "./result_10chains/node86_4_0.txt 86"
    "./result_10chains/node86_4_2.txt 86"
    "./result_10chains/node86_5_0.txt 85"
    "./result_10chains/node86_5_2.txt 85"
    "./result_10chains/node86_6_0.txt 84"
    "./result_10chains/node86_6_2.txt 84"
    "./result_10chains/node86_7_0.txt 83"
    "./result_10chains/node86_7_2.txt 83"
    "./result_10chains/node86_8_0.txt 82"
    "./result_10chains/node86_8_2.txt 82"
    "./result_10chains/node86_9_0.txt 81"
    "./result_10chains/node86_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
