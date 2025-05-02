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
ros2 run evaluation_3_randomdag uunifast_node -n node318_0_2 -p 62 -st topic318_0_1 -pt None -u 0.025202168108727774 > ./result_10chains/node318_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_1_2 -p 134 -st topic318_1_1 -pt None -u 0.035563587479762626 > ./result_10chains/node318_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_2_2 -p 148 -st topic318_2_1 -pt None -u 0.009707189598540944 > ./result_10chains/node318_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_3_2 -p 229 -st topic318_3_1 -pt None -u 0.013162627335635835 > ./result_10chains/node318_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_4_2 -p 262 -st topic318_4_1 -pt None -u 0.0027056964553630602 > ./result_10chains/node318_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_5_2 -p 467 -st topic318_5_1 -pt None -u 0.004427208792663562 > ./result_10chains/node318_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_6_2 -p 674 -st topic318_6_1 -pt None -u 0.018852961495127663 > ./result_10chains/node318_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_7_2 -p 793 -st topic318_7_1 -pt None -u 0.0008592461965210296 > ./result_10chains/node318_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_8_2 -p 796 -st topic318_8_1 -pt None -u 0.036453140814524415 > ./result_10chains/node318_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_9_2 -p 839 -st topic318_9_1 -pt None -u 0.01644411304003727 > ./result_10chains/node318_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_0_0 -p 62 -st none -pt topic318_0_0 -u 0.016262753870944446 > ./result_10chains/node318_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_1_0 -p 134 -st none -pt topic318_1_0 -u 0.019757419858489 > ./result_10chains/node318_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_2_0 -p 148 -st none -pt topic318_2_0 -u 0.009499159362855003 > ./result_10chains/node318_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_3_0 -p 229 -st none -pt topic318_3_0 -u 0.0013299426341218945 > ./result_10chains/node318_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_4_0 -p 262 -st none -pt topic318_4_0 -u 0.0015203134218596537 > ./result_10chains/node318_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_5_0 -p 467 -st none -pt topic318_5_0 -u 0.022516611201793435 > ./result_10chains/node318_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_6_0 -p 674 -st none -pt topic318_6_0 -u 0.028726359299251547 > ./result_10chains/node318_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_7_0 -p 793 -st none -pt topic318_7_0 -u 0.00423098845760525 > ./result_10chains/node318_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node318_8_0 -p 796 -st none -pt topic318_8_0 -u 0.024438203623355748 > ./result_10chains/node318_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node318_9_0 -p 839 -st none -pt topic318_9_0 -u 0.009484781207214632 > ./result_10chains/node318_9_0.txt &
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
    "./result_10chains/node318_0_0.txt 90"
    "./result_10chains/node318_0_2.txt 90"
    "./result_10chains/node318_1_0.txt 89"
    "./result_10chains/node318_1_2.txt 89"
    "./result_10chains/node318_2_0.txt 88"
    "./result_10chains/node318_2_2.txt 88"
    "./result_10chains/node318_3_0.txt 87"
    "./result_10chains/node318_3_2.txt 87"
    "./result_10chains/node318_4_0.txt 86"
    "./result_10chains/node318_4_2.txt 86"
    "./result_10chains/node318_5_0.txt 85"
    "./result_10chains/node318_5_2.txt 85"
    "./result_10chains/node318_6_0.txt 84"
    "./result_10chains/node318_6_2.txt 84"
    "./result_10chains/node318_7_0.txt 83"
    "./result_10chains/node318_7_2.txt 83"
    "./result_10chains/node318_8_0.txt 82"
    "./result_10chains/node318_8_2.txt 82"
    "./result_10chains/node318_9_0.txt 81"
    "./result_10chains/node318_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
