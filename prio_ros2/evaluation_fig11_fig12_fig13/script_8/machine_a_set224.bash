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
ros2 run evaluation_3_randomdag uunifast_node -n node224_0_2 -p 491 -st topic224_0_1 -pt None -u 0.010950090923995903 > ./result_8chains/node224_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_1_2 -p 512 -st topic224_1_1 -pt None -u 0.026123524775276685 > ./result_8chains/node224_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_2_2 -p 563 -st topic224_2_1 -pt None -u 0.004952297973078834 > ./result_8chains/node224_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_3_2 -p 565 -st topic224_3_1 -pt None -u 0.02510955744157789 > ./result_8chains/node224_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_4_2 -p 671 -st topic224_4_1 -pt None -u 0.014046463128650433 > ./result_8chains/node224_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_5_2 -p 692 -st topic224_5_1 -pt None -u 0.024759426167016457 > ./result_8chains/node224_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_6_2 -p 834 -st topic224_6_1 -pt None -u 0.01563212412114648 > ./result_8chains/node224_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_7_2 -p 930 -st topic224_7_1 -pt None -u 0.024651232199953556 > ./result_8chains/node224_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_0_0 -p 491 -st none -pt topic224_0_0 -u 0.016186879322557246 > ./result_8chains/node224_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_1_0 -p 512 -st none -pt topic224_1_0 -u 0.0372912877649188 > ./result_8chains/node224_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_2_0 -p 563 -st none -pt topic224_2_0 -u 0.019495865797787615 > ./result_8chains/node224_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_3_0 -p 565 -st none -pt topic224_3_0 -u 0.038509354644116645 > ./result_8chains/node224_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_4_0 -p 671 -st none -pt topic224_4_0 -u 0.016082453431360944 > ./result_8chains/node224_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_5_0 -p 692 -st none -pt topic224_5_0 -u 0.01169582189707416 > ./result_8chains/node224_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_6_0 -p 834 -st none -pt topic224_6_0 -u 0.012827462038739162 > ./result_8chains/node224_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_7_0 -p 930 -st none -pt topic224_7_0 -u 0.10680792240083997 > ./result_8chains/node224_7_0.txt &
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
    "./result_8chains/node224_0_0.txt 90"
    "./result_8chains/node224_0_2.txt 90"
    "./result_8chains/node224_1_0.txt 89"
    "./result_8chains/node224_1_2.txt 89"
    "./result_8chains/node224_2_0.txt 88"
    "./result_8chains/node224_2_2.txt 88"
    "./result_8chains/node224_3_0.txt 87"
    "./result_8chains/node224_3_2.txt 87"
    "./result_8chains/node224_4_0.txt 86"
    "./result_8chains/node224_4_2.txt 86"
    "./result_8chains/node224_5_0.txt 85"
    "./result_8chains/node224_5_2.txt 85"
    "./result_8chains/node224_6_0.txt 84"
    "./result_8chains/node224_6_2.txt 84"
    "./result_8chains/node224_7_0.txt 83"
    "./result_8chains/node224_7_2.txt 83"
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
