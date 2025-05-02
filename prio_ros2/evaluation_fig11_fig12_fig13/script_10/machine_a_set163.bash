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
ros2 run evaluation_3_randomdag uunifast_node -n node163_0_2 -p 86 -st topic163_0_1 -pt None -u 0.008315560529092159 > ./result_10chains/node163_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_1_2 -p 97 -st topic163_1_1 -pt None -u 0.014821312944324871 > ./result_10chains/node163_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_2_2 -p 136 -st topic163_2_1 -pt None -u 0.014694299945380018 > ./result_10chains/node163_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_3_2 -p 187 -st topic163_3_1 -pt None -u 0.012782237298270716 > ./result_10chains/node163_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_4_2 -p 295 -st topic163_4_1 -pt None -u 0.05186080287769734 > ./result_10chains/node163_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_5_2 -p 610 -st topic163_5_1 -pt None -u 0.00030602643002491936 > ./result_10chains/node163_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_6_2 -p 650 -st topic163_6_1 -pt None -u 0.019035115564683472 > ./result_10chains/node163_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_7_2 -p 749 -st topic163_7_1 -pt None -u 0.005215310890160391 > ./result_10chains/node163_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_8_2 -p 787 -st topic163_8_1 -pt None -u 0.0015059124370993965 > ./result_10chains/node163_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_9_2 -p 986 -st topic163_9_1 -pt None -u 0.021230435804243823 > ./result_10chains/node163_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_0_0 -p 86 -st none -pt topic163_0_0 -u 0.05510008289900614 > ./result_10chains/node163_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_1_0 -p 97 -st none -pt topic163_1_0 -u 0.00567860440149931 > ./result_10chains/node163_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_2_0 -p 136 -st none -pt topic163_2_0 -u 0.017934427580667767 > ./result_10chains/node163_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_3_0 -p 187 -st none -pt topic163_3_0 -u 0.00130509954449598 > ./result_10chains/node163_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_4_0 -p 295 -st none -pt topic163_4_0 -u 0.00933131371006407 > ./result_10chains/node163_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_5_0 -p 610 -st none -pt topic163_5_0 -u 0.032223362706176095 > ./result_10chains/node163_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_6_0 -p 650 -st none -pt topic163_6_0 -u 0.06863044394908409 > ./result_10chains/node163_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_7_0 -p 749 -st none -pt topic163_7_0 -u 0.008738888631419445 > ./result_10chains/node163_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_8_0 -p 787 -st none -pt topic163_8_0 -u 0.02313787840670222 > ./result_10chains/node163_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node163_9_0 -p 986 -st none -pt topic163_9_0 -u 0.0193220060254105 > ./result_10chains/node163_9_0.txt &
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
    "./result_10chains/node163_0_0.txt 90"
    "./result_10chains/node163_0_2.txt 90"
    "./result_10chains/node163_1_0.txt 89"
    "./result_10chains/node163_1_2.txt 89"
    "./result_10chains/node163_2_0.txt 88"
    "./result_10chains/node163_2_2.txt 88"
    "./result_10chains/node163_3_0.txt 87"
    "./result_10chains/node163_3_2.txt 87"
    "./result_10chains/node163_4_0.txt 86"
    "./result_10chains/node163_4_2.txt 86"
    "./result_10chains/node163_5_0.txt 85"
    "./result_10chains/node163_5_2.txt 85"
    "./result_10chains/node163_6_0.txt 84"
    "./result_10chains/node163_6_2.txt 84"
    "./result_10chains/node163_7_0.txt 83"
    "./result_10chains/node163_7_2.txt 83"
    "./result_10chains/node163_8_0.txt 82"
    "./result_10chains/node163_8_2.txt 82"
    "./result_10chains/node163_9_0.txt 81"
    "./result_10chains/node163_9_2.txt 81"
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
