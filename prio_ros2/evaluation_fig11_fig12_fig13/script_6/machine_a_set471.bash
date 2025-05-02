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
ros2 run evaluation_3_randomdag uunifast_node -n node471_0_2 -p 163 -st topic471_0_1 -pt None -u 0.012814296077177822 > ./result_6chains/node471_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_1_2 -p 261 -st topic471_1_1 -pt None -u 0.004027667560583259 > ./result_6chains/node471_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_2_2 -p 358 -st topic471_2_1 -pt None -u 0.14895068497108802 > ./result_6chains/node471_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_3_2 -p 516 -st topic471_3_1 -pt None -u 0.04096696173404189 > ./result_6chains/node471_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_4_2 -p 583 -st topic471_4_1 -pt None -u 0.011922117844229495 > ./result_6chains/node471_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_5_2 -p 632 -st topic471_5_1 -pt None -u 0.026415864455292173 > ./result_6chains/node471_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_0_0 -p 163 -st none -pt topic471_0_0 -u 0.021536884857547622 > ./result_6chains/node471_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_1_0 -p 261 -st none -pt topic471_1_0 -u 0.0063572704205613895 > ./result_6chains/node471_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_2_0 -p 358 -st none -pt topic471_2_0 -u 0.017032117150130477 > ./result_6chains/node471_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_3_0 -p 516 -st none -pt topic471_3_0 -u 0.028156740458819635 > ./result_6chains/node471_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node471_4_0 -p 583 -st none -pt topic471_4_0 -u 0.0040194652676955045 > ./result_6chains/node471_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node471_5_0 -p 632 -st none -pt topic471_5_0 -u 0.015523304164257318 > ./result_6chains/node471_5_0.txt &
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
    "./result_6chains/node471_0_0.txt 90"
    "./result_6chains/node471_0_2.txt 90"
    "./result_6chains/node471_1_0.txt 89"
    "./result_6chains/node471_1_2.txt 89"
    "./result_6chains/node471_2_0.txt 88"
    "./result_6chains/node471_2_2.txt 88"
    "./result_6chains/node471_3_0.txt 87"
    "./result_6chains/node471_3_2.txt 87"
    "./result_6chains/node471_4_0.txt 86"
    "./result_6chains/node471_4_2.txt 86"
    "./result_6chains/node471_5_0.txt 85"
    "./result_6chains/node471_5_2.txt 85"
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
