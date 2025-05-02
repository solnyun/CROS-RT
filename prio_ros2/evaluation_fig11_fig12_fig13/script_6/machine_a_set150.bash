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
ros2 run evaluation_3_randomdag uunifast_node -n node150_0_2 -p 220 -st topic150_0_1 -pt None -u 0.005608511971446295 > ./result_6chains/node150_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_1_2 -p 359 -st topic150_1_1 -pt None -u 0.00019280908351654302 > ./result_6chains/node150_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_2_2 -p 363 -st topic150_2_1 -pt None -u 0.005463869302329727 > ./result_6chains/node150_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_3_2 -p 604 -st topic150_3_1 -pt None -u 0.02278617894106849 > ./result_6chains/node150_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_4_2 -p 626 -st topic150_4_1 -pt None -u 0.13233887703131675 > ./result_6chains/node150_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_5_2 -p 695 -st topic150_5_1 -pt None -u 0.01952886131873293 > ./result_6chains/node150_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_0_0 -p 220 -st none -pt topic150_0_0 -u 0.0046018465768610795 > ./result_6chains/node150_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_1_0 -p 359 -st none -pt topic150_1_0 -u 0.003188253150316289 > ./result_6chains/node150_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_2_0 -p 363 -st none -pt topic150_2_0 -u 0.027405897372884402 > ./result_6chains/node150_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_3_0 -p 604 -st none -pt topic150_3_0 -u 0.05212184903402556 > ./result_6chains/node150_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node150_4_0 -p 626 -st none -pt topic150_4_0 -u 0.014094390878656382 > ./result_6chains/node150_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node150_5_0 -p 695 -st none -pt topic150_5_0 -u 0.009845545392001234 > ./result_6chains/node150_5_0.txt &
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
    "./result_6chains/node150_0_0.txt 90"
    "./result_6chains/node150_0_2.txt 90"
    "./result_6chains/node150_1_0.txt 89"
    "./result_6chains/node150_1_2.txt 89"
    "./result_6chains/node150_2_0.txt 88"
    "./result_6chains/node150_2_2.txt 88"
    "./result_6chains/node150_3_0.txt 87"
    "./result_6chains/node150_3_2.txt 87"
    "./result_6chains/node150_4_0.txt 86"
    "./result_6chains/node150_4_2.txt 86"
    "./result_6chains/node150_5_0.txt 85"
    "./result_6chains/node150_5_2.txt 85"
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
