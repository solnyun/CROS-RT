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
ros2 run evaluation_3_randomdag uunifast_node -n node66_0_2 -p 307 -st topic66_0_1 -pt None -u 0.012119884703912509 > ./result_8chains/node66_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_1_2 -p 358 -st topic66_1_1 -pt None -u 0.018103472309168978 > ./result_8chains/node66_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_2_2 -p 391 -st topic66_2_1 -pt None -u 0.023838093172228625 > ./result_8chains/node66_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_3_2 -p 415 -st topic66_3_1 -pt None -u 0.012176464746241011 > ./result_8chains/node66_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_4_2 -p 429 -st topic66_4_1 -pt None -u 0.021774289719306034 > ./result_8chains/node66_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_5_2 -p 675 -st topic66_5_1 -pt None -u 0.007351218331056286 > ./result_8chains/node66_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_6_2 -p 807 -st topic66_6_1 -pt None -u 0.02534274449955007 > ./result_8chains/node66_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_7_2 -p 844 -st topic66_7_1 -pt None -u 0.06822101163106555 > ./result_8chains/node66_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_0_0 -p 307 -st none -pt topic66_0_0 -u 0.0006440681620747402 > ./result_8chains/node66_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_1_0 -p 358 -st none -pt topic66_1_0 -u 0.036633676876125676 > ./result_8chains/node66_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_2_0 -p 391 -st none -pt topic66_2_0 -u 0.001758563688957715 > ./result_8chains/node66_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_3_0 -p 415 -st none -pt topic66_3_0 -u 0.047726138193179446 > ./result_8chains/node66_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_4_0 -p 429 -st none -pt topic66_4_0 -u 0.03632002393872738 > ./result_8chains/node66_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_5_0 -p 675 -st none -pt topic66_5_0 -u 0.009604828455328313 > ./result_8chains/node66_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_6_0 -p 807 -st none -pt topic66_6_0 -u 0.030524542718558506 > ./result_8chains/node66_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_7_0 -p 844 -st none -pt topic66_7_0 -u 0.00471254830609763 > ./result_8chains/node66_7_0.txt &
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
    "./result_8chains/node66_0_0.txt 90"
    "./result_8chains/node66_0_2.txt 90"
    "./result_8chains/node66_1_0.txt 89"
    "./result_8chains/node66_1_2.txt 89"
    "./result_8chains/node66_2_0.txt 88"
    "./result_8chains/node66_2_2.txt 88"
    "./result_8chains/node66_3_0.txt 87"
    "./result_8chains/node66_3_2.txt 87"
    "./result_8chains/node66_4_0.txt 86"
    "./result_8chains/node66_4_2.txt 86"
    "./result_8chains/node66_5_0.txt 85"
    "./result_8chains/node66_5_2.txt 85"
    "./result_8chains/node66_6_0.txt 84"
    "./result_8chains/node66_6_2.txt 84"
    "./result_8chains/node66_7_0.txt 83"
    "./result_8chains/node66_7_2.txt 83"
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
