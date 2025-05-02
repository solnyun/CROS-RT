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
ros2 run evaluation_3_randomdag uunifast_node -n node298_0_2 -p 62 -st topic298_0_1 -pt None -u 0.07108477939247937 > ./result_8chains/node298_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_1_2 -p 91 -st topic298_1_1 -pt None -u 0.05548673451552083 > ./result_8chains/node298_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_2_2 -p 467 -st topic298_2_1 -pt None -u 0.036032888951404884 > ./result_8chains/node298_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_3_2 -p 496 -st topic298_3_1 -pt None -u 0.0026947307795903153 > ./result_8chains/node298_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_4_2 -p 744 -st topic298_4_1 -pt None -u 0.02193295844861326 > ./result_8chains/node298_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_5_2 -p 831 -st topic298_5_1 -pt None -u 0.05503476058848364 > ./result_8chains/node298_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_6_2 -p 862 -st topic298_6_1 -pt None -u 0.015872261668855303 > ./result_8chains/node298_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_7_2 -p 893 -st topic298_7_1 -pt None -u 0.03940988226105348 > ./result_8chains/node298_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_0_0 -p 62 -st none -pt topic298_0_0 -u 0.002242739591372722 > ./result_8chains/node298_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_1_0 -p 91 -st none -pt topic298_1_0 -u 0.006100203921264202 > ./result_8chains/node298_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_2_0 -p 467 -st none -pt topic298_2_0 -u 0.012554474325335241 > ./result_8chains/node298_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_3_0 -p 496 -st none -pt topic298_3_0 -u 0.00914272546863737 > ./result_8chains/node298_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_4_0 -p 744 -st none -pt topic298_4_0 -u 0.019719458752829322 > ./result_8chains/node298_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_5_0 -p 831 -st none -pt topic298_5_0 -u 0.010240629310153376 > ./result_8chains/node298_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_6_0 -p 862 -st none -pt topic298_6_0 -u 0.04724610556333872 > ./result_8chains/node298_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node298_7_0 -p 893 -st none -pt topic298_7_0 -u 0.03555273687949391 > ./result_8chains/node298_7_0.txt &
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
    "./result_8chains/node298_0_0.txt 90"
    "./result_8chains/node298_0_2.txt 90"
    "./result_8chains/node298_1_0.txt 89"
    "./result_8chains/node298_1_2.txt 89"
    "./result_8chains/node298_2_0.txt 88"
    "./result_8chains/node298_2_2.txt 88"
    "./result_8chains/node298_3_0.txt 87"
    "./result_8chains/node298_3_2.txt 87"
    "./result_8chains/node298_4_0.txt 86"
    "./result_8chains/node298_4_2.txt 86"
    "./result_8chains/node298_5_0.txt 85"
    "./result_8chains/node298_5_2.txt 85"
    "./result_8chains/node298_6_0.txt 84"
    "./result_8chains/node298_6_2.txt 84"
    "./result_8chains/node298_7_0.txt 83"
    "./result_8chains/node298_7_2.txt 83"
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
