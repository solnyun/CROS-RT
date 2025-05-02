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
ros2 run evaluation_3_randomdag uunifast_node -n node47_0_2 -p 219 -st topic47_0_1 -pt None -u 0.024441742733227134 > ./result_8chains/node47_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_1_2 -p 364 -st topic47_1_1 -pt None -u 0.01737234624312889 > ./result_8chains/node47_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_2_2 -p 480 -st topic47_2_1 -pt None -u 0.007277054513807002 > ./result_8chains/node47_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_3_2 -p 494 -st topic47_3_1 -pt None -u 0.018067681954594517 > ./result_8chains/node47_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_4_2 -p 514 -st topic47_4_1 -pt None -u 0.010658375399665465 > ./result_8chains/node47_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_5_2 -p 560 -st topic47_5_1 -pt None -u 0.03726656407234938 > ./result_8chains/node47_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_6_2 -p 690 -st topic47_6_1 -pt None -u 0.0012091519386030099 > ./result_8chains/node47_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_7_2 -p 898 -st topic47_7_1 -pt None -u 8.739297395704703e-05 > ./result_8chains/node47_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_0_0 -p 219 -st none -pt topic47_0_0 -u 0.014301909228690735 > ./result_8chains/node47_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_1_0 -p 364 -st none -pt topic47_1_0 -u 0.026385004658652678 > ./result_8chains/node47_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_2_0 -p 480 -st none -pt topic47_2_0 -u 0.0031020463035986157 > ./result_8chains/node47_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_3_0 -p 494 -st none -pt topic47_3_0 -u 0.019358028690945495 > ./result_8chains/node47_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_4_0 -p 514 -st none -pt topic47_4_0 -u 0.05559200356920174 > ./result_8chains/node47_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_5_0 -p 560 -st none -pt topic47_5_0 -u 0.031783975029981676 > ./result_8chains/node47_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node47_6_0 -p 690 -st none -pt topic47_6_0 -u 0.06670866138087549 > ./result_8chains/node47_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node47_7_0 -p 898 -st none -pt topic47_7_0 -u 0.0060513786870334185 > ./result_8chains/node47_7_0.txt &
sleep 10
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
    "./result_8chains/node47_0_0.txt 90"
    "./result_8chains/node47_0_2.txt 90"
    "./result_8chains/node47_1_0.txt 89"
    "./result_8chains/node47_1_2.txt 89"
    "./result_8chains/node47_2_0.txt 88"
    "./result_8chains/node47_2_2.txt 88"
    "./result_8chains/node47_3_0.txt 87"
    "./result_8chains/node47_3_2.txt 87"
    "./result_8chains/node47_4_0.txt 86"
    "./result_8chains/node47_4_2.txt 86"
    "./result_8chains/node47_5_0.txt 85"
    "./result_8chains/node47_5_2.txt 85"
    "./result_8chains/node47_6_0.txt 84"
    "./result_8chains/node47_6_2.txt 84"
    "./result_8chains/node47_7_0.txt 83"
    "./result_8chains/node47_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
