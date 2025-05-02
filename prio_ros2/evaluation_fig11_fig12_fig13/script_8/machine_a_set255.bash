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
ros2 run evaluation_3_randomdag uunifast_node -n node255_0_2 -p 19 -st topic255_0_1 -pt None -u 0.009990032188455567 > ./result_8chains/node255_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_1_2 -p 329 -st topic255_1_1 -pt None -u 0.03446943007809894 > ./result_8chains/node255_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_2_2 -p 350 -st topic255_2_1 -pt None -u 0.049872508084547795 > ./result_8chains/node255_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_3_2 -p 871 -st topic255_3_1 -pt None -u 0.052668503857590115 > ./result_8chains/node255_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_4_2 -p 880 -st topic255_4_1 -pt None -u 0.004663110406548598 > ./result_8chains/node255_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_5_2 -p 887 -st topic255_5_1 -pt None -u 0.02874338075098745 > ./result_8chains/node255_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_6_2 -p 939 -st topic255_6_1 -pt None -u 0.0042192031020042015 > ./result_8chains/node255_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_7_2 -p 952 -st topic255_7_1 -pt None -u 0.06416574133153694 > ./result_8chains/node255_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_0_0 -p 19 -st none -pt topic255_0_0 -u 0.004252825846353281 > ./result_8chains/node255_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_1_0 -p 329 -st none -pt topic255_1_0 -u 0.002802963591881924 > ./result_8chains/node255_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_2_0 -p 350 -st none -pt topic255_2_0 -u 0.028425302446336398 > ./result_8chains/node255_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_3_0 -p 871 -st none -pt topic255_3_0 -u 0.015918052077388445 > ./result_8chains/node255_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_4_0 -p 880 -st none -pt topic255_4_0 -u 0.020391306296837913 > ./result_8chains/node255_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_5_0 -p 887 -st none -pt topic255_5_0 -u 0.04553379123496232 > ./result_8chains/node255_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_6_0 -p 939 -st none -pt topic255_6_0 -u 0.0005162510234464901 > ./result_8chains/node255_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node255_7_0 -p 952 -st none -pt topic255_7_0 -u 0.009159531962975753 > ./result_8chains/node255_7_0.txt &
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
    "./result_8chains/node255_0_0.txt 90"
    "./result_8chains/node255_0_2.txt 90"
    "./result_8chains/node255_1_0.txt 89"
    "./result_8chains/node255_1_2.txt 89"
    "./result_8chains/node255_2_0.txt 88"
    "./result_8chains/node255_2_2.txt 88"
    "./result_8chains/node255_3_0.txt 87"
    "./result_8chains/node255_3_2.txt 87"
    "./result_8chains/node255_4_0.txt 86"
    "./result_8chains/node255_4_2.txt 86"
    "./result_8chains/node255_5_0.txt 85"
    "./result_8chains/node255_5_2.txt 85"
    "./result_8chains/node255_6_0.txt 84"
    "./result_8chains/node255_6_2.txt 84"
    "./result_8chains/node255_7_0.txt 83"
    "./result_8chains/node255_7_2.txt 83"
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
