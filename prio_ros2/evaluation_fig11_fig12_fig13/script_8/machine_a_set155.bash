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
ros2 run evaluation_3_randomdag uunifast_node -n node155_0_2 -p 19 -st topic155_0_1 -pt None -u 0.037998074595623654 > ./result_8chains/node155_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_1_2 -p 242 -st topic155_1_1 -pt None -u 0.07012325745440012 > ./result_8chains/node155_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_2_2 -p 309 -st topic155_2_1 -pt None -u 0.032736523785929506 > ./result_8chains/node155_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_3_2 -p 426 -st topic155_3_1 -pt None -u 0.030234676379493786 > ./result_8chains/node155_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_4_2 -p 580 -st topic155_4_1 -pt None -u 0.008474067008217123 > ./result_8chains/node155_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_5_2 -p 724 -st topic155_5_1 -pt None -u 0.0200684619529838 > ./result_8chains/node155_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_6_2 -p 811 -st topic155_6_1 -pt None -u 0.0015568365073552887 > ./result_8chains/node155_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_7_2 -p 875 -st topic155_7_1 -pt None -u 0.0009334725350429766 > ./result_8chains/node155_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_0_0 -p 19 -st none -pt topic155_0_0 -u 0.01220716775741204 > ./result_8chains/node155_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_1_0 -p 242 -st none -pt topic155_1_0 -u 0.014836551396092523 > ./result_8chains/node155_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_2_0 -p 309 -st none -pt topic155_2_0 -u 0.0012300710198017706 > ./result_8chains/node155_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_3_0 -p 426 -st none -pt topic155_3_0 -u 0.018042730878130075 > ./result_8chains/node155_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_4_0 -p 580 -st none -pt topic155_4_0 -u 0.011492166836995249 > ./result_8chains/node155_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_5_0 -p 724 -st none -pt topic155_5_0 -u 0.016825746970544564 > ./result_8chains/node155_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node155_6_0 -p 811 -st none -pt topic155_6_0 -u 0.0003517540019335186 > ./result_8chains/node155_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node155_7_0 -p 875 -st none -pt topic155_7_0 -u 0.05080980713273686 > ./result_8chains/node155_7_0.txt &
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
    "./result_8chains/node155_0_0.txt 90"
    "./result_8chains/node155_0_2.txt 90"
    "./result_8chains/node155_1_0.txt 89"
    "./result_8chains/node155_1_2.txt 89"
    "./result_8chains/node155_2_0.txt 88"
    "./result_8chains/node155_2_2.txt 88"
    "./result_8chains/node155_3_0.txt 87"
    "./result_8chains/node155_3_2.txt 87"
    "./result_8chains/node155_4_0.txt 86"
    "./result_8chains/node155_4_2.txt 86"
    "./result_8chains/node155_5_0.txt 85"
    "./result_8chains/node155_5_2.txt 85"
    "./result_8chains/node155_6_0.txt 84"
    "./result_8chains/node155_6_2.txt 84"
    "./result_8chains/node155_7_0.txt 83"
    "./result_8chains/node155_7_2.txt 83"
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
