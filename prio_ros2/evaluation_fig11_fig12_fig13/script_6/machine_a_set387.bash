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
ros2 run evaluation_3_randomdag uunifast_node -n node387_0_2 -p 272 -st topic387_0_1 -pt None -u 0.023176069378527675 > ./result_6chains/node387_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_1_2 -p 303 -st topic387_1_1 -pt None -u 0.023077015357036768 > ./result_6chains/node387_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_2_2 -p 339 -st topic387_2_1 -pt None -u 0.03433739716685985 > ./result_6chains/node387_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_3_2 -p 417 -st topic387_3_1 -pt None -u 0.00023095498534900227 > ./result_6chains/node387_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_4_2 -p 559 -st topic387_4_1 -pt None -u 0.010147778593181153 > ./result_6chains/node387_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_5_2 -p 906 -st topic387_5_1 -pt None -u 0.047351074309279054 > ./result_6chains/node387_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_0_0 -p 272 -st none -pt topic387_0_0 -u 0.0017194995538323266 > ./result_6chains/node387_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_1_0 -p 303 -st none -pt topic387_1_0 -u 0.06956176365887495 > ./result_6chains/node387_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_2_0 -p 339 -st none -pt topic387_2_0 -u 0.010428915445761244 > ./result_6chains/node387_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_3_0 -p 417 -st none -pt topic387_3_0 -u 0.03906468120974574 > ./result_6chains/node387_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_4_0 -p 559 -st none -pt topic387_4_0 -u 0.0009597095461729016 > ./result_6chains/node387_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_5_0 -p 906 -st none -pt topic387_5_0 -u 0.026901272434543037 > ./result_6chains/node387_5_0.txt &
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
    "./result_6chains/node387_0_0.txt 90"
    "./result_6chains/node387_0_2.txt 90"
    "./result_6chains/node387_1_0.txt 89"
    "./result_6chains/node387_1_2.txt 89"
    "./result_6chains/node387_2_0.txt 88"
    "./result_6chains/node387_2_2.txt 88"
    "./result_6chains/node387_3_0.txt 87"
    "./result_6chains/node387_3_2.txt 87"
    "./result_6chains/node387_4_0.txt 86"
    "./result_6chains/node387_4_2.txt 86"
    "./result_6chains/node387_5_0.txt 85"
    "./result_6chains/node387_5_2.txt 85"
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
