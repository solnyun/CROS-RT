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
ros2 run evaluation_3_randomdag uunifast_node -n node367_0_2 -p 95 -st topic367_0_1 -pt None -u 0.08334894438936152 > ./result_6chains/node367_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_1_2 -p 288 -st topic367_1_1 -pt None -u 0.0035816166367996227 > ./result_6chains/node367_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_2_2 -p 488 -st topic367_2_1 -pt None -u 0.028266328945506736 > ./result_6chains/node367_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_3_2 -p 812 -st topic367_3_1 -pt None -u 0.011095513698858195 > ./result_6chains/node367_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_4_2 -p 923 -st topic367_4_1 -pt None -u 0.0007400646823380735 > ./result_6chains/node367_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_5_2 -p 956 -st topic367_5_1 -pt None -u 0.013189263413657398 > ./result_6chains/node367_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_0_0 -p 95 -st none -pt topic367_0_0 -u 0.01293366964791115 > ./result_6chains/node367_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_1_0 -p 288 -st none -pt topic367_1_0 -u 0.006173835035831188 > ./result_6chains/node367_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_2_0 -p 488 -st none -pt topic367_2_0 -u 0.046434547264857295 > ./result_6chains/node367_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_3_0 -p 812 -st none -pt topic367_3_0 -u 0.027942429217563708 > ./result_6chains/node367_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node367_4_0 -p 923 -st none -pt topic367_4_0 -u 0.028816640785463712 > ./result_6chains/node367_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node367_5_0 -p 956 -st none -pt topic367_5_0 -u 0.05901347492430628 > ./result_6chains/node367_5_0.txt &
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
    "./result_6chains/node367_0_0.txt 90"
    "./result_6chains/node367_0_2.txt 90"
    "./result_6chains/node367_1_0.txt 89"
    "./result_6chains/node367_1_2.txt 89"
    "./result_6chains/node367_2_0.txt 88"
    "./result_6chains/node367_2_2.txt 88"
    "./result_6chains/node367_3_0.txt 87"
    "./result_6chains/node367_3_2.txt 87"
    "./result_6chains/node367_4_0.txt 86"
    "./result_6chains/node367_4_2.txt 86"
    "./result_6chains/node367_5_0.txt 85"
    "./result_6chains/node367_5_2.txt 85"
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
