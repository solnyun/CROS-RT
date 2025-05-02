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
ros2 run evaluation_3_randomdag uunifast_node -n node117_0_2 -p 246 -st topic117_0_1 -pt None -u 0.004328441140015182 > ./result_10chains/node117_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_1_2 -p 319 -st topic117_1_1 -pt None -u 0.017413637252894576 > ./result_10chains/node117_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_2_2 -p 385 -st topic117_2_1 -pt None -u 0.03792660102132828 > ./result_10chains/node117_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_3_2 -p 493 -st topic117_3_1 -pt None -u 0.02304918255695043 > ./result_10chains/node117_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_4_2 -p 566 -st topic117_4_1 -pt None -u 0.003944722164774844 > ./result_10chains/node117_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_5_2 -p 592 -st topic117_5_1 -pt None -u 0.03174264493581694 > ./result_10chains/node117_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_6_2 -p 719 -st topic117_6_1 -pt None -u 0.02242179104853198 > ./result_10chains/node117_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_7_2 -p 901 -st topic117_7_1 -pt None -u 0.007178522451790584 > ./result_10chains/node117_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_8_2 -p 916 -st topic117_8_1 -pt None -u 0.007712865321099084 > ./result_10chains/node117_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_9_2 -p 933 -st topic117_9_1 -pt None -u 0.0023327668869103043 > ./result_10chains/node117_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_0_0 -p 246 -st none -pt topic117_0_0 -u 0.02260928723801736 > ./result_10chains/node117_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_1_0 -p 319 -st none -pt topic117_1_0 -u 0.018432879053478346 > ./result_10chains/node117_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_2_0 -p 385 -st none -pt topic117_2_0 -u 0.04616825285344606 > ./result_10chains/node117_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_3_0 -p 493 -st none -pt topic117_3_0 -u 0.005145455393396947 > ./result_10chains/node117_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_4_0 -p 566 -st none -pt topic117_4_0 -u 0.01858708030267514 > ./result_10chains/node117_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_5_0 -p 592 -st none -pt topic117_5_0 -u 0.014243203121237002 > ./result_10chains/node117_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_6_0 -p 719 -st none -pt topic117_6_0 -u 0.005559225219180841 > ./result_10chains/node117_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_7_0 -p 901 -st none -pt topic117_7_0 -u 0.03287279514952508 > ./result_10chains/node117_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_8_0 -p 916 -st none -pt topic117_8_0 -u 0.009416044646075934 > ./result_10chains/node117_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node117_9_0 -p 933 -st none -pt topic117_9_0 -u 0.010489890146349455 > ./result_10chains/node117_9_0.txt &
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
    "./result_10chains/node117_0_0.txt 90"
    "./result_10chains/node117_0_2.txt 90"
    "./result_10chains/node117_1_0.txt 89"
    "./result_10chains/node117_1_2.txt 89"
    "./result_10chains/node117_2_0.txt 88"
    "./result_10chains/node117_2_2.txt 88"
    "./result_10chains/node117_3_0.txt 87"
    "./result_10chains/node117_3_2.txt 87"
    "./result_10chains/node117_4_0.txt 86"
    "./result_10chains/node117_4_2.txt 86"
    "./result_10chains/node117_5_0.txt 85"
    "./result_10chains/node117_5_2.txt 85"
    "./result_10chains/node117_6_0.txt 84"
    "./result_10chains/node117_6_2.txt 84"
    "./result_10chains/node117_7_0.txt 83"
    "./result_10chains/node117_7_2.txt 83"
    "./result_10chains/node117_8_0.txt 82"
    "./result_10chains/node117_8_2.txt 82"
    "./result_10chains/node117_9_0.txt 81"
    "./result_10chains/node117_9_2.txt 81"
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
