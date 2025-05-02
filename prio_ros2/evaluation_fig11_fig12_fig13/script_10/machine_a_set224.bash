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
ros2 run evaluation_3_randomdag uunifast_node -n node224_0_2 -p 177 -st topic224_0_1 -pt None -u 0.00037976692390706557 > ./result_10chains/node224_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_1_2 -p 182 -st topic224_1_1 -pt None -u 0.04988810219838247 > ./result_10chains/node224_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_2_2 -p 184 -st topic224_2_1 -pt None -u 0.004931855482743108 > ./result_10chains/node224_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_3_2 -p 379 -st topic224_3_1 -pt None -u 7.740147247470297e-05 > ./result_10chains/node224_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_4_2 -p 409 -st topic224_4_1 -pt None -u 0.0499734326678698 > ./result_10chains/node224_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_5_2 -p 510 -st topic224_5_1 -pt None -u 0.026457558204383225 > ./result_10chains/node224_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_6_2 -p 544 -st topic224_6_1 -pt None -u 0.0024133191030977774 > ./result_10chains/node224_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_7_2 -p 604 -st topic224_7_1 -pt None -u 0.0122715050669117 > ./result_10chains/node224_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_8_2 -p 882 -st topic224_8_1 -pt None -u 0.03974550354314031 > ./result_10chains/node224_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_9_2 -p 909 -st topic224_9_1 -pt None -u 0.020944168586768206 > ./result_10chains/node224_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_0_0 -p 177 -st none -pt topic224_0_0 -u 0.004404164550655731 > ./result_10chains/node224_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_1_0 -p 182 -st none -pt topic224_1_0 -u 0.016251615105750072 > ./result_10chains/node224_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_2_0 -p 184 -st none -pt topic224_2_0 -u 0.011007236930058728 > ./result_10chains/node224_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_3_0 -p 379 -st none -pt topic224_3_0 -u 0.006697056076197694 > ./result_10chains/node224_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_4_0 -p 409 -st none -pt topic224_4_0 -u 0.03501691504602422 > ./result_10chains/node224_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_5_0 -p 510 -st none -pt topic224_5_0 -u 0.015105698907394827 > ./result_10chains/node224_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_6_0 -p 544 -st none -pt topic224_6_0 -u 0.032776420304207576 > ./result_10chains/node224_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_7_0 -p 604 -st none -pt topic224_7_0 -u 0.008845078769698228 > ./result_10chains/node224_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_8_0 -p 882 -st none -pt topic224_8_0 -u 0.01195564132962837 > ./result_10chains/node224_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_9_0 -p 909 -st none -pt topic224_9_0 -u 0.01005988305272762 > ./result_10chains/node224_9_0.txt &
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
    "./result_10chains/node224_0_0.txt 90"
    "./result_10chains/node224_0_2.txt 90"
    "./result_10chains/node224_1_0.txt 89"
    "./result_10chains/node224_1_2.txt 89"
    "./result_10chains/node224_2_0.txt 88"
    "./result_10chains/node224_2_2.txt 88"
    "./result_10chains/node224_3_0.txt 87"
    "./result_10chains/node224_3_2.txt 87"
    "./result_10chains/node224_4_0.txt 86"
    "./result_10chains/node224_4_2.txt 86"
    "./result_10chains/node224_5_0.txt 85"
    "./result_10chains/node224_5_2.txt 85"
    "./result_10chains/node224_6_0.txt 84"
    "./result_10chains/node224_6_2.txt 84"
    "./result_10chains/node224_7_0.txt 83"
    "./result_10chains/node224_7_2.txt 83"
    "./result_10chains/node224_8_0.txt 82"
    "./result_10chains/node224_8_2.txt 82"
    "./result_10chains/node224_9_0.txt 81"
    "./result_10chains/node224_9_2.txt 81"
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
