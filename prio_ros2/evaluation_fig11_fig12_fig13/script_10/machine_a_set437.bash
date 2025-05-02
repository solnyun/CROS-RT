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
ros2 run evaluation_3_randomdag uunifast_node -n node437_0_2 -p 145 -st topic437_0_1 -pt None -u 0.026707962243728955 > ./result_10chains/node437_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_1_2 -p 267 -st topic437_1_1 -pt None -u 0.012613785633859564 > ./result_10chains/node437_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_2_2 -p 443 -st topic437_2_1 -pt None -u 0.015261924040059882 > ./result_10chains/node437_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_3_2 -p 599 -st topic437_3_1 -pt None -u 0.020123456952779145 > ./result_10chains/node437_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_4_2 -p 622 -st topic437_4_1 -pt None -u 0.028375945977096695 > ./result_10chains/node437_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_5_2 -p 694 -st topic437_5_1 -pt None -u 0.0055416036483141445 > ./result_10chains/node437_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_6_2 -p 781 -st topic437_6_1 -pt None -u 0.002762122777467055 > ./result_10chains/node437_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_7_2 -p 793 -st topic437_7_1 -pt None -u 0.003540688441374139 > ./result_10chains/node437_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_8_2 -p 888 -st topic437_8_1 -pt None -u 0.0013825655566880798 > ./result_10chains/node437_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_9_2 -p 893 -st topic437_9_1 -pt None -u 0.00310030984610522 > ./result_10chains/node437_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_0_0 -p 145 -st none -pt topic437_0_0 -u 0.03446511776979122 > ./result_10chains/node437_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_1_0 -p 267 -st none -pt topic437_1_0 -u 0.005234886327691202 > ./result_10chains/node437_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_2_0 -p 443 -st none -pt topic437_2_0 -u 0.00885539941208957 > ./result_10chains/node437_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_3_0 -p 599 -st none -pt topic437_3_0 -u 0.04945792097066515 > ./result_10chains/node437_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_4_0 -p 622 -st none -pt topic437_4_0 -u 0.00916412973924463 > ./result_10chains/node437_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_5_0 -p 694 -st none -pt topic437_5_0 -u 0.011789942707198534 > ./result_10chains/node437_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_6_0 -p 781 -st none -pt topic437_6_0 -u 0.017860223824171753 > ./result_10chains/node437_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_7_0 -p 793 -st none -pt topic437_7_0 -u 0.013808186181645518 > ./result_10chains/node437_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node437_8_0 -p 888 -st none -pt topic437_8_0 -u 0.018647532477608884 > ./result_10chains/node437_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node437_9_0 -p 893 -st none -pt topic437_9_0 -u 0.010964013985218415 > ./result_10chains/node437_9_0.txt &
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
    "./result_10chains/node437_0_0.txt 90"
    "./result_10chains/node437_0_2.txt 90"
    "./result_10chains/node437_1_0.txt 89"
    "./result_10chains/node437_1_2.txt 89"
    "./result_10chains/node437_2_0.txt 88"
    "./result_10chains/node437_2_2.txt 88"
    "./result_10chains/node437_3_0.txt 87"
    "./result_10chains/node437_3_2.txt 87"
    "./result_10chains/node437_4_0.txt 86"
    "./result_10chains/node437_4_2.txt 86"
    "./result_10chains/node437_5_0.txt 85"
    "./result_10chains/node437_5_2.txt 85"
    "./result_10chains/node437_6_0.txt 84"
    "./result_10chains/node437_6_2.txt 84"
    "./result_10chains/node437_7_0.txt 83"
    "./result_10chains/node437_7_2.txt 83"
    "./result_10chains/node437_8_0.txt 82"
    "./result_10chains/node437_8_2.txt 82"
    "./result_10chains/node437_9_0.txt 81"
    "./result_10chains/node437_9_2.txt 81"
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
