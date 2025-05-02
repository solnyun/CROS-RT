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
ros2 run evaluation_3_randomdag uunifast_node -n node423_0_2 -p 275 -st topic423_0_1 -pt None -u 0.00802126299591932 > ./result_10chains/node423_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_1_2 -p 374 -st topic423_1_1 -pt None -u 0.022980137399715606 > ./result_10chains/node423_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_2_2 -p 451 -st topic423_2_1 -pt None -u 0.010402214476917804 > ./result_10chains/node423_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_3_2 -p 595 -st topic423_3_1 -pt None -u 0.0024842945169520347 > ./result_10chains/node423_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_4_2 -p 674 -st topic423_4_1 -pt None -u 0.006863031533220987 > ./result_10chains/node423_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_5_2 -p 751 -st topic423_5_1 -pt None -u 0.009097719342132327 > ./result_10chains/node423_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_6_2 -p 784 -st topic423_6_1 -pt None -u 0.018955782921467962 > ./result_10chains/node423_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_7_2 -p 890 -st topic423_7_1 -pt None -u 0.007197033005796272 > ./result_10chains/node423_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_8_2 -p 937 -st topic423_8_1 -pt None -u 0.0088688760492273 > ./result_10chains/node423_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_9_2 -p 980 -st topic423_9_1 -pt None -u 3.900688199492849e-05 > ./result_10chains/node423_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_0_0 -p 275 -st none -pt topic423_0_0 -u 0.018612044910553238 > ./result_10chains/node423_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_1_0 -p 374 -st none -pt topic423_1_0 -u 0.024718789260828045 > ./result_10chains/node423_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_2_0 -p 451 -st none -pt topic423_2_0 -u 0.005586743429096985 > ./result_10chains/node423_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_3_0 -p 595 -st none -pt topic423_3_0 -u 0.009460850895133655 > ./result_10chains/node423_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_4_0 -p 674 -st none -pt topic423_4_0 -u 0.008820597482361525 > ./result_10chains/node423_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_5_0 -p 751 -st none -pt topic423_5_0 -u 0.006104458865589524 > ./result_10chains/node423_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_6_0 -p 784 -st none -pt topic423_6_0 -u 0.00332777491783548 > ./result_10chains/node423_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_7_0 -p 890 -st none -pt topic423_7_0 -u 0.050884775750704936 > ./result_10chains/node423_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_8_0 -p 937 -st none -pt topic423_8_0 -u 0.01995913185249336 > ./result_10chains/node423_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_9_0 -p 980 -st none -pt topic423_9_0 -u 0.008531432372186273 > ./result_10chains/node423_9_0.txt &
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
    "./result_10chains/node423_0_0.txt 90"
    "./result_10chains/node423_0_2.txt 90"
    "./result_10chains/node423_1_0.txt 89"
    "./result_10chains/node423_1_2.txt 89"
    "./result_10chains/node423_2_0.txt 88"
    "./result_10chains/node423_2_2.txt 88"
    "./result_10chains/node423_3_0.txt 87"
    "./result_10chains/node423_3_2.txt 87"
    "./result_10chains/node423_4_0.txt 86"
    "./result_10chains/node423_4_2.txt 86"
    "./result_10chains/node423_5_0.txt 85"
    "./result_10chains/node423_5_2.txt 85"
    "./result_10chains/node423_6_0.txt 84"
    "./result_10chains/node423_6_2.txt 84"
    "./result_10chains/node423_7_0.txt 83"
    "./result_10chains/node423_7_2.txt 83"
    "./result_10chains/node423_8_0.txt 82"
    "./result_10chains/node423_8_2.txt 82"
    "./result_10chains/node423_9_0.txt 81"
    "./result_10chains/node423_9_2.txt 81"
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
