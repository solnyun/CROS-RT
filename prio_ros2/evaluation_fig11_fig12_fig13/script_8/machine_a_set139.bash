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
ros2 run evaluation_3_randomdag uunifast_node -n node139_0_2 -p 60 -st topic139_0_1 -pt None -u 0.01428596181669528 > ./result_8chains/node139_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_1_2 -p 158 -st topic139_1_1 -pt None -u 0.005485111411268451 > ./result_8chains/node139_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_2_2 -p 226 -st topic139_2_1 -pt None -u 0.0580259618400209 > ./result_8chains/node139_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_3_2 -p 329 -st topic139_3_1 -pt None -u 0.08131161276757035 > ./result_8chains/node139_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_4_2 -p 598 -st topic139_4_1 -pt None -u 0.005928225979879659 > ./result_8chains/node139_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_5_2 -p 604 -st topic139_5_1 -pt None -u 0.002229478759752976 > ./result_8chains/node139_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_6_2 -p 915 -st topic139_6_1 -pt None -u 0.026011559945762153 > ./result_8chains/node139_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_7_2 -p 947 -st topic139_7_1 -pt None -u 0.022936975856602745 > ./result_8chains/node139_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_0_0 -p 60 -st none -pt topic139_0_0 -u 0.005850777664440698 > ./result_8chains/node139_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_1_0 -p 158 -st none -pt topic139_1_0 -u 0.0529172992363503 > ./result_8chains/node139_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_2_0 -p 226 -st none -pt topic139_2_0 -u 0.0019097246157684378 > ./result_8chains/node139_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_3_0 -p 329 -st none -pt topic139_3_0 -u 0.041070660413890236 > ./result_8chains/node139_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_4_0 -p 598 -st none -pt topic139_4_0 -u 0.002494504826470595 > ./result_8chains/node139_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_5_0 -p 604 -st none -pt topic139_5_0 -u 0.046418077748275194 > ./result_8chains/node139_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node139_6_0 -p 915 -st none -pt topic139_6_0 -u 0.006162074231535766 > ./result_8chains/node139_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node139_7_0 -p 947 -st none -pt topic139_7_0 -u 0.02092705926163852 > ./result_8chains/node139_7_0.txt &
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
    "./result_8chains/node139_0_0.txt 90"
    "./result_8chains/node139_0_2.txt 90"
    "./result_8chains/node139_1_0.txt 89"
    "./result_8chains/node139_1_2.txt 89"
    "./result_8chains/node139_2_0.txt 88"
    "./result_8chains/node139_2_2.txt 88"
    "./result_8chains/node139_3_0.txt 87"
    "./result_8chains/node139_3_2.txt 87"
    "./result_8chains/node139_4_0.txt 86"
    "./result_8chains/node139_4_2.txt 86"
    "./result_8chains/node139_5_0.txt 85"
    "./result_8chains/node139_5_2.txt 85"
    "./result_8chains/node139_6_0.txt 84"
    "./result_8chains/node139_6_2.txt 84"
    "./result_8chains/node139_7_0.txt 83"
    "./result_8chains/node139_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
