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
ros2 run evaluation_3_randomdag uunifast_node -n node259_0_2 -p 310 -st topic259_0_1 -pt None -u 0.016089270034307657 > ./result_6chains/node259_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_1_2 -p 319 -st topic259_1_1 -pt None -u 0.0022099312543827354 > ./result_6chains/node259_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_2_2 -p 474 -st topic259_2_1 -pt None -u 0.0035698948984870804 > ./result_6chains/node259_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_3_2 -p 838 -st topic259_3_1 -pt None -u 0.08887170043893103 > ./result_6chains/node259_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_4_2 -p 868 -st topic259_4_1 -pt None -u 0.02353316497701085 > ./result_6chains/node259_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_5_2 -p 887 -st topic259_5_1 -pt None -u 0.01684286513314113 > ./result_6chains/node259_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_0_0 -p 310 -st none -pt topic259_0_0 -u 0.0005652823721205014 > ./result_6chains/node259_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_1_0 -p 319 -st none -pt topic259_1_0 -u 0.030408774680615758 > ./result_6chains/node259_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_2_0 -p 474 -st none -pt topic259_2_0 -u 0.024021573352760617 > ./result_6chains/node259_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_3_0 -p 838 -st none -pt topic259_3_0 -u 0.03462865660657405 > ./result_6chains/node259_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_4_0 -p 868 -st none -pt topic259_4_0 -u 0.0663009867431727 > ./result_6chains/node259_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node259_5_0 -p 887 -st none -pt topic259_5_0 -u 0.023620898924069163 > ./result_6chains/node259_5_0.txt &
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
    "./result_6chains/node259_0_0.txt 90"
    "./result_6chains/node259_0_2.txt 90"
    "./result_6chains/node259_1_0.txt 89"
    "./result_6chains/node259_1_2.txt 89"
    "./result_6chains/node259_2_0.txt 88"
    "./result_6chains/node259_2_2.txt 88"
    "./result_6chains/node259_3_0.txt 87"
    "./result_6chains/node259_3_2.txt 87"
    "./result_6chains/node259_4_0.txt 86"
    "./result_6chains/node259_4_2.txt 86"
    "./result_6chains/node259_5_0.txt 85"
    "./result_6chains/node259_5_2.txt 85"
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
