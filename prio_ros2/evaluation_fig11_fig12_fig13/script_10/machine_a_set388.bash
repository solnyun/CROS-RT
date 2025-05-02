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
ros2 run evaluation_3_randomdag uunifast_node -n node388_0_2 -p 11 -st topic388_0_1 -pt None -u 0.02006377346422622 > ./result_10chains/node388_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_1_2 -p 56 -st topic388_1_1 -pt None -u 0.011872471683993802 > ./result_10chains/node388_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_2_2 -p 156 -st topic388_2_1 -pt None -u 0.06208279385205906 > ./result_10chains/node388_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_3_2 -p 226 -st topic388_3_1 -pt None -u 0.007271502234570404 > ./result_10chains/node388_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_4_2 -p 274 -st topic388_4_1 -pt None -u 0.012974110517376625 > ./result_10chains/node388_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_5_2 -p 323 -st topic388_5_1 -pt None -u 0.0005563122124921382 > ./result_10chains/node388_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_6_2 -p 624 -st topic388_6_1 -pt None -u 0.03956140422934985 > ./result_10chains/node388_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_7_2 -p 655 -st topic388_7_1 -pt None -u 0.012794089961748148 > ./result_10chains/node388_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_8_2 -p 732 -st topic388_8_1 -pt None -u 0.016253018706857754 > ./result_10chains/node388_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_9_2 -p 927 -st topic388_9_1 -pt None -u 0.017147263007342123 > ./result_10chains/node388_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_0_0 -p 11 -st none -pt topic388_0_0 -u 0.013613996420903496 > ./result_10chains/node388_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_1_0 -p 56 -st none -pt topic388_1_0 -u 0.010054387071214865 > ./result_10chains/node388_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_2_0 -p 156 -st none -pt topic388_2_0 -u 0.03313428478659736 > ./result_10chains/node388_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_3_0 -p 226 -st none -pt topic388_3_0 -u 0.0046328967176476055 > ./result_10chains/node388_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_4_0 -p 274 -st none -pt topic388_4_0 -u 0.00011510186392038602 > ./result_10chains/node388_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_5_0 -p 323 -st none -pt topic388_5_0 -u 0.016383324080097156 > ./result_10chains/node388_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_6_0 -p 624 -st none -pt topic388_6_0 -u 0.045979036729943246 > ./result_10chains/node388_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_7_0 -p 655 -st none -pt topic388_7_0 -u 0.003590332792597406 > ./result_10chains/node388_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_8_0 -p 732 -st none -pt topic388_8_0 -u 0.00584951900276974 > ./result_10chains/node388_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node388_9_0 -p 927 -st none -pt topic388_9_0 -u 0.03500251077244 > ./result_10chains/node388_9_0.txt &
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
    "./result_10chains/node388_0_0.txt 90"
    "./result_10chains/node388_0_2.txt 90"
    "./result_10chains/node388_1_0.txt 89"
    "./result_10chains/node388_1_2.txt 89"
    "./result_10chains/node388_2_0.txt 88"
    "./result_10chains/node388_2_2.txt 88"
    "./result_10chains/node388_3_0.txt 87"
    "./result_10chains/node388_3_2.txt 87"
    "./result_10chains/node388_4_0.txt 86"
    "./result_10chains/node388_4_2.txt 86"
    "./result_10chains/node388_5_0.txt 85"
    "./result_10chains/node388_5_2.txt 85"
    "./result_10chains/node388_6_0.txt 84"
    "./result_10chains/node388_6_2.txt 84"
    "./result_10chains/node388_7_0.txt 83"
    "./result_10chains/node388_7_2.txt 83"
    "./result_10chains/node388_8_0.txt 82"
    "./result_10chains/node388_8_2.txt 82"
    "./result_10chains/node388_9_0.txt 81"
    "./result_10chains/node388_9_2.txt 81"
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
