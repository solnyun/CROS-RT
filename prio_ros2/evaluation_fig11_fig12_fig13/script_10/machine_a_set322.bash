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
ros2 run evaluation_3_randomdag uunifast_node -n node322_0_2 -p 143 -st topic322_0_1 -pt None -u 0.0004388555307018316 > ./result_10chains/node322_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_1_2 -p 157 -st topic322_1_1 -pt None -u 0.03836196727940949 > ./result_10chains/node322_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_2_2 -p 161 -st topic322_2_1 -pt None -u 0.013177375058758878 > ./result_10chains/node322_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_3_2 -p 250 -st topic322_3_1 -pt None -u 0.020959033374355007 > ./result_10chains/node322_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_4_2 -p 470 -st topic322_4_1 -pt None -u 0.08214987643182037 > ./result_10chains/node322_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_5_2 -p 505 -st topic322_5_1 -pt None -u 0.002020867467627141 > ./result_10chains/node322_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_6_2 -p 666 -st topic322_6_1 -pt None -u 0.005819079596625476 > ./result_10chains/node322_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_7_2 -p 675 -st topic322_7_1 -pt None -u 0.005693649801821611 > ./result_10chains/node322_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_8_2 -p 767 -st topic322_8_1 -pt None -u 0.0025481113346056718 > ./result_10chains/node322_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_9_2 -p 883 -st topic322_9_1 -pt None -u 0.006268964058315028 > ./result_10chains/node322_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_0_0 -p 143 -st none -pt topic322_0_0 -u 0.00032716035471902494 > ./result_10chains/node322_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_1_0 -p 157 -st none -pt topic322_1_0 -u 0.009314701358438648 > ./result_10chains/node322_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_2_0 -p 161 -st none -pt topic322_2_0 -u 0.03118417947023394 > ./result_10chains/node322_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_3_0 -p 250 -st none -pt topic322_3_0 -u 0.013127922336623188 > ./result_10chains/node322_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_4_0 -p 470 -st none -pt topic322_4_0 -u 0.038123524833234224 > ./result_10chains/node322_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_5_0 -p 505 -st none -pt topic322_5_0 -u 0.003810196761586754 > ./result_10chains/node322_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_6_0 -p 666 -st none -pt topic322_6_0 -u 0.0200784215698272 > ./result_10chains/node322_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_7_0 -p 675 -st none -pt topic322_7_0 -u 0.046223132101027894 > ./result_10chains/node322_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_8_0 -p 767 -st none -pt topic322_8_0 -u 0.0007515448941489491 > ./result_10chains/node322_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_9_0 -p 883 -st none -pt topic322_9_0 -u 0.014963699878071987 > ./result_10chains/node322_9_0.txt &
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
    "./result_10chains/node322_0_0.txt 90"
    "./result_10chains/node322_0_2.txt 90"
    "./result_10chains/node322_1_0.txt 89"
    "./result_10chains/node322_1_2.txt 89"
    "./result_10chains/node322_2_0.txt 88"
    "./result_10chains/node322_2_2.txt 88"
    "./result_10chains/node322_3_0.txt 87"
    "./result_10chains/node322_3_2.txt 87"
    "./result_10chains/node322_4_0.txt 86"
    "./result_10chains/node322_4_2.txt 86"
    "./result_10chains/node322_5_0.txt 85"
    "./result_10chains/node322_5_2.txt 85"
    "./result_10chains/node322_6_0.txt 84"
    "./result_10chains/node322_6_2.txt 84"
    "./result_10chains/node322_7_0.txt 83"
    "./result_10chains/node322_7_2.txt 83"
    "./result_10chains/node322_8_0.txt 82"
    "./result_10chains/node322_8_2.txt 82"
    "./result_10chains/node322_9_0.txt 81"
    "./result_10chains/node322_9_2.txt 81"
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
