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
ros2 run evaluation_3_randomdag uunifast_node -n node195_0_2 -p 40 -st topic195_0_1 -pt None -u 0.015869208807268165 > ./result_8chains/node195_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_1_2 -p 134 -st topic195_1_1 -pt None -u 0.007545234548990087 > ./result_8chains/node195_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_2_2 -p 191 -st topic195_2_1 -pt None -u 0.06391284889672785 > ./result_8chains/node195_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_3_2 -p 258 -st topic195_3_1 -pt None -u 0.001979585533990025 > ./result_8chains/node195_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_4_2 -p 413 -st topic195_4_1 -pt None -u 0.003409007578920986 > ./result_8chains/node195_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_5_2 -p 562 -st topic195_5_1 -pt None -u 0.027941514702872115 > ./result_8chains/node195_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_6_2 -p 937 -st topic195_6_1 -pt None -u 0.008784442876151235 > ./result_8chains/node195_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_7_2 -p 962 -st topic195_7_1 -pt None -u 0.0020470267838880916 > ./result_8chains/node195_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_0_0 -p 40 -st none -pt topic195_0_0 -u 0.0031226001590168306 > ./result_8chains/node195_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_1_0 -p 134 -st none -pt topic195_1_0 -u 0.024876152977806265 > ./result_8chains/node195_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_2_0 -p 191 -st none -pt topic195_2_0 -u 0.10563066160679074 > ./result_8chains/node195_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_3_0 -p 258 -st none -pt topic195_3_0 -u 0.001896445086940618 > ./result_8chains/node195_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_4_0 -p 413 -st none -pt topic195_4_0 -u 0.0019882059433080357 > ./result_8chains/node195_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_5_0 -p 562 -st none -pt topic195_5_0 -u 0.02612644297147261 > ./result_8chains/node195_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_6_0 -p 937 -st none -pt topic195_6_0 -u 0.007688787339667838 > ./result_8chains/node195_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_7_0 -p 962 -st none -pt topic195_7_0 -u 0.007611578983197878 > ./result_8chains/node195_7_0.txt &
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
    "./result_8chains/node195_0_0.txt 90"
    "./result_8chains/node195_0_2.txt 90"
    "./result_8chains/node195_1_0.txt 89"
    "./result_8chains/node195_1_2.txt 89"
    "./result_8chains/node195_2_0.txt 88"
    "./result_8chains/node195_2_2.txt 88"
    "./result_8chains/node195_3_0.txt 87"
    "./result_8chains/node195_3_2.txt 87"
    "./result_8chains/node195_4_0.txt 86"
    "./result_8chains/node195_4_2.txt 86"
    "./result_8chains/node195_5_0.txt 85"
    "./result_8chains/node195_5_2.txt 85"
    "./result_8chains/node195_6_0.txt 84"
    "./result_8chains/node195_6_2.txt 84"
    "./result_8chains/node195_7_0.txt 83"
    "./result_8chains/node195_7_2.txt 83"
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
