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
ros2 run evaluation_3_randomdag uunifast_node -n node486_0_2 -p 33 -st topic486_0_1 -pt None -u 0.010386835715167853 > ./result_10chains/node486_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_1_2 -p 191 -st topic486_1_1 -pt None -u 0.012314127380557982 > ./result_10chains/node486_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_2_2 -p 219 -st topic486_2_1 -pt None -u 0.013225775331146605 > ./result_10chains/node486_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_3_2 -p 233 -st topic486_3_1 -pt None -u 0.029469801566788523 > ./result_10chains/node486_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_4_2 -p 374 -st topic486_4_1 -pt None -u 0.012435627060399357 > ./result_10chains/node486_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_5_2 -p 385 -st topic486_5_1 -pt None -u 0.04307497900584187 > ./result_10chains/node486_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_6_2 -p 423 -st topic486_6_1 -pt None -u 0.013603137246942981 > ./result_10chains/node486_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_7_2 -p 473 -st topic486_7_1 -pt None -u 0.009544850793771473 > ./result_10chains/node486_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_8_2 -p 652 -st topic486_8_1 -pt None -u 0.024688030945207502 > ./result_10chains/node486_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_9_2 -p 903 -st topic486_9_1 -pt None -u 0.00915599345395862 > ./result_10chains/node486_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_0_0 -p 33 -st none -pt topic486_0_0 -u 0.0011961076746893617 > ./result_10chains/node486_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_1_0 -p 191 -st none -pt topic486_1_0 -u 0.009283654941562858 > ./result_10chains/node486_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_2_0 -p 219 -st none -pt topic486_2_0 -u 0.00023531235584289822 > ./result_10chains/node486_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_3_0 -p 233 -st none -pt topic486_3_0 -u 0.013985962434723331 > ./result_10chains/node486_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_4_0 -p 374 -st none -pt topic486_4_0 -u 0.0054901715135503015 > ./result_10chains/node486_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_5_0 -p 385 -st none -pt topic486_5_0 -u 0.03179853597674065 > ./result_10chains/node486_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_6_0 -p 423 -st none -pt topic486_6_0 -u 0.002200850569007068 > ./result_10chains/node486_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_7_0 -p 473 -st none -pt topic486_7_0 -u 0.011130278898345863 > ./result_10chains/node486_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_8_0 -p 652 -st none -pt topic486_8_0 -u 0.023794488852134185 > ./result_10chains/node486_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_9_0 -p 903 -st none -pt topic486_9_0 -u 0.02843597279924381 > ./result_10chains/node486_9_0.txt &
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
    "./result_10chains/node486_0_0.txt 90"
    "./result_10chains/node486_0_2.txt 90"
    "./result_10chains/node486_1_0.txt 89"
    "./result_10chains/node486_1_2.txt 89"
    "./result_10chains/node486_2_0.txt 88"
    "./result_10chains/node486_2_2.txt 88"
    "./result_10chains/node486_3_0.txt 87"
    "./result_10chains/node486_3_2.txt 87"
    "./result_10chains/node486_4_0.txt 86"
    "./result_10chains/node486_4_2.txt 86"
    "./result_10chains/node486_5_0.txt 85"
    "./result_10chains/node486_5_2.txt 85"
    "./result_10chains/node486_6_0.txt 84"
    "./result_10chains/node486_6_2.txt 84"
    "./result_10chains/node486_7_0.txt 83"
    "./result_10chains/node486_7_2.txt 83"
    "./result_10chains/node486_8_0.txt 82"
    "./result_10chains/node486_8_2.txt 82"
    "./result_10chains/node486_9_0.txt 81"
    "./result_10chains/node486_9_2.txt 81"
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
