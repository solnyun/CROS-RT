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
ros2 run evaluation_3_randomdag uunifast_node -n node267_0_2 -p 135 -st topic267_0_1 -pt None -u 0.0381153775165492 > ./result_6chains/node267_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_1_2 -p 187 -st topic267_1_1 -pt None -u 0.021208269562938975 > ./result_6chains/node267_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_2_2 -p 665 -st topic267_2_1 -pt None -u 0.023986719160762393 > ./result_6chains/node267_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_3_2 -p 712 -st topic267_3_1 -pt None -u 0.053934703529106676 > ./result_6chains/node267_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_4_2 -p 774 -st topic267_4_1 -pt None -u 0.030532531690639575 > ./result_6chains/node267_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_5_2 -p 886 -st topic267_5_1 -pt None -u 0.07838632628449167 > ./result_6chains/node267_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_0_0 -p 135 -st none -pt topic267_0_0 -u 0.007594397934297281 > ./result_6chains/node267_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_1_0 -p 187 -st none -pt topic267_1_0 -u 0.003519221634361691 > ./result_6chains/node267_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_2_0 -p 665 -st none -pt topic267_2_0 -u 0.02964054407943817 > ./result_6chains/node267_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_3_0 -p 712 -st none -pt topic267_3_0 -u 0.022027200174858486 > ./result_6chains/node267_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_4_0 -p 774 -st none -pt topic267_4_0 -u 0.03727850985212944 > ./result_6chains/node267_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_5_0 -p 886 -st none -pt topic267_5_0 -u 0.035322709204711644 > ./result_6chains/node267_5_0.txt &
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
    "./result_6chains/node267_0_0.txt 90"
    "./result_6chains/node267_0_2.txt 90"
    "./result_6chains/node267_1_0.txt 89"
    "./result_6chains/node267_1_2.txt 89"
    "./result_6chains/node267_2_0.txt 88"
    "./result_6chains/node267_2_2.txt 88"
    "./result_6chains/node267_3_0.txt 87"
    "./result_6chains/node267_3_2.txt 87"
    "./result_6chains/node267_4_0.txt 86"
    "./result_6chains/node267_4_2.txt 86"
    "./result_6chains/node267_5_0.txt 85"
    "./result_6chains/node267_5_2.txt 85"
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
