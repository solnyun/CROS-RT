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
ros2 run evaluation_3_randomdag uunifast_node -n node132_0_2 -p 26 -st topic132_0_1 -pt None -u 0.013959165707564392 > ./result_8chains/node132_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_1_2 -p 59 -st topic132_1_1 -pt None -u 0.012435884336698455 > ./result_8chains/node132_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_2_2 -p 214 -st topic132_2_1 -pt None -u 0.015500311676705403 > ./result_8chains/node132_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_3_2 -p 288 -st topic132_3_1 -pt None -u 0.01608282288270102 > ./result_8chains/node132_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_4_2 -p 441 -st topic132_4_1 -pt None -u 0.007318355698006929 > ./result_8chains/node132_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_5_2 -p 828 -st topic132_5_1 -pt None -u 0.034104127351715474 > ./result_8chains/node132_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_6_2 -p 862 -st topic132_6_1 -pt None -u 0.0072833189653224994 > ./result_8chains/node132_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_7_2 -p 997 -st topic132_7_1 -pt None -u 0.11842289456574916 > ./result_8chains/node132_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_0_0 -p 26 -st none -pt topic132_0_0 -u 0.02042222316743414 > ./result_8chains/node132_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_1_0 -p 59 -st none -pt topic132_1_0 -u 0.005873328827391999 > ./result_8chains/node132_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_2_0 -p 214 -st none -pt topic132_2_0 -u 0.017515172518130506 > ./result_8chains/node132_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_3_0 -p 288 -st none -pt topic132_3_0 -u 0.03792984011877015 > ./result_8chains/node132_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_4_0 -p 441 -st none -pt topic132_4_0 -u 0.010607141683995847 > ./result_8chains/node132_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_5_0 -p 828 -st none -pt topic132_5_0 -u 0.05117363061414448 > ./result_8chains/node132_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node132_6_0 -p 862 -st none -pt topic132_6_0 -u 0.0031659383715122724 > ./result_8chains/node132_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node132_7_0 -p 997 -st none -pt topic132_7_0 -u 0.03082169042414168 > ./result_8chains/node132_7_0.txt &
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
    "./result_8chains/node132_0_0.txt 90"
    "./result_8chains/node132_0_2.txt 90"
    "./result_8chains/node132_1_0.txt 89"
    "./result_8chains/node132_1_2.txt 89"
    "./result_8chains/node132_2_0.txt 88"
    "./result_8chains/node132_2_2.txt 88"
    "./result_8chains/node132_3_0.txt 87"
    "./result_8chains/node132_3_2.txt 87"
    "./result_8chains/node132_4_0.txt 86"
    "./result_8chains/node132_4_2.txt 86"
    "./result_8chains/node132_5_0.txt 85"
    "./result_8chains/node132_5_2.txt 85"
    "./result_8chains/node132_6_0.txt 84"
    "./result_8chains/node132_6_2.txt 84"
    "./result_8chains/node132_7_0.txt 83"
    "./result_8chains/node132_7_2.txt 83"
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
