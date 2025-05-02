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
ros2 run evaluation_3_randomdag uunifast_node -n node152_0_2 -p 192 -st topic152_0_1 -pt None -u 0.015815110366952212 > ./result_8chains/node152_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_1_2 -p 270 -st topic152_1_1 -pt None -u 0.011773591332561839 > ./result_8chains/node152_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_2_2 -p 276 -st topic152_2_1 -pt None -u 0.005802394519584975 > ./result_8chains/node152_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_3_2 -p 400 -st topic152_3_1 -pt None -u 0.006137661747278644 > ./result_8chains/node152_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_4_2 -p 537 -st topic152_4_1 -pt None -u 0.011447613727035177 > ./result_8chains/node152_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_5_2 -p 570 -st topic152_5_1 -pt None -u 0.017434429527424772 > ./result_8chains/node152_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_6_2 -p 591 -st topic152_6_1 -pt None -u 0.004945428561646911 > ./result_8chains/node152_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_7_2 -p 710 -st topic152_7_1 -pt None -u 0.020804747951553917 > ./result_8chains/node152_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_0_0 -p 192 -st none -pt topic152_0_0 -u 0.013757058266573474 > ./result_8chains/node152_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_1_0 -p 270 -st none -pt topic152_1_0 -u 0.013659173496312849 > ./result_8chains/node152_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_2_0 -p 276 -st none -pt topic152_2_0 -u 0.09491117902116963 > ./result_8chains/node152_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_3_0 -p 400 -st none -pt topic152_3_0 -u 0.042845363500568445 > ./result_8chains/node152_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_4_0 -p 537 -st none -pt topic152_4_0 -u 0.04055498966471627 > ./result_8chains/node152_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_5_0 -p 570 -st none -pt topic152_5_0 -u 0.015568894583637416 > ./result_8chains/node152_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_6_0 -p 591 -st none -pt topic152_6_0 -u 0.05800231667879586 > ./result_8chains/node152_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_7_0 -p 710 -st none -pt topic152_7_0 -u 0.007783175881365179 > ./result_8chains/node152_7_0.txt &
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
    "./result_8chains/node152_0_0.txt 90"
    "./result_8chains/node152_0_2.txt 90"
    "./result_8chains/node152_1_0.txt 89"
    "./result_8chains/node152_1_2.txt 89"
    "./result_8chains/node152_2_0.txt 88"
    "./result_8chains/node152_2_2.txt 88"
    "./result_8chains/node152_3_0.txt 87"
    "./result_8chains/node152_3_2.txt 87"
    "./result_8chains/node152_4_0.txt 86"
    "./result_8chains/node152_4_2.txt 86"
    "./result_8chains/node152_5_0.txt 85"
    "./result_8chains/node152_5_2.txt 85"
    "./result_8chains/node152_6_0.txt 84"
    "./result_8chains/node152_6_2.txt 84"
    "./result_8chains/node152_7_0.txt 83"
    "./result_8chains/node152_7_2.txt 83"
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
