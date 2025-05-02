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
ros2 run evaluation_3_randomdag uunifast_node -n node158_0_2 -p 101 -st topic158_0_1 -pt None -u 0.0398472014482969 > ./result_10chains/node158_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_1_2 -p 127 -st topic158_1_1 -pt None -u 0.01277917899221298 > ./result_10chains/node158_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_2_2 -p 135 -st topic158_2_1 -pt None -u 0.0027051281764705615 > ./result_10chains/node158_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_3_2 -p 273 -st topic158_3_1 -pt None -u 0.0027481557888082153 > ./result_10chains/node158_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_4_2 -p 279 -st topic158_4_1 -pt None -u 0.007623779243545459 > ./result_10chains/node158_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_5_2 -p 310 -st topic158_5_1 -pt None -u 0.01597402279873597 > ./result_10chains/node158_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_6_2 -p 353 -st topic158_6_1 -pt None -u 0.0053054541126941746 > ./result_10chains/node158_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_7_2 -p 425 -st topic158_7_1 -pt None -u 0.08171323211301228 > ./result_10chains/node158_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_8_2 -p 884 -st topic158_8_1 -pt None -u 0.019978504851531763 > ./result_10chains/node158_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_9_2 -p 985 -st topic158_9_1 -pt None -u 0.009880675995849323 > ./result_10chains/node158_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_0_0 -p 101 -st none -pt topic158_0_0 -u 0.010061962207744912 > ./result_10chains/node158_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_1_0 -p 127 -st none -pt topic158_1_0 -u 0.014445506042674361 > ./result_10chains/node158_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_2_0 -p 135 -st none -pt topic158_2_0 -u 0.03606534214578522 > ./result_10chains/node158_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_3_0 -p 273 -st none -pt topic158_3_0 -u 0.0032550639966139605 > ./result_10chains/node158_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_4_0 -p 279 -st none -pt topic158_4_0 -u 0.009044069456921433 > ./result_10chains/node158_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_5_0 -p 310 -st none -pt topic158_5_0 -u 2.6262746704641682e-05 > ./result_10chains/node158_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_6_0 -p 353 -st none -pt topic158_6_0 -u 0.005685250815414211 > ./result_10chains/node158_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_7_0 -p 425 -st none -pt topic158_7_0 -u 0.0057882893009056635 > ./result_10chains/node158_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_8_0 -p 884 -st none -pt topic158_8_0 -u 0.02234558514919739 > ./result_10chains/node158_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_9_0 -p 985 -st none -pt topic158_9_0 -u 0.03345823057279582 > ./result_10chains/node158_9_0.txt &
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
    "./result_10chains/node158_0_0.txt 90"
    "./result_10chains/node158_0_2.txt 90"
    "./result_10chains/node158_1_0.txt 89"
    "./result_10chains/node158_1_2.txt 89"
    "./result_10chains/node158_2_0.txt 88"
    "./result_10chains/node158_2_2.txt 88"
    "./result_10chains/node158_3_0.txt 87"
    "./result_10chains/node158_3_2.txt 87"
    "./result_10chains/node158_4_0.txt 86"
    "./result_10chains/node158_4_2.txt 86"
    "./result_10chains/node158_5_0.txt 85"
    "./result_10chains/node158_5_2.txt 85"
    "./result_10chains/node158_6_0.txt 84"
    "./result_10chains/node158_6_2.txt 84"
    "./result_10chains/node158_7_0.txt 83"
    "./result_10chains/node158_7_2.txt 83"
    "./result_10chains/node158_8_0.txt 82"
    "./result_10chains/node158_8_2.txt 82"
    "./result_10chains/node158_9_0.txt 81"
    "./result_10chains/node158_9_2.txt 81"
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
