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
ros2 run evaluation_3_randomdag uunifast_node -n node143_0_2 -p 167 -st topic143_0_1 -pt None -u 0.02362824414103437 > ./result_10chains/node143_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_1_2 -p 257 -st topic143_1_1 -pt None -u 0.010252022065463606 > ./result_10chains/node143_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_2_2 -p 329 -st topic143_2_1 -pt None -u 0.0038863889259822537 > ./result_10chains/node143_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_3_2 -p 335 -st topic143_3_1 -pt None -u 0.0001294422784967053 > ./result_10chains/node143_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_4_2 -p 348 -st topic143_4_1 -pt None -u 0.012895805164182289 > ./result_10chains/node143_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_5_2 -p 349 -st topic143_5_1 -pt None -u 0.004599143165467778 > ./result_10chains/node143_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_6_2 -p 384 -st topic143_6_1 -pt None -u 0.03194513527693066 > ./result_10chains/node143_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_7_2 -p 482 -st topic143_7_1 -pt None -u 0.02794635116079923 > ./result_10chains/node143_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_8_2 -p 708 -st topic143_8_1 -pt None -u 0.025412951024597487 > ./result_10chains/node143_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_9_2 -p 906 -st topic143_9_1 -pt None -u 0.014247921513382016 > ./result_10chains/node143_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_0_0 -p 167 -st none -pt topic143_0_0 -u 0.007506327126481027 > ./result_10chains/node143_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_1_0 -p 257 -st none -pt topic143_1_0 -u 0.05109515405088477 > ./result_10chains/node143_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_2_0 -p 329 -st none -pt topic143_2_0 -u 0.012900904619145337 > ./result_10chains/node143_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_3_0 -p 335 -st none -pt topic143_3_0 -u 0.06850569275043028 > ./result_10chains/node143_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_4_0 -p 348 -st none -pt topic143_4_0 -u 0.029704637645964704 > ./result_10chains/node143_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_5_0 -p 349 -st none -pt topic143_5_0 -u 0.01890714600135024 > ./result_10chains/node143_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_6_0 -p 384 -st none -pt topic143_6_0 -u 0.003055259021515766 > ./result_10chains/node143_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_7_0 -p 482 -st none -pt topic143_7_0 -u 0.013315734324976375 > ./result_10chains/node143_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node143_8_0 -p 708 -st none -pt topic143_8_0 -u 0.00850847415441243 > ./result_10chains/node143_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node143_9_0 -p 906 -st none -pt topic143_9_0 -u 0.002642307376287272 > ./result_10chains/node143_9_0.txt &
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
    "./result_10chains/node143_0_0.txt 90"
    "./result_10chains/node143_0_2.txt 90"
    "./result_10chains/node143_1_0.txt 89"
    "./result_10chains/node143_1_2.txt 89"
    "./result_10chains/node143_2_0.txt 88"
    "./result_10chains/node143_2_2.txt 88"
    "./result_10chains/node143_3_0.txt 87"
    "./result_10chains/node143_3_2.txt 87"
    "./result_10chains/node143_4_0.txt 86"
    "./result_10chains/node143_4_2.txt 86"
    "./result_10chains/node143_5_0.txt 85"
    "./result_10chains/node143_5_2.txt 85"
    "./result_10chains/node143_6_0.txt 84"
    "./result_10chains/node143_6_2.txt 84"
    "./result_10chains/node143_7_0.txt 83"
    "./result_10chains/node143_7_2.txt 83"
    "./result_10chains/node143_8_0.txt 82"
    "./result_10chains/node143_8_2.txt 82"
    "./result_10chains/node143_9_0.txt 81"
    "./result_10chains/node143_9_2.txt 81"
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
