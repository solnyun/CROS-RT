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
ros2 run evaluation_3_randomdag uunifast_node -n node376_0_2 -p 31 -st topic376_0_1 -pt None -u 0.0274666937698953 > ./result_6chains/node376_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_1_2 -p 233 -st topic376_1_1 -pt None -u 0.03666753722658672 > ./result_6chains/node376_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_2_2 -p 275 -st topic376_2_1 -pt None -u 0.04313263248649718 > ./result_6chains/node376_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_3_2 -p 529 -st topic376_3_1 -pt None -u 0.012159273792349962 > ./result_6chains/node376_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_4_2 -p 667 -st topic376_4_1 -pt None -u 0.01504501934046494 > ./result_6chains/node376_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_5_2 -p 951 -st topic376_5_1 -pt None -u 0.05139104573783663 > ./result_6chains/node376_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_0_0 -p 31 -st none -pt topic376_0_0 -u 0.06808299748183932 > ./result_6chains/node376_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_1_0 -p 233 -st none -pt topic376_1_0 -u 0.008332751486906098 > ./result_6chains/node376_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_2_0 -p 275 -st none -pt topic376_2_0 -u 0.0038863239227689417 > ./result_6chains/node376_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_3_0 -p 529 -st none -pt topic376_3_0 -u 0.022312389098584684 > ./result_6chains/node376_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_4_0 -p 667 -st none -pt topic376_4_0 -u 0.045028720690733326 > ./result_6chains/node376_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_5_0 -p 951 -st none -pt topic376_5_0 -u 0.010143912279869535 > ./result_6chains/node376_5_0.txt &
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
    "./result_6chains/node376_0_0.txt 90"
    "./result_6chains/node376_0_2.txt 90"
    "./result_6chains/node376_1_0.txt 89"
    "./result_6chains/node376_1_2.txt 89"
    "./result_6chains/node376_2_0.txt 88"
    "./result_6chains/node376_2_2.txt 88"
    "./result_6chains/node376_3_0.txt 87"
    "./result_6chains/node376_3_2.txt 87"
    "./result_6chains/node376_4_0.txt 86"
    "./result_6chains/node376_4_2.txt 86"
    "./result_6chains/node376_5_0.txt 85"
    "./result_6chains/node376_5_2.txt 85"
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
