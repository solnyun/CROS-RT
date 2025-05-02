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
ros2 run evaluation_3_randomdag uunifast_node -n node167_0_2 -p 85 -st topic167_0_1 -pt None -u 0.006142314867578491 > ./result_6chains/node167_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_1_2 -p 107 -st topic167_1_1 -pt None -u 0.022321490164967872 > ./result_6chains/node167_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_2_2 -p 518 -st topic167_2_1 -pt None -u 0.12253252840767487 > ./result_6chains/node167_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_3_2 -p 856 -st topic167_3_1 -pt None -u 0.052557672782668 > ./result_6chains/node167_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_4_2 -p 925 -st topic167_4_1 -pt None -u 0.017380612660208572 > ./result_6chains/node167_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_5_2 -p 969 -st topic167_5_1 -pt None -u 0.007937311583098563 > ./result_6chains/node167_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_0_0 -p 85 -st none -pt topic167_0_0 -u 0.04384436582076301 > ./result_6chains/node167_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_1_0 -p 107 -st none -pt topic167_1_0 -u 0.0004591376197663477 > ./result_6chains/node167_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_2_0 -p 518 -st none -pt topic167_2_0 -u 0.014904686664445999 > ./result_6chains/node167_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_3_0 -p 856 -st none -pt topic167_3_0 -u 0.030388229904890623 > ./result_6chains/node167_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_4_0 -p 925 -st none -pt topic167_4_0 -u 0.030691655062614676 > ./result_6chains/node167_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node167_5_0 -p 969 -st none -pt topic167_5_0 -u 0.028440073524004145 > ./result_6chains/node167_5_0.txt &
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
    "./result_6chains/node167_0_0.txt 90"
    "./result_6chains/node167_0_2.txt 90"
    "./result_6chains/node167_1_0.txt 89"
    "./result_6chains/node167_1_2.txt 89"
    "./result_6chains/node167_2_0.txt 88"
    "./result_6chains/node167_2_2.txt 88"
    "./result_6chains/node167_3_0.txt 87"
    "./result_6chains/node167_3_2.txt 87"
    "./result_6chains/node167_4_0.txt 86"
    "./result_6chains/node167_4_2.txt 86"
    "./result_6chains/node167_5_0.txt 85"
    "./result_6chains/node167_5_2.txt 85"
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
