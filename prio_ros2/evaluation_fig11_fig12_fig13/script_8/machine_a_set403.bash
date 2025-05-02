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
ros2 run evaluation_3_randomdag uunifast_node -n node403_0_2 -p 91 -st topic403_0_1 -pt None -u 0.030025871824563566 > ./result_8chains/node403_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_1_2 -p 156 -st topic403_1_1 -pt None -u 0.014488642600171797 > ./result_8chains/node403_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_2_2 -p 357 -st topic403_2_1 -pt None -u 0.01916147478422081 > ./result_8chains/node403_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_3_2 -p 495 -st topic403_3_1 -pt None -u 0.006808389782133939 > ./result_8chains/node403_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_4_2 -p 520 -st topic403_4_1 -pt None -u 0.0018333207850962374 > ./result_8chains/node403_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_5_2 -p 551 -st topic403_5_1 -pt None -u 0.003964476464289157 > ./result_8chains/node403_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_6_2 -p 895 -st topic403_6_1 -pt None -u 0.010135735303759497 > ./result_8chains/node403_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_7_2 -p 906 -st topic403_7_1 -pt None -u 0.025068129586454033 > ./result_8chains/node403_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_0_0 -p 91 -st none -pt topic403_0_0 -u 0.003279976292367315 > ./result_8chains/node403_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_1_0 -p 156 -st none -pt topic403_1_0 -u 0.004031506560939091 > ./result_8chains/node403_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_2_0 -p 357 -st none -pt topic403_2_0 -u 0.025135446877120438 > ./result_8chains/node403_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_3_0 -p 495 -st none -pt topic403_3_0 -u 0.033244486896361336 > ./result_8chains/node403_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_4_0 -p 520 -st none -pt topic403_4_0 -u 0.0801043304446224 > ./result_8chains/node403_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_5_0 -p 551 -st none -pt topic403_5_0 -u 0.023008480771517154 > ./result_8chains/node403_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node403_6_0 -p 895 -st none -pt topic403_6_0 -u 0.001776704634736198 > ./result_8chains/node403_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node403_7_0 -p 906 -st none -pt topic403_7_0 -u 0.0455618050531396 > ./result_8chains/node403_7_0.txt &
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
    "./result_8chains/node403_0_0.txt 90"
    "./result_8chains/node403_0_2.txt 90"
    "./result_8chains/node403_1_0.txt 89"
    "./result_8chains/node403_1_2.txt 89"
    "./result_8chains/node403_2_0.txt 88"
    "./result_8chains/node403_2_2.txt 88"
    "./result_8chains/node403_3_0.txt 87"
    "./result_8chains/node403_3_2.txt 87"
    "./result_8chains/node403_4_0.txt 86"
    "./result_8chains/node403_4_2.txt 86"
    "./result_8chains/node403_5_0.txt 85"
    "./result_8chains/node403_5_2.txt 85"
    "./result_8chains/node403_6_0.txt 84"
    "./result_8chains/node403_6_2.txt 84"
    "./result_8chains/node403_7_0.txt 83"
    "./result_8chains/node403_7_2.txt 83"
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
