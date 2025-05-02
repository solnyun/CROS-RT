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
ros2 run evaluation_3_randomdag uunifast_node -n node365_0_2 -p 61 -st topic365_0_1 -pt None -u 0.078431140148296 > ./result_6chains/node365_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_1_2 -p 94 -st topic365_1_1 -pt None -u 0.07307530994141426 > ./result_6chains/node365_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_2_2 -p 398 -st topic365_2_1 -pt None -u 0.02172170036408791 > ./result_6chains/node365_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_3_2 -p 675 -st topic365_3_1 -pt None -u 0.016258729080293743 > ./result_6chains/node365_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_4_2 -p 930 -st topic365_4_1 -pt None -u 0.015116097656931692 > ./result_6chains/node365_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_5_2 -p 988 -st topic365_5_1 -pt None -u 0.016851343035579062 > ./result_6chains/node365_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_0_0 -p 61 -st none -pt topic365_0_0 -u 0.004901425202230081 > ./result_6chains/node365_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_1_0 -p 94 -st none -pt topic365_1_0 -u 0.01924119020096815 > ./result_6chains/node365_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_2_0 -p 398 -st none -pt topic365_2_0 -u 0.006909905268260075 > ./result_6chains/node365_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_3_0 -p 675 -st none -pt topic365_3_0 -u 0.007547292715133075 > ./result_6chains/node365_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node365_4_0 -p 930 -st none -pt topic365_4_0 -u 0.06319242580523765 > ./result_6chains/node365_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node365_5_0 -p 988 -st none -pt topic365_5_0 -u 0.0017227676832877667 > ./result_6chains/node365_5_0.txt &
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
    "./result_6chains/node365_0_0.txt 90"
    "./result_6chains/node365_0_2.txt 90"
    "./result_6chains/node365_1_0.txt 89"
    "./result_6chains/node365_1_2.txt 89"
    "./result_6chains/node365_2_0.txt 88"
    "./result_6chains/node365_2_2.txt 88"
    "./result_6chains/node365_3_0.txt 87"
    "./result_6chains/node365_3_2.txt 87"
    "./result_6chains/node365_4_0.txt 86"
    "./result_6chains/node365_4_2.txt 86"
    "./result_6chains/node365_5_0.txt 85"
    "./result_6chains/node365_5_2.txt 85"
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
