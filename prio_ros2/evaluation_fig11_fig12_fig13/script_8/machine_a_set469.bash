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
ros2 run evaluation_3_randomdag uunifast_node -n node469_0_2 -p 80 -st topic469_0_1 -pt None -u 0.031461106238595826 > ./result_8chains/node469_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_1_2 -p 251 -st topic469_1_1 -pt None -u 0.09480040050319427 > ./result_8chains/node469_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_2_2 -p 354 -st topic469_2_1 -pt None -u 0.013914622651330144 > ./result_8chains/node469_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_3_2 -p 395 -st topic469_3_1 -pt None -u 0.012716275737306326 > ./result_8chains/node469_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_4_2 -p 607 -st topic469_4_1 -pt None -u 0.016661495890424788 > ./result_8chains/node469_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_5_2 -p 690 -st topic469_5_1 -pt None -u 0.000562828324117387 > ./result_8chains/node469_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_6_2 -p 757 -st topic469_6_1 -pt None -u 0.004173550596778056 > ./result_8chains/node469_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_7_2 -p 879 -st topic469_7_1 -pt None -u 0.030460210213607685 > ./result_8chains/node469_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_0_0 -p 80 -st none -pt topic469_0_0 -u 0.005131995113322962 > ./result_8chains/node469_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_1_0 -p 251 -st none -pt topic469_1_0 -u 0.03679961614806876 > ./result_8chains/node469_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_2_0 -p 354 -st none -pt topic469_2_0 -u 0.03764822973665294 > ./result_8chains/node469_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_3_0 -p 395 -st none -pt topic469_3_0 -u 0.009842900669310789 > ./result_8chains/node469_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_4_0 -p 607 -st none -pt topic469_4_0 -u 0.015487675208154805 > ./result_8chains/node469_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_5_0 -p 690 -st none -pt topic469_5_0 -u 0.011485104246675204 > ./result_8chains/node469_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_6_0 -p 757 -st none -pt topic469_6_0 -u 0.023688911014540334 > ./result_8chains/node469_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_7_0 -p 879 -st none -pt topic469_7_0 -u 0.041074844102429946 > ./result_8chains/node469_7_0.txt &
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
    "./result_8chains/node469_0_0.txt 90"
    "./result_8chains/node469_0_2.txt 90"
    "./result_8chains/node469_1_0.txt 89"
    "./result_8chains/node469_1_2.txt 89"
    "./result_8chains/node469_2_0.txt 88"
    "./result_8chains/node469_2_2.txt 88"
    "./result_8chains/node469_3_0.txt 87"
    "./result_8chains/node469_3_2.txt 87"
    "./result_8chains/node469_4_0.txt 86"
    "./result_8chains/node469_4_2.txt 86"
    "./result_8chains/node469_5_0.txt 85"
    "./result_8chains/node469_5_2.txt 85"
    "./result_8chains/node469_6_0.txt 84"
    "./result_8chains/node469_6_2.txt 84"
    "./result_8chains/node469_7_0.txt 83"
    "./result_8chains/node469_7_2.txt 83"
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
