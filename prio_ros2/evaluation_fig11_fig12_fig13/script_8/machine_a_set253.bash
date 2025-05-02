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
ros2 run evaluation_3_randomdag uunifast_node -n node253_0_2 -p 45 -st topic253_0_1 -pt None -u 0.0074633153628467785 > ./result_8chains/node253_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_1_2 -p 121 -st topic253_1_1 -pt None -u 0.005348344810667038 > ./result_8chains/node253_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_2_2 -p 192 -st topic253_2_1 -pt None -u 0.011120111856201431 > ./result_8chains/node253_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_3_2 -p 394 -st topic253_3_1 -pt None -u 0.014735179578539787 > ./result_8chains/node253_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_4_2 -p 479 -st topic253_4_1 -pt None -u 0.058018493705542615 > ./result_8chains/node253_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_5_2 -p 596 -st topic253_5_1 -pt None -u 0.0004351439330786133 > ./result_8chains/node253_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_6_2 -p 746 -st topic253_6_1 -pt None -u 0.024650981468433156 > ./result_8chains/node253_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_7_2 -p 839 -st topic253_7_1 -pt None -u 0.013979245780024152 > ./result_8chains/node253_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_0_0 -p 45 -st none -pt topic253_0_0 -u 0.023283073259523168 > ./result_8chains/node253_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_1_0 -p 121 -st none -pt topic253_1_0 -u 0.007742401232749607 > ./result_8chains/node253_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_2_0 -p 192 -st none -pt topic253_2_0 -u 0.026492274738614263 > ./result_8chains/node253_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_3_0 -p 394 -st none -pt topic253_3_0 -u 0.02496851559836788 > ./result_8chains/node253_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_4_0 -p 479 -st none -pt topic253_4_0 -u 0.0392965868993613 > ./result_8chains/node253_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_5_0 -p 596 -st none -pt topic253_5_0 -u 0.0011160749379387769 > ./result_8chains/node253_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_6_0 -p 746 -st none -pt topic253_6_0 -u 0.013160391966761248 > ./result_8chains/node253_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node253_7_0 -p 839 -st none -pt topic253_7_0 -u 0.005541284705206956 > ./result_8chains/node253_7_0.txt &
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
    "./result_8chains/node253_0_0.txt 90"
    "./result_8chains/node253_0_2.txt 90"
    "./result_8chains/node253_1_0.txt 89"
    "./result_8chains/node253_1_2.txt 89"
    "./result_8chains/node253_2_0.txt 88"
    "./result_8chains/node253_2_2.txt 88"
    "./result_8chains/node253_3_0.txt 87"
    "./result_8chains/node253_3_2.txt 87"
    "./result_8chains/node253_4_0.txt 86"
    "./result_8chains/node253_4_2.txt 86"
    "./result_8chains/node253_5_0.txt 85"
    "./result_8chains/node253_5_2.txt 85"
    "./result_8chains/node253_6_0.txt 84"
    "./result_8chains/node253_6_2.txt 84"
    "./result_8chains/node253_7_0.txt 83"
    "./result_8chains/node253_7_2.txt 83"
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
