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
ros2 run evaluation_3_randomdag uunifast_node -n node311_0_2 -p 210 -st topic311_0_1 -pt None -u 0.062061011175248204 > ./result_4chains/node311_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_1_2 -p 220 -st topic311_1_1 -pt None -u 0.14875083395054756 > ./result_4chains/node311_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_2_2 -p 760 -st topic311_2_1 -pt None -u 0.03331892312937157 > ./result_4chains/node311_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_3_2 -p 805 -st topic311_3_1 -pt None -u 0.07591065711642721 > ./result_4chains/node311_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_0_0 -p 210 -st none -pt topic311_0_0 -u 0.019152193637888337 > ./result_4chains/node311_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_1_0 -p 220 -st none -pt topic311_1_0 -u 0.014311386191838193 > ./result_4chains/node311_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_2_0 -p 760 -st none -pt topic311_2_0 -u 0.012454156233590669 > ./result_4chains/node311_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_3_0 -p 805 -st none -pt topic311_3_0 -u 0.03425168513834548 > ./result_4chains/node311_3_0.txt &
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
    "./result_4chains/node311_0_0.txt 90"
    "./result_4chains/node311_0_2.txt 90"
    "./result_4chains/node311_1_0.txt 89"
    "./result_4chains/node311_1_2.txt 89"
    "./result_4chains/node311_2_0.txt 88"
    "./result_4chains/node311_2_2.txt 88"
    "./result_4chains/node311_3_0.txt 87"
    "./result_4chains/node311_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
