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
ros2 run evaluation_3_randomdag uunifast_node -n node115_0_2 -p 33 -st topic115_0_1 -pt None -u 0.06534285997863992 > ./result_8chains/node115_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_1_2 -p 228 -st topic115_1_1 -pt None -u 0.004617071137743345 > ./result_8chains/node115_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_2_2 -p 278 -st topic115_2_1 -pt None -u 0.005083002996614933 > ./result_8chains/node115_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_3_2 -p 313 -st topic115_3_1 -pt None -u 0.010075547712221217 > ./result_8chains/node115_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_4_2 -p 496 -st topic115_4_1 -pt None -u 0.022076726386582146 > ./result_8chains/node115_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_5_2 -p 770 -st topic115_5_1 -pt None -u 0.002894841406626429 > ./result_8chains/node115_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_6_2 -p 968 -st topic115_6_1 -pt None -u 0.0048182430721726704 > ./result_8chains/node115_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_7_2 -p 981 -st topic115_7_1 -pt None -u 0.0037636103823033918 > ./result_8chains/node115_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_0_0 -p 33 -st none -pt topic115_0_0 -u 0.09222849944660944 > ./result_8chains/node115_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_1_0 -p 228 -st none -pt topic115_1_0 -u 0.003152294851572479 > ./result_8chains/node115_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_2_0 -p 278 -st none -pt topic115_2_0 -u 0.020212293261011677 > ./result_8chains/node115_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_3_0 -p 313 -st none -pt topic115_3_0 -u 0.0016018026136713215 > ./result_8chains/node115_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_4_0 -p 496 -st none -pt topic115_4_0 -u 0.01760153772081688 > ./result_8chains/node115_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_5_0 -p 770 -st none -pt topic115_5_0 -u 0.014774263126780651 > ./result_8chains/node115_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_6_0 -p 968 -st none -pt topic115_6_0 -u 0.009067507136578674 > ./result_8chains/node115_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_7_0 -p 981 -st none -pt topic115_7_0 -u 0.0038227984213762833 > ./result_8chains/node115_7_0.txt &
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
    "./result_8chains/node115_0_0.txt 90"
    "./result_8chains/node115_0_2.txt 90"
    "./result_8chains/node115_1_0.txt 89"
    "./result_8chains/node115_1_2.txt 89"
    "./result_8chains/node115_2_0.txt 88"
    "./result_8chains/node115_2_2.txt 88"
    "./result_8chains/node115_3_0.txt 87"
    "./result_8chains/node115_3_2.txt 87"
    "./result_8chains/node115_4_0.txt 86"
    "./result_8chains/node115_4_2.txt 86"
    "./result_8chains/node115_5_0.txt 85"
    "./result_8chains/node115_5_2.txt 85"
    "./result_8chains/node115_6_0.txt 84"
    "./result_8chains/node115_6_2.txt 84"
    "./result_8chains/node115_7_0.txt 83"
    "./result_8chains/node115_7_2.txt 83"
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
