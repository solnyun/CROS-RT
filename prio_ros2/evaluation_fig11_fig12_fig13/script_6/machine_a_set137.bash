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
ros2 run evaluation_3_randomdag uunifast_node -n node137_0_2 -p 380 -st topic137_0_1 -pt None -u 0.034223122292643404 > ./result_6chains/node137_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_1_2 -p 456 -st topic137_1_1 -pt None -u 0.022763690832309114 > ./result_6chains/node137_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_2_2 -p 643 -st topic137_2_1 -pt None -u 0.022171860881428862 > ./result_6chains/node137_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_3_2 -p 795 -st topic137_3_1 -pt None -u 0.028290350322220006 > ./result_6chains/node137_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_4_2 -p 849 -st topic137_4_1 -pt None -u 0.009955219327013473 > ./result_6chains/node137_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_5_2 -p 904 -st topic137_5_1 -pt None -u 0.012660938984695433 > ./result_6chains/node137_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_0_0 -p 380 -st none -pt topic137_0_0 -u 0.09850003576671978 > ./result_6chains/node137_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_1_0 -p 456 -st none -pt topic137_1_0 -u 0.060414609811867026 > ./result_6chains/node137_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_2_0 -p 643 -st none -pt topic137_2_0 -u 0.03602499027996062 > ./result_6chains/node137_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_3_0 -p 795 -st none -pt topic137_3_0 -u 0.02649969422805358 > ./result_6chains/node137_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_4_0 -p 849 -st none -pt topic137_4_0 -u 0.024685132041084593 > ./result_6chains/node137_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_5_0 -p 904 -st none -pt topic137_5_0 -u 0.0020423884745565286 > ./result_6chains/node137_5_0.txt &
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
    "./result_6chains/node137_0_0.txt 90"
    "./result_6chains/node137_0_2.txt 90"
    "./result_6chains/node137_1_0.txt 89"
    "./result_6chains/node137_1_2.txt 89"
    "./result_6chains/node137_2_0.txt 88"
    "./result_6chains/node137_2_2.txt 88"
    "./result_6chains/node137_3_0.txt 87"
    "./result_6chains/node137_3_2.txt 87"
    "./result_6chains/node137_4_0.txt 86"
    "./result_6chains/node137_4_2.txt 86"
    "./result_6chains/node137_5_0.txt 85"
    "./result_6chains/node137_5_2.txt 85"
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
