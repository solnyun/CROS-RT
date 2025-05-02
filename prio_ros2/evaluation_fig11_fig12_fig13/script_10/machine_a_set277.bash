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
ros2 run evaluation_3_randomdag uunifast_node -n node277_0_2 -p 303 -st topic277_0_1 -pt None -u 0.009957185803189106 > ./result_10chains/node277_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_1_2 -p 357 -st topic277_1_1 -pt None -u 0.025464897446254908 > ./result_10chains/node277_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_2_2 -p 425 -st topic277_2_1 -pt None -u 0.033438378928282886 > ./result_10chains/node277_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_3_2 -p 458 -st topic277_3_1 -pt None -u 0.012251279740802479 > ./result_10chains/node277_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_4_2 -p 542 -st topic277_4_1 -pt None -u 0.015587730081051965 > ./result_10chains/node277_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_5_2 -p 625 -st topic277_5_1 -pt None -u 0.009065167517620737 > ./result_10chains/node277_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_6_2 -p 800 -st topic277_6_1 -pt None -u 0.009293480984869387 > ./result_10chains/node277_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_7_2 -p 854 -st topic277_7_1 -pt None -u 0.01721728815849745 > ./result_10chains/node277_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_8_2 -p 895 -st topic277_8_1 -pt None -u 0.01950852988403899 > ./result_10chains/node277_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_9_2 -p 978 -st topic277_9_1 -pt None -u 0.010829660420415374 > ./result_10chains/node277_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_0_0 -p 303 -st none -pt topic277_0_0 -u 0.02174373659833001 > ./result_10chains/node277_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_1_0 -p 357 -st none -pt topic277_1_0 -u 0.005960441748565692 > ./result_10chains/node277_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_2_0 -p 425 -st none -pt topic277_2_0 -u 0.009437060446761458 > ./result_10chains/node277_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_3_0 -p 458 -st none -pt topic277_3_0 -u 0.04488286404220598 > ./result_10chains/node277_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_4_0 -p 542 -st none -pt topic277_4_0 -u 0.0003305676044220718 > ./result_10chains/node277_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_5_0 -p 625 -st none -pt topic277_5_0 -u 0.025013873911114815 > ./result_10chains/node277_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_6_0 -p 800 -st none -pt topic277_6_0 -u 0.008015410422136271 > ./result_10chains/node277_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_7_0 -p 854 -st none -pt topic277_7_0 -u 0.01211540365756747 > ./result_10chains/node277_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_8_0 -p 895 -st none -pt topic277_8_0 -u 0.0030602417336305504 > ./result_10chains/node277_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_9_0 -p 978 -st none -pt topic277_9_0 -u 0.024740747974328615 > ./result_10chains/node277_9_0.txt &
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
    "./result_10chains/node277_0_0.txt 90"
    "./result_10chains/node277_0_2.txt 90"
    "./result_10chains/node277_1_0.txt 89"
    "./result_10chains/node277_1_2.txt 89"
    "./result_10chains/node277_2_0.txt 88"
    "./result_10chains/node277_2_2.txt 88"
    "./result_10chains/node277_3_0.txt 87"
    "./result_10chains/node277_3_2.txt 87"
    "./result_10chains/node277_4_0.txt 86"
    "./result_10chains/node277_4_2.txt 86"
    "./result_10chains/node277_5_0.txt 85"
    "./result_10chains/node277_5_2.txt 85"
    "./result_10chains/node277_6_0.txt 84"
    "./result_10chains/node277_6_2.txt 84"
    "./result_10chains/node277_7_0.txt 83"
    "./result_10chains/node277_7_2.txt 83"
    "./result_10chains/node277_8_0.txt 82"
    "./result_10chains/node277_8_2.txt 82"
    "./result_10chains/node277_9_0.txt 81"
    "./result_10chains/node277_9_2.txt 81"
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
