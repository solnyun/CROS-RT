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
ros2 run evaluation_3_randomdag uunifast_node -n node262_0_2 -p 140 -st topic262_0_1 -pt None -u 0.024422659583392625 > ./result_10chains/node262_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_1_2 -p 253 -st topic262_1_1 -pt None -u 0.01705601144028296 > ./result_10chains/node262_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_2_2 -p 282 -st topic262_2_1 -pt None -u 0.020082897721507675 > ./result_10chains/node262_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_3_2 -p 378 -st topic262_3_1 -pt None -u 0.011640121607031206 > ./result_10chains/node262_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_4_2 -p 435 -st topic262_4_1 -pt None -u 0.003193613545725449 > ./result_10chains/node262_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_5_2 -p 675 -st topic262_5_1 -pt None -u 0.005857142842038948 > ./result_10chains/node262_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_6_2 -p 689 -st topic262_6_1 -pt None -u 0.014182598405314772 > ./result_10chains/node262_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_7_2 -p 709 -st topic262_7_1 -pt None -u 0.005545984696437092 > ./result_10chains/node262_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_8_2 -p 780 -st topic262_8_1 -pt None -u 0.04263343547165105 > ./result_10chains/node262_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_9_2 -p 860 -st topic262_9_1 -pt None -u 0.017171769013170243 > ./result_10chains/node262_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_0_0 -p 140 -st none -pt topic262_0_0 -u 0.0002381808767550897 > ./result_10chains/node262_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_1_0 -p 253 -st none -pt topic262_1_0 -u 0.049195416853000995 > ./result_10chains/node262_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_2_0 -p 282 -st none -pt topic262_2_0 -u 0.0008693419025925242 > ./result_10chains/node262_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_3_0 -p 378 -st none -pt topic262_3_0 -u 0.015505958178870738 > ./result_10chains/node262_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_4_0 -p 435 -st none -pt topic262_4_0 -u 0.002553282742190688 > ./result_10chains/node262_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_5_0 -p 675 -st none -pt topic262_5_0 -u 0.046309586392700386 > ./result_10chains/node262_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_6_0 -p 689 -st none -pt topic262_6_0 -u 0.006950279092119704 > ./result_10chains/node262_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_7_0 -p 709 -st none -pt topic262_7_0 -u 0.0008347404533779468 > ./result_10chains/node262_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_8_0 -p 780 -st none -pt topic262_8_0 -u 0.015883923081515913 > ./result_10chains/node262_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_9_0 -p 860 -st none -pt topic262_9_0 -u 0.016213223159282402 > ./result_10chains/node262_9_0.txt &
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
    "./result_10chains/node262_0_0.txt 90"
    "./result_10chains/node262_0_2.txt 90"
    "./result_10chains/node262_1_0.txt 89"
    "./result_10chains/node262_1_2.txt 89"
    "./result_10chains/node262_2_0.txt 88"
    "./result_10chains/node262_2_2.txt 88"
    "./result_10chains/node262_3_0.txt 87"
    "./result_10chains/node262_3_2.txt 87"
    "./result_10chains/node262_4_0.txt 86"
    "./result_10chains/node262_4_2.txt 86"
    "./result_10chains/node262_5_0.txt 85"
    "./result_10chains/node262_5_2.txt 85"
    "./result_10chains/node262_6_0.txt 84"
    "./result_10chains/node262_6_2.txt 84"
    "./result_10chains/node262_7_0.txt 83"
    "./result_10chains/node262_7_2.txt 83"
    "./result_10chains/node262_8_0.txt 82"
    "./result_10chains/node262_8_2.txt 82"
    "./result_10chains/node262_9_0.txt 81"
    "./result_10chains/node262_9_2.txt 81"
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
