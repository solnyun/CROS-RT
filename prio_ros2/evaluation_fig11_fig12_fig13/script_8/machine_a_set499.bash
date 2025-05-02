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
ros2 run evaluation_3_randomdag uunifast_node -n node499_0_2 -p 132 -st topic499_0_1 -pt None -u 0.0013475731975297056 > ./result_8chains/node499_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_1_2 -p 231 -st topic499_1_1 -pt None -u 0.06372668835950557 > ./result_8chains/node499_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_2_2 -p 415 -st topic499_2_1 -pt None -u 0.003802946412477193 > ./result_8chains/node499_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_3_2 -p 527 -st topic499_3_1 -pt None -u 0.025744512518498353 > ./result_8chains/node499_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_4_2 -p 531 -st topic499_4_1 -pt None -u 0.004589769926045123 > ./result_8chains/node499_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_5_2 -p 689 -st topic499_5_1 -pt None -u 0.04741556967889628 > ./result_8chains/node499_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_6_2 -p 835 -st topic499_6_1 -pt None -u 0.022920215502251734 > ./result_8chains/node499_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_7_2 -p 863 -st topic499_7_1 -pt None -u 0.0324529098950685 > ./result_8chains/node499_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_0_0 -p 132 -st none -pt topic499_0_0 -u 0.009563099926786167 > ./result_8chains/node499_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_1_0 -p 231 -st none -pt topic499_1_0 -u 0.003142871513078571 > ./result_8chains/node499_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_2_0 -p 415 -st none -pt topic499_2_0 -u 0.0383085841128149 > ./result_8chains/node499_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_3_0 -p 527 -st none -pt topic499_3_0 -u 0.027798770809459916 > ./result_8chains/node499_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_4_0 -p 531 -st none -pt topic499_4_0 -u 0.01822631224022625 > ./result_8chains/node499_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_5_0 -p 689 -st none -pt topic499_5_0 -u 0.025325246654455624 > ./result_8chains/node499_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_6_0 -p 835 -st none -pt topic499_6_0 -u 0.002415524732923474 > ./result_8chains/node499_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_7_0 -p 863 -st none -pt topic499_7_0 -u 0.028688833112156108 > ./result_8chains/node499_7_0.txt &
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
    "./result_8chains/node499_0_0.txt 90"
    "./result_8chains/node499_0_2.txt 90"
    "./result_8chains/node499_1_0.txt 89"
    "./result_8chains/node499_1_2.txt 89"
    "./result_8chains/node499_2_0.txt 88"
    "./result_8chains/node499_2_2.txt 88"
    "./result_8chains/node499_3_0.txt 87"
    "./result_8chains/node499_3_2.txt 87"
    "./result_8chains/node499_4_0.txt 86"
    "./result_8chains/node499_4_2.txt 86"
    "./result_8chains/node499_5_0.txt 85"
    "./result_8chains/node499_5_2.txt 85"
    "./result_8chains/node499_6_0.txt 84"
    "./result_8chains/node499_6_2.txt 84"
    "./result_8chains/node499_7_0.txt 83"
    "./result_8chains/node499_7_2.txt 83"
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
