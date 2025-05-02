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
ros2 run evaluation_3_randomdag uunifast_node -n node131_0_2 -p 93 -st topic131_0_1 -pt None -u 0.011917346553641517 > ./result_8chains/node131_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node131_1_2 -p 253 -st topic131_1_1 -pt None -u 0.0006855267809096066 > ./result_8chains/node131_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_2_2 -p 314 -st topic131_2_1 -pt None -u 0.03881070364461303 > ./result_8chains/node131_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node131_3_2 -p 407 -st topic131_3_1 -pt None -u 0.004028913089533792 > ./result_8chains/node131_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_4_2 -p 515 -st topic131_4_1 -pt None -u 0.02634180554038204 > ./result_8chains/node131_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node131_5_2 -p 530 -st topic131_5_1 -pt None -u 0.008044246655841109 > ./result_8chains/node131_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_6_2 -p 656 -st topic131_6_1 -pt None -u 0.016307681895237347 > ./result_8chains/node131_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node131_7_2 -p 751 -st topic131_7_1 -pt None -u 0.01603288266234333 > ./result_8chains/node131_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_0_0 -p 93 -st none -pt topic131_0_0 -u 0.0043342143823627555 > ./result_8chains/node131_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node131_1_0 -p 253 -st none -pt topic131_1_0 -u 0.0022718803203881643 > ./result_8chains/node131_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_2_0 -p 314 -st none -pt topic131_2_0 -u 0.003018706989385167 > ./result_8chains/node131_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node131_3_0 -p 407 -st none -pt topic131_3_0 -u 0.057573366083816246 > ./result_8chains/node131_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_4_0 -p 515 -st none -pt topic131_4_0 -u 0.03564465449689097 > ./result_8chains/node131_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node131_5_0 -p 530 -st none -pt topic131_5_0 -u 0.09226679490833903 > ./result_8chains/node131_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_6_0 -p 656 -st none -pt topic131_6_0 -u 0.002186725177486276 > ./result_8chains/node131_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node131_7_0 -p 751 -st none -pt topic131_7_0 -u 0.03701308503657497 > ./result_8chains/node131_7_0.txt &
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
    "./result_8chains/node131_0_0.txt 90"
    "./result_8chains/node131_0_2.txt 90"
    "./result_8chains/node131_1_0.txt 89"
    "./result_8chains/node131_1_2.txt 89"
    "./result_8chains/node131_2_0.txt 88"
    "./result_8chains/node131_2_2.txt 88"
    "./result_8chains/node131_3_0.txt 87"
    "./result_8chains/node131_3_2.txt 87"
    "./result_8chains/node131_4_0.txt 86"
    "./result_8chains/node131_4_2.txt 86"
    "./result_8chains/node131_5_0.txt 85"
    "./result_8chains/node131_5_2.txt 85"
    "./result_8chains/node131_6_0.txt 84"
    "./result_8chains/node131_6_2.txt 84"
    "./result_8chains/node131_7_0.txt 83"
    "./result_8chains/node131_7_2.txt 83"
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
