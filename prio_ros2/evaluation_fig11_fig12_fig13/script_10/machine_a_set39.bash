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
ros2 run evaluation_3_randomdag uunifast_node -n node39_0_2 -p 18 -st topic39_0_1 -pt None -u 0.005415648850916277 > ./result_10chains/node39_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_1_2 -p 78 -st topic39_1_1 -pt None -u 0.00029368984636324313 > ./result_10chains/node39_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_2_2 -p 140 -st topic39_2_1 -pt None -u 0.01866559420131303 > ./result_10chains/node39_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_3_2 -p 304 -st topic39_3_1 -pt None -u 0.01792938890782414 > ./result_10chains/node39_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_4_2 -p 430 -st topic39_4_1 -pt None -u 0.008866727065626356 > ./result_10chains/node39_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_5_2 -p 485 -st topic39_5_1 -pt None -u 0.0030878866177065922 > ./result_10chains/node39_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_6_2 -p 655 -st topic39_6_1 -pt None -u 0.04332440059728421 > ./result_10chains/node39_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_7_2 -p 823 -st topic39_7_1 -pt None -u 0.01073081932537398 > ./result_10chains/node39_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_8_2 -p 876 -st topic39_8_1 -pt None -u 0.0009239226257439226 > ./result_10chains/node39_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_9_2 -p 940 -st topic39_9_1 -pt None -u 0.01013006620006701 > ./result_10chains/node39_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_0_0 -p 18 -st none -pt topic39_0_0 -u 0.032886062331755894 > ./result_10chains/node39_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_1_0 -p 78 -st none -pt topic39_1_0 -u 0.0041007855769873425 > ./result_10chains/node39_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_2_0 -p 140 -st none -pt topic39_2_0 -u 0.002759557380311417 > ./result_10chains/node39_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_3_0 -p 304 -st none -pt topic39_3_0 -u 0.02262744733165284 > ./result_10chains/node39_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_4_0 -p 430 -st none -pt topic39_4_0 -u 0.008680931333856445 > ./result_10chains/node39_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_5_0 -p 485 -st none -pt topic39_5_0 -u 0.02104367338981572 > ./result_10chains/node39_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_6_0 -p 655 -st none -pt topic39_6_0 -u 0.012079813991439703 > ./result_10chains/node39_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_7_0 -p 823 -st none -pt topic39_7_0 -u 0.05233372257972499 > ./result_10chains/node39_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_8_0 -p 876 -st none -pt topic39_8_0 -u 0.02919487589715658 > ./result_10chains/node39_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_9_0 -p 940 -st none -pt topic39_9_0 -u 0.0014471767681283037 > ./result_10chains/node39_9_0.txt &
sleep 10
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
    "./result_10chains/node39_0_0.txt 90"
    "./result_10chains/node39_0_2.txt 90"
    "./result_10chains/node39_1_0.txt 89"
    "./result_10chains/node39_1_2.txt 89"
    "./result_10chains/node39_2_0.txt 88"
    "./result_10chains/node39_2_2.txt 88"
    "./result_10chains/node39_3_0.txt 87"
    "./result_10chains/node39_3_2.txt 87"
    "./result_10chains/node39_4_0.txt 86"
    "./result_10chains/node39_4_2.txt 86"
    "./result_10chains/node39_5_0.txt 85"
    "./result_10chains/node39_5_2.txt 85"
    "./result_10chains/node39_6_0.txt 84"
    "./result_10chains/node39_6_2.txt 84"
    "./result_10chains/node39_7_0.txt 83"
    "./result_10chains/node39_7_2.txt 83"
    "./result_10chains/node39_8_0.txt 82"
    "./result_10chains/node39_8_2.txt 82"
    "./result_10chains/node39_9_0.txt 81"
    "./result_10chains/node39_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
