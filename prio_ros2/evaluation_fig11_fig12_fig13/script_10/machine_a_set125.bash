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
ros2 run evaluation_3_randomdag uunifast_node -n node125_0_2 -p 246 -st topic125_0_1 -pt None -u 0.004317183997832763 > ./result_10chains/node125_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_1_2 -p 279 -st topic125_1_1 -pt None -u 0.019731911015307857 > ./result_10chains/node125_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_2_2 -p 290 -st topic125_2_1 -pt None -u 0.00808776538011391 > ./result_10chains/node125_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_3_2 -p 358 -st topic125_3_1 -pt None -u 0.004570528990729905 > ./result_10chains/node125_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_4_2 -p 370 -st topic125_4_1 -pt None -u 0.012621639551921082 > ./result_10chains/node125_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_5_2 -p 436 -st topic125_5_1 -pt None -u 0.000675792018747623 > ./result_10chains/node125_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_6_2 -p 467 -st topic125_6_1 -pt None -u 0.0168951730744277 > ./result_10chains/node125_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_7_2 -p 493 -st topic125_7_1 -pt None -u 0.01878654867648971 > ./result_10chains/node125_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_8_2 -p 500 -st topic125_8_1 -pt None -u 0.03156458565687258 > ./result_10chains/node125_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_9_2 -p 943 -st topic125_9_1 -pt None -u 0.0016315982701728274 > ./result_10chains/node125_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_0_0 -p 246 -st none -pt topic125_0_0 -u 0.023974144775020967 > ./result_10chains/node125_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_1_0 -p 279 -st none -pt topic125_1_0 -u 0.046174886857489494 > ./result_10chains/node125_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_2_0 -p 290 -st none -pt topic125_2_0 -u 0.0023591735415958714 > ./result_10chains/node125_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_3_0 -p 358 -st none -pt topic125_3_0 -u 0.042756938059815675 > ./result_10chains/node125_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_4_0 -p 370 -st none -pt topic125_4_0 -u 0.009773846176603151 > ./result_10chains/node125_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_5_0 -p 436 -st none -pt topic125_5_0 -u 0.013292479979166327 > ./result_10chains/node125_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_6_0 -p 467 -st none -pt topic125_6_0 -u 0.04064031685512032 > ./result_10chains/node125_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_7_0 -p 493 -st none -pt topic125_7_0 -u 0.021988985302867747 > ./result_10chains/node125_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node125_8_0 -p 500 -st none -pt topic125_8_0 -u 0.05169599597597349 > ./result_10chains/node125_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node125_9_0 -p 943 -st none -pt topic125_9_0 -u 0.011256455919284472 > ./result_10chains/node125_9_0.txt &
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
    "./result_10chains/node125_0_0.txt 90"
    "./result_10chains/node125_0_2.txt 90"
    "./result_10chains/node125_1_0.txt 89"
    "./result_10chains/node125_1_2.txt 89"
    "./result_10chains/node125_2_0.txt 88"
    "./result_10chains/node125_2_2.txt 88"
    "./result_10chains/node125_3_0.txt 87"
    "./result_10chains/node125_3_2.txt 87"
    "./result_10chains/node125_4_0.txt 86"
    "./result_10chains/node125_4_2.txt 86"
    "./result_10chains/node125_5_0.txt 85"
    "./result_10chains/node125_5_2.txt 85"
    "./result_10chains/node125_6_0.txt 84"
    "./result_10chains/node125_6_2.txt 84"
    "./result_10chains/node125_7_0.txt 83"
    "./result_10chains/node125_7_2.txt 83"
    "./result_10chains/node125_8_0.txt 82"
    "./result_10chains/node125_8_2.txt 82"
    "./result_10chains/node125_9_0.txt 81"
    "./result_10chains/node125_9_2.txt 81"
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
