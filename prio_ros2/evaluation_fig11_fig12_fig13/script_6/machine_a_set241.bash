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
ros2 run evaluation_3_randomdag uunifast_node -n node241_0_2 -p 623 -st topic241_0_1 -pt None -u 0.035476115938319286 > ./result_6chains/node241_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_1_2 -p 689 -st topic241_1_1 -pt None -u 0.012311571225519236 > ./result_6chains/node241_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_2_2 -p 706 -st topic241_2_1 -pt None -u 0.007089924337192521 > ./result_6chains/node241_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_3_2 -p 836 -st topic241_3_1 -pt None -u 0.018914149254750157 > ./result_6chains/node241_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_4_2 -p 925 -st topic241_4_1 -pt None -u 0.004306883824787944 > ./result_6chains/node241_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_5_2 -p 962 -st topic241_5_1 -pt None -u 0.01437066738831937 > ./result_6chains/node241_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_0_0 -p 623 -st none -pt topic241_0_0 -u 0.0049177157593375265 > ./result_6chains/node241_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_1_0 -p 689 -st none -pt topic241_1_0 -u 0.007049562017205746 > ./result_6chains/node241_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_2_0 -p 706 -st none -pt topic241_2_0 -u 0.0274329375408901 > ./result_6chains/node241_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_3_0 -p 836 -st none -pt topic241_3_0 -u 0.05545435688229433 > ./result_6chains/node241_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_4_0 -p 925 -st none -pt topic241_4_0 -u 0.009940723576322308 > ./result_6chains/node241_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node241_5_0 -p 962 -st none -pt topic241_5_0 -u 0.10308853559761495 > ./result_6chains/node241_5_0.txt &
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
    "./result_6chains/node241_0_0.txt 90"
    "./result_6chains/node241_0_2.txt 90"
    "./result_6chains/node241_1_0.txt 89"
    "./result_6chains/node241_1_2.txt 89"
    "./result_6chains/node241_2_0.txt 88"
    "./result_6chains/node241_2_2.txt 88"
    "./result_6chains/node241_3_0.txt 87"
    "./result_6chains/node241_3_2.txt 87"
    "./result_6chains/node241_4_0.txt 86"
    "./result_6chains/node241_4_2.txt 86"
    "./result_6chains/node241_5_0.txt 85"
    "./result_6chains/node241_5_2.txt 85"
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
