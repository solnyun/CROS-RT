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
ros2 run evaluation_3_randomdag uunifast_node -n node258_0_2 -p 32 -st topic258_0_1 -pt None -u 0.0775923793585429 > ./result_8chains/node258_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_1_2 -p 317 -st topic258_1_1 -pt None -u 0.03199012555005165 > ./result_8chains/node258_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_2_2 -p 563 -st topic258_2_1 -pt None -u 0.008528967077709393 > ./result_8chains/node258_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_3_2 -p 688 -st topic258_3_1 -pt None -u 0.04029750043256858 > ./result_8chains/node258_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_4_2 -p 723 -st topic258_4_1 -pt None -u 0.04933909455962052 > ./result_8chains/node258_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_5_2 -p 772 -st topic258_5_1 -pt None -u 0.0007030679436729054 > ./result_8chains/node258_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_6_2 -p 784 -st topic258_6_1 -pt None -u 0.03607076287264869 > ./result_8chains/node258_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_7_2 -p 804 -st topic258_7_1 -pt None -u 0.018245387539200953 > ./result_8chains/node258_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_0_0 -p 32 -st none -pt topic258_0_0 -u 0.01128539161783948 > ./result_8chains/node258_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_1_0 -p 317 -st none -pt topic258_1_0 -u 0.015901067068889663 > ./result_8chains/node258_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_2_0 -p 563 -st none -pt topic258_2_0 -u 0.012743436490632642 > ./result_8chains/node258_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_3_0 -p 688 -st none -pt topic258_3_0 -u 0.0064695605531345235 > ./result_8chains/node258_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_4_0 -p 723 -st none -pt topic258_4_0 -u 0.010191010044356213 > ./result_8chains/node258_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_5_0 -p 772 -st none -pt topic258_5_0 -u 0.01995188415986976 > ./result_8chains/node258_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node258_6_0 -p 784 -st none -pt topic258_6_0 -u 0.00181465274115572 > ./result_8chains/node258_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node258_7_0 -p 804 -st none -pt topic258_7_0 -u 0.016570843721196528 > ./result_8chains/node258_7_0.txt &
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
    "./result_8chains/node258_0_0.txt 90"
    "./result_8chains/node258_0_2.txt 90"
    "./result_8chains/node258_1_0.txt 89"
    "./result_8chains/node258_1_2.txt 89"
    "./result_8chains/node258_2_0.txt 88"
    "./result_8chains/node258_2_2.txt 88"
    "./result_8chains/node258_3_0.txt 87"
    "./result_8chains/node258_3_2.txt 87"
    "./result_8chains/node258_4_0.txt 86"
    "./result_8chains/node258_4_2.txt 86"
    "./result_8chains/node258_5_0.txt 85"
    "./result_8chains/node258_5_2.txt 85"
    "./result_8chains/node258_6_0.txt 84"
    "./result_8chains/node258_6_2.txt 84"
    "./result_8chains/node258_7_0.txt 83"
    "./result_8chains/node258_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
