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
ros2 run evaluation_3_randomdag uunifast_node -n node184_0_2 -p 87 -st topic184_0_1 -pt None -u 0.008209645012792977 > ./result_10chains/node184_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_1_2 -p 130 -st topic184_1_1 -pt None -u 0.015225743630424726 > ./result_10chains/node184_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_2_2 -p 195 -st topic184_2_1 -pt None -u 0.015523636924855422 > ./result_10chains/node184_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_3_2 -p 397 -st topic184_3_1 -pt None -u 0.03854297644883553 > ./result_10chains/node184_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_4_2 -p 450 -st topic184_4_1 -pt None -u 0.018070043741172104 > ./result_10chains/node184_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_5_2 -p 517 -st topic184_5_1 -pt None -u 0.0435099257867419 > ./result_10chains/node184_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_6_2 -p 572 -st topic184_6_1 -pt None -u 0.04301051329933833 > ./result_10chains/node184_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_7_2 -p 953 -st topic184_7_1 -pt None -u 0.01446181934367212 > ./result_10chains/node184_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_8_2 -p 985 -st topic184_8_1 -pt None -u 0.0028483710534560475 > ./result_10chains/node184_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_9_2 -p 992 -st topic184_9_1 -pt None -u 0.015127413590463074 > ./result_10chains/node184_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_0_0 -p 87 -st none -pt topic184_0_0 -u 0.05778691016059845 > ./result_10chains/node184_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_1_0 -p 130 -st none -pt topic184_1_0 -u 0.012985558773164374 > ./result_10chains/node184_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_2_0 -p 195 -st none -pt topic184_2_0 -u 0.01914349539785548 > ./result_10chains/node184_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_3_0 -p 397 -st none -pt topic184_3_0 -u 0.0009434394581298577 > ./result_10chains/node184_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_4_0 -p 450 -st none -pt topic184_4_0 -u 0.005625994182798744 > ./result_10chains/node184_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_5_0 -p 517 -st none -pt topic184_5_0 -u 0.0007476621152757712 > ./result_10chains/node184_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_6_0 -p 572 -st none -pt topic184_6_0 -u 0.043056115329543954 > ./result_10chains/node184_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_7_0 -p 953 -st none -pt topic184_7_0 -u 0.032691427843301174 > ./result_10chains/node184_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_8_0 -p 985 -st none -pt topic184_8_0 -u 0.011949215699770144 > ./result_10chains/node184_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_9_0 -p 992 -st none -pt topic184_9_0 -u 0.054559682065330385 > ./result_10chains/node184_9_0.txt &
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
    "./result_10chains/node184_0_0.txt 90"
    "./result_10chains/node184_0_2.txt 90"
    "./result_10chains/node184_1_0.txt 89"
    "./result_10chains/node184_1_2.txt 89"
    "./result_10chains/node184_2_0.txt 88"
    "./result_10chains/node184_2_2.txt 88"
    "./result_10chains/node184_3_0.txt 87"
    "./result_10chains/node184_3_2.txt 87"
    "./result_10chains/node184_4_0.txt 86"
    "./result_10chains/node184_4_2.txt 86"
    "./result_10chains/node184_5_0.txt 85"
    "./result_10chains/node184_5_2.txt 85"
    "./result_10chains/node184_6_0.txt 84"
    "./result_10chains/node184_6_2.txt 84"
    "./result_10chains/node184_7_0.txt 83"
    "./result_10chains/node184_7_2.txt 83"
    "./result_10chains/node184_8_0.txt 82"
    "./result_10chains/node184_8_2.txt 82"
    "./result_10chains/node184_9_0.txt 81"
    "./result_10chains/node184_9_2.txt 81"
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
