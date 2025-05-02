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
ros2 run evaluation_3_randomdag uunifast_node -n node254_0_2 -p 118 -st topic254_0_1 -pt None -u 0.08864753028115702 > ./result_8chains/node254_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_1_2 -p 313 -st topic254_1_1 -pt None -u 0.037687651891335994 > ./result_8chains/node254_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_2_2 -p 316 -st topic254_2_1 -pt None -u 0.009670948690758158 > ./result_8chains/node254_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_3_2 -p 516 -st topic254_3_1 -pt None -u 0.008903620851242855 > ./result_8chains/node254_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_4_2 -p 545 -st topic254_4_1 -pt None -u 0.004461376614377094 > ./result_8chains/node254_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_5_2 -p 613 -st topic254_5_1 -pt None -u 0.008184780231246525 > ./result_8chains/node254_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_6_2 -p 870 -st topic254_6_1 -pt None -u 0.018713613190050826 > ./result_8chains/node254_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_7_2 -p 961 -st topic254_7_1 -pt None -u 0.022120650896986015 > ./result_8chains/node254_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_0_0 -p 118 -st none -pt topic254_0_0 -u 0.03391776207956909 > ./result_8chains/node254_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_1_0 -p 313 -st none -pt topic254_1_0 -u 0.021817240146252914 > ./result_8chains/node254_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_2_0 -p 316 -st none -pt topic254_2_0 -u 0.01429539825082482 > ./result_8chains/node254_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_3_0 -p 516 -st none -pt topic254_3_0 -u 0.03412237343163915 > ./result_8chains/node254_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_4_0 -p 545 -st none -pt topic254_4_0 -u 0.02164118118892927 > ./result_8chains/node254_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_5_0 -p 613 -st none -pt topic254_5_0 -u 0.0006886363980156684 > ./result_8chains/node254_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node254_6_0 -p 870 -st none -pt topic254_6_0 -u 0.004696281345492284 > ./result_8chains/node254_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node254_7_0 -p 961 -st none -pt topic254_7_0 -u 0.00037592298173121097 > ./result_8chains/node254_7_0.txt &
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
    "./result_8chains/node254_0_0.txt 90"
    "./result_8chains/node254_0_2.txt 90"
    "./result_8chains/node254_1_0.txt 89"
    "./result_8chains/node254_1_2.txt 89"
    "./result_8chains/node254_2_0.txt 88"
    "./result_8chains/node254_2_2.txt 88"
    "./result_8chains/node254_3_0.txt 87"
    "./result_8chains/node254_3_2.txt 87"
    "./result_8chains/node254_4_0.txt 86"
    "./result_8chains/node254_4_2.txt 86"
    "./result_8chains/node254_5_0.txt 85"
    "./result_8chains/node254_5_2.txt 85"
    "./result_8chains/node254_6_0.txt 84"
    "./result_8chains/node254_6_2.txt 84"
    "./result_8chains/node254_7_0.txt 83"
    "./result_8chains/node254_7_2.txt 83"
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
