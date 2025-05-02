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
ros2 run evaluation_3_randomdag uunifast_node -n node406_0_2 -p 145 -st topic406_0_1 -pt None -u 0.004433713221847657 > ./result_8chains/node406_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_1_2 -p 347 -st topic406_1_1 -pt None -u 0.02326078120750108 > ./result_8chains/node406_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_2_2 -p 367 -st topic406_2_1 -pt None -u 0.01628792225462916 > ./result_8chains/node406_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_3_2 -p 434 -st topic406_3_1 -pt None -u 0.010446738191425664 > ./result_8chains/node406_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_4_2 -p 456 -st topic406_4_1 -pt None -u 0.007279003527985883 > ./result_8chains/node406_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_5_2 -p 557 -st topic406_5_1 -pt None -u 0.006774831604114628 > ./result_8chains/node406_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_6_2 -p 713 -st topic406_6_1 -pt None -u 0.015693843268910157 > ./result_8chains/node406_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_7_2 -p 996 -st topic406_7_1 -pt None -u 0.00787814188805412 > ./result_8chains/node406_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_0_0 -p 145 -st none -pt topic406_0_0 -u 0.009945891002316076 > ./result_8chains/node406_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_1_0 -p 347 -st none -pt topic406_1_0 -u 0.018779173392700466 > ./result_8chains/node406_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_2_0 -p 367 -st none -pt topic406_2_0 -u 0.031034144807230324 > ./result_8chains/node406_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_3_0 -p 434 -st none -pt topic406_3_0 -u 0.009923686138024967 > ./result_8chains/node406_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_4_0 -p 456 -st none -pt topic406_4_0 -u 0.038707060250181696 > ./result_8chains/node406_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_5_0 -p 557 -st none -pt topic406_5_0 -u 0.04522597312806159 > ./result_8chains/node406_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_6_0 -p 713 -st none -pt topic406_6_0 -u 0.029125668127674753 > ./result_8chains/node406_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_7_0 -p 996 -st none -pt topic406_7_0 -u 0.005995839468393931 > ./result_8chains/node406_7_0.txt &
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
    "./result_8chains/node406_0_0.txt 90"
    "./result_8chains/node406_0_2.txt 90"
    "./result_8chains/node406_1_0.txt 89"
    "./result_8chains/node406_1_2.txt 89"
    "./result_8chains/node406_2_0.txt 88"
    "./result_8chains/node406_2_2.txt 88"
    "./result_8chains/node406_3_0.txt 87"
    "./result_8chains/node406_3_2.txt 87"
    "./result_8chains/node406_4_0.txt 86"
    "./result_8chains/node406_4_2.txt 86"
    "./result_8chains/node406_5_0.txt 85"
    "./result_8chains/node406_5_2.txt 85"
    "./result_8chains/node406_6_0.txt 84"
    "./result_8chains/node406_6_2.txt 84"
    "./result_8chains/node406_7_0.txt 83"
    "./result_8chains/node406_7_2.txt 83"
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
