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
ros2 run evaluation_3_randomdag uunifast_node -n node211_0_2 -p 284 -st topic211_0_1 -pt None -u 0.006581785925229011 > ./result_6chains/node211_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_1_2 -p 460 -st topic211_1_1 -pt None -u 0.022356462918452585 > ./result_6chains/node211_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_2_2 -p 487 -st topic211_2_1 -pt None -u 0.010487587165808693 > ./result_6chains/node211_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_3_2 -p 885 -st topic211_3_1 -pt None -u 0.0064429588171592 > ./result_6chains/node211_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_4_2 -p 922 -st topic211_4_1 -pt None -u 0.0013791108852102552 > ./result_6chains/node211_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_5_2 -p 959 -st topic211_5_1 -pt None -u 0.027840403342219575 > ./result_6chains/node211_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_0_0 -p 284 -st none -pt topic211_0_0 -u 0.01196812814191045 > ./result_6chains/node211_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_1_0 -p 460 -st none -pt topic211_1_0 -u 0.1441743057922607 > ./result_6chains/node211_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_2_0 -p 487 -st none -pt topic211_2_0 -u 0.010273354786054428 > ./result_6chains/node211_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_3_0 -p 885 -st none -pt topic211_3_0 -u 0.02105337322919021 > ./result_6chains/node211_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node211_4_0 -p 922 -st none -pt topic211_4_0 -u 0.015546995356755272 > ./result_6chains/node211_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node211_5_0 -p 959 -st none -pt topic211_5_0 -u 0.06085577409423716 > ./result_6chains/node211_5_0.txt &
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
    "./result_6chains/node211_0_0.txt 90"
    "./result_6chains/node211_0_2.txt 90"
    "./result_6chains/node211_1_0.txt 89"
    "./result_6chains/node211_1_2.txt 89"
    "./result_6chains/node211_2_0.txt 88"
    "./result_6chains/node211_2_2.txt 88"
    "./result_6chains/node211_3_0.txt 87"
    "./result_6chains/node211_3_2.txt 87"
    "./result_6chains/node211_4_0.txt 86"
    "./result_6chains/node211_4_2.txt 86"
    "./result_6chains/node211_5_0.txt 85"
    "./result_6chains/node211_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
