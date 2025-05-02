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
ros2 run evaluation_3_randomdag uunifast_node -n node34_0_2 -p 164 -st topic34_0_1 -pt None -u 0.02074412196265013 > ./result_8chains/node34_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_1_2 -p 369 -st topic34_1_1 -pt None -u 0.007656639893710682 > ./result_8chains/node34_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_2_2 -p 378 -st topic34_2_1 -pt None -u 0.03572967904202051 > ./result_8chains/node34_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_3_2 -p 385 -st topic34_3_1 -pt None -u 0.01670026197950497 > ./result_8chains/node34_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_4_2 -p 435 -st topic34_4_1 -pt None -u 0.014087815010853516 > ./result_8chains/node34_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_5_2 -p 625 -st topic34_5_1 -pt None -u 0.018259882378424797 > ./result_8chains/node34_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_6_2 -p 644 -st topic34_6_1 -pt None -u 0.03431424151216016 > ./result_8chains/node34_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_7_2 -p 829 -st topic34_7_1 -pt None -u 0.02134265379500349 > ./result_8chains/node34_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_0_0 -p 164 -st none -pt topic34_0_0 -u 0.014730546635631336 > ./result_8chains/node34_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_1_0 -p 369 -st none -pt topic34_1_0 -u 0.0006953830845788933 > ./result_8chains/node34_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_2_0 -p 378 -st none -pt topic34_2_0 -u 0.041815432746451275 > ./result_8chains/node34_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_3_0 -p 385 -st none -pt topic34_3_0 -u 0.0026832356822341086 > ./result_8chains/node34_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_4_0 -p 435 -st none -pt topic34_4_0 -u 0.00015603467717933972 > ./result_8chains/node34_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_5_0 -p 625 -st none -pt topic34_5_0 -u 0.012306310874217713 > ./result_8chains/node34_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_6_0 -p 644 -st none -pt topic34_6_0 -u 0.025954707023324683 > ./result_8chains/node34_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_7_0 -p 829 -st none -pt topic34_7_0 -u 0.016380884169943204 > ./result_8chains/node34_7_0.txt &
sleep 10
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
    "./result_8chains/node34_0_0.txt 90"
    "./result_8chains/node34_0_2.txt 90"
    "./result_8chains/node34_1_0.txt 89"
    "./result_8chains/node34_1_2.txt 89"
    "./result_8chains/node34_2_0.txt 88"
    "./result_8chains/node34_2_2.txt 88"
    "./result_8chains/node34_3_0.txt 87"
    "./result_8chains/node34_3_2.txt 87"
    "./result_8chains/node34_4_0.txt 86"
    "./result_8chains/node34_4_2.txt 86"
    "./result_8chains/node34_5_0.txt 85"
    "./result_8chains/node34_5_2.txt 85"
    "./result_8chains/node34_6_0.txt 84"
    "./result_8chains/node34_6_2.txt 84"
    "./result_8chains/node34_7_0.txt 83"
    "./result_8chains/node34_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
