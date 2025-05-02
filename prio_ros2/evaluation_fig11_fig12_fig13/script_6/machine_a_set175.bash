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
ros2 run evaluation_3_randomdag uunifast_node -n node175_0_2 -p 117 -st topic175_0_1 -pt None -u 0.04246222694950935 > ./result_6chains/node175_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_1_2 -p 426 -st topic175_1_1 -pt None -u 0.02435385753476077 > ./result_6chains/node175_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_2_2 -p 466 -st topic175_2_1 -pt None -u 0.005909648414170743 > ./result_6chains/node175_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_3_2 -p 906 -st topic175_3_1 -pt None -u 0.012690968616163728 > ./result_6chains/node175_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_4_2 -p 913 -st topic175_4_1 -pt None -u 0.004891389190722489 > ./result_6chains/node175_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_5_2 -p 919 -st topic175_5_1 -pt None -u 0.03597911213858744 > ./result_6chains/node175_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_0_0 -p 117 -st none -pt topic175_0_0 -u 0.009552806284985171 > ./result_6chains/node175_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_1_0 -p 426 -st none -pt topic175_1_0 -u 0.021431601814646928 > ./result_6chains/node175_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_2_0 -p 466 -st none -pt topic175_2_0 -u 0.04434232361030188 > ./result_6chains/node175_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_3_0 -p 906 -st none -pt topic175_3_0 -u 0.03353198717034994 > ./result_6chains/node175_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_4_0 -p 913 -st none -pt topic175_4_0 -u 0.0016891684949255359 > ./result_6chains/node175_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node175_5_0 -p 919 -st none -pt topic175_5_0 -u 0.015756897536885667 > ./result_6chains/node175_5_0.txt &
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
    "./result_6chains/node175_0_0.txt 90"
    "./result_6chains/node175_0_2.txt 90"
    "./result_6chains/node175_1_0.txt 89"
    "./result_6chains/node175_1_2.txt 89"
    "./result_6chains/node175_2_0.txt 88"
    "./result_6chains/node175_2_2.txt 88"
    "./result_6chains/node175_3_0.txt 87"
    "./result_6chains/node175_3_2.txt 87"
    "./result_6chains/node175_4_0.txt 86"
    "./result_6chains/node175_4_2.txt 86"
    "./result_6chains/node175_5_0.txt 85"
    "./result_6chains/node175_5_2.txt 85"
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
