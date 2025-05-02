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
ros2 run evaluation_3_randomdag uunifast_node -n node147_0_2 -p 124 -st topic147_0_1 -pt None -u 0.04808523535881909 > ./result_8chains/node147_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_1_2 -p 131 -st topic147_1_1 -pt None -u 0.01486163371381477 > ./result_8chains/node147_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_2_2 -p 244 -st topic147_2_1 -pt None -u 0.02526098502566515 > ./result_8chains/node147_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_3_2 -p 301 -st topic147_3_1 -pt None -u 0.013077968201146484 > ./result_8chains/node147_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_4_2 -p 324 -st topic147_4_1 -pt None -u 0.04861520025446642 > ./result_8chains/node147_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_5_2 -p 438 -st topic147_5_1 -pt None -u 0.026547182003503006 > ./result_8chains/node147_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_6_2 -p 527 -st topic147_6_1 -pt None -u 0.025007842287461557 > ./result_8chains/node147_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_7_2 -p 830 -st topic147_7_1 -pt None -u 0.006920318860781934 > ./result_8chains/node147_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_0_0 -p 124 -st none -pt topic147_0_0 -u 0.04025517565745451 > ./result_8chains/node147_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_1_0 -p 131 -st none -pt topic147_1_0 -u 0.033922801961005444 > ./result_8chains/node147_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_2_0 -p 244 -st none -pt topic147_2_0 -u 0.0028003385932722225 > ./result_8chains/node147_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_3_0 -p 301 -st none -pt topic147_3_0 -u 0.003943291482546685 > ./result_8chains/node147_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_4_0 -p 324 -st none -pt topic147_4_0 -u 0.013354772731538789 > ./result_8chains/node147_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_5_0 -p 438 -st none -pt topic147_5_0 -u 0.011377313070339373 > ./result_8chains/node147_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_6_0 -p 527 -st none -pt topic147_6_0 -u 0.029259225328576277 > ./result_8chains/node147_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_7_0 -p 830 -st none -pt topic147_7_0 -u 0.022183823659547297 > ./result_8chains/node147_7_0.txt &
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
    "./result_8chains/node147_0_0.txt 90"
    "./result_8chains/node147_0_2.txt 90"
    "./result_8chains/node147_1_0.txt 89"
    "./result_8chains/node147_1_2.txt 89"
    "./result_8chains/node147_2_0.txt 88"
    "./result_8chains/node147_2_2.txt 88"
    "./result_8chains/node147_3_0.txt 87"
    "./result_8chains/node147_3_2.txt 87"
    "./result_8chains/node147_4_0.txt 86"
    "./result_8chains/node147_4_2.txt 86"
    "./result_8chains/node147_5_0.txt 85"
    "./result_8chains/node147_5_2.txt 85"
    "./result_8chains/node147_6_0.txt 84"
    "./result_8chains/node147_6_2.txt 84"
    "./result_8chains/node147_7_0.txt 83"
    "./result_8chains/node147_7_2.txt 83"
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
