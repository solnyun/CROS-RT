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
ros2 run evaluation_3_randomdag uunifast_node -n node266_0_2 -p 54 -st topic266_0_1 -pt None -u 0.0010371519444066224 > ./result_8chains/node266_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_1_2 -p 192 -st topic266_1_1 -pt None -u 0.0227991354789413 > ./result_8chains/node266_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_2_2 -p 355 -st topic266_2_1 -pt None -u 0.025458458154316965 > ./result_8chains/node266_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_3_2 -p 457 -st topic266_3_1 -pt None -u 0.011381144202400106 > ./result_8chains/node266_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_4_2 -p 658 -st topic266_4_1 -pt None -u 0.05637252766044201 > ./result_8chains/node266_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_5_2 -p 820 -st topic266_5_1 -pt None -u 0.002247031913297823 > ./result_8chains/node266_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_6_2 -p 886 -st topic266_6_1 -pt None -u 0.0016317149154068122 > ./result_8chains/node266_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_7_2 -p 903 -st topic266_7_1 -pt None -u 0.05341248492228714 > ./result_8chains/node266_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_0_0 -p 54 -st none -pt topic266_0_0 -u 0.08661030063314479 > ./result_8chains/node266_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_1_0 -p 192 -st none -pt topic266_1_0 -u 0.004030836974233898 > ./result_8chains/node266_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_2_0 -p 355 -st none -pt topic266_2_0 -u 0.029440314638696286 > ./result_8chains/node266_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_3_0 -p 457 -st none -pt topic266_3_0 -u 0.011351406645178141 > ./result_8chains/node266_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_4_0 -p 658 -st none -pt topic266_4_0 -u 0.014605412204345108 > ./result_8chains/node266_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_5_0 -p 820 -st none -pt topic266_5_0 -u 0.009172757199168838 > ./result_8chains/node266_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_6_0 -p 886 -st none -pt topic266_6_0 -u 0.0060724858075513755 > ./result_8chains/node266_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_7_0 -p 903 -st none -pt topic266_7_0 -u 0.00023786030518051227 > ./result_8chains/node266_7_0.txt &
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
    "./result_8chains/node266_0_0.txt 90"
    "./result_8chains/node266_0_2.txt 90"
    "./result_8chains/node266_1_0.txt 89"
    "./result_8chains/node266_1_2.txt 89"
    "./result_8chains/node266_2_0.txt 88"
    "./result_8chains/node266_2_2.txt 88"
    "./result_8chains/node266_3_0.txt 87"
    "./result_8chains/node266_3_2.txt 87"
    "./result_8chains/node266_4_0.txt 86"
    "./result_8chains/node266_4_2.txt 86"
    "./result_8chains/node266_5_0.txt 85"
    "./result_8chains/node266_5_2.txt 85"
    "./result_8chains/node266_6_0.txt 84"
    "./result_8chains/node266_6_2.txt 84"
    "./result_8chains/node266_7_0.txt 83"
    "./result_8chains/node266_7_2.txt 83"
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
