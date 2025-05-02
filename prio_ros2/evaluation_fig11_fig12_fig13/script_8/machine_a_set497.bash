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
ros2 run evaluation_3_randomdag uunifast_node -n node497_0_2 -p 17 -st topic497_0_1 -pt None -u 0.04350198104711639 > ./result_8chains/node497_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_1_2 -p 280 -st topic497_1_1 -pt None -u 0.030148958058130337 > ./result_8chains/node497_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_2_2 -p 286 -st topic497_2_1 -pt None -u 0.01758312420760416 > ./result_8chains/node497_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_3_2 -p 292 -st topic497_3_1 -pt None -u 0.01304477821104627 > ./result_8chains/node497_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_4_2 -p 423 -st topic497_4_1 -pt None -u 0.013002391840995275 > ./result_8chains/node497_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_5_2 -p 722 -st topic497_5_1 -pt None -u 0.0019387370881837618 > ./result_8chains/node497_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_6_2 -p 866 -st topic497_6_1 -pt None -u 0.03427370623570594 > ./result_8chains/node497_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_7_2 -p 971 -st topic497_7_1 -pt None -u 0.04215835888611537 > ./result_8chains/node497_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_0_0 -p 17 -st none -pt topic497_0_0 -u 0.011697191205896407 > ./result_8chains/node497_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_1_0 -p 280 -st none -pt topic497_1_0 -u 0.058259487249862685 > ./result_8chains/node497_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_2_0 -p 286 -st none -pt topic497_2_0 -u 0.022744011632761796 > ./result_8chains/node497_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_3_0 -p 292 -st none -pt topic497_3_0 -u 0.007817770001636748 > ./result_8chains/node497_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_4_0 -p 423 -st none -pt topic497_4_0 -u 0.012914825241100408 > ./result_8chains/node497_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_5_0 -p 722 -st none -pt topic497_5_0 -u 0.03471609939098785 > ./result_8chains/node497_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_6_0 -p 866 -st none -pt topic497_6_0 -u 0.023988181576572065 > ./result_8chains/node497_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node497_7_0 -p 971 -st none -pt topic497_7_0 -u 0.010132076423051813 > ./result_8chains/node497_7_0.txt &
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
    "./result_8chains/node497_0_0.txt 90"
    "./result_8chains/node497_0_2.txt 90"
    "./result_8chains/node497_1_0.txt 89"
    "./result_8chains/node497_1_2.txt 89"
    "./result_8chains/node497_2_0.txt 88"
    "./result_8chains/node497_2_2.txt 88"
    "./result_8chains/node497_3_0.txt 87"
    "./result_8chains/node497_3_2.txt 87"
    "./result_8chains/node497_4_0.txt 86"
    "./result_8chains/node497_4_2.txt 86"
    "./result_8chains/node497_5_0.txt 85"
    "./result_8chains/node497_5_2.txt 85"
    "./result_8chains/node497_6_0.txt 84"
    "./result_8chains/node497_6_2.txt 84"
    "./result_8chains/node497_7_0.txt 83"
    "./result_8chains/node497_7_2.txt 83"
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
