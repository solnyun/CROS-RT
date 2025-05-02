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
ros2 run evaluation_3_randomdag uunifast_node -n node104_0_2 -p 104 -st topic104_0_1 -pt None -u 0.01787291926218887 > ./result_6chains/node104_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_1_2 -p 230 -st topic104_1_1 -pt None -u 0.02158485517532488 > ./result_6chains/node104_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_2_2 -p 682 -st topic104_2_1 -pt None -u 0.0227150533499276 > ./result_6chains/node104_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_3_2 -p 723 -st topic104_3_1 -pt None -u 0.03415981515112404 > ./result_6chains/node104_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_4_2 -p 956 -st topic104_4_1 -pt None -u 0.04541543349036807 > ./result_6chains/node104_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_5_2 -p 995 -st topic104_5_1 -pt None -u 0.009883824454477042 > ./result_6chains/node104_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_0_0 -p 104 -st none -pt topic104_0_0 -u 0.1195501411894 > ./result_6chains/node104_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_1_0 -p 230 -st none -pt topic104_1_0 -u 0.008678368325633679 > ./result_6chains/node104_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_2_0 -p 682 -st none -pt topic104_2_0 -u 0.05246656786295334 > ./result_6chains/node104_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_3_0 -p 723 -st none -pt topic104_3_0 -u 0.005893274222497025 > ./result_6chains/node104_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_4_0 -p 956 -st none -pt topic104_4_0 -u 0.002385049172582393 > ./result_6chains/node104_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node104_5_0 -p 995 -st none -pt topic104_5_0 -u 0.03320484947097152 > ./result_6chains/node104_5_0.txt &
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
    "./result_6chains/node104_0_0.txt 90"
    "./result_6chains/node104_0_2.txt 90"
    "./result_6chains/node104_1_0.txt 89"
    "./result_6chains/node104_1_2.txt 89"
    "./result_6chains/node104_2_0.txt 88"
    "./result_6chains/node104_2_2.txt 88"
    "./result_6chains/node104_3_0.txt 87"
    "./result_6chains/node104_3_2.txt 87"
    "./result_6chains/node104_4_0.txt 86"
    "./result_6chains/node104_4_2.txt 86"
    "./result_6chains/node104_5_0.txt 85"
    "./result_6chains/node104_5_2.txt 85"
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
