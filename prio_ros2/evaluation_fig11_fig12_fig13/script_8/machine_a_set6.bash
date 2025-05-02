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
ros2 run evaluation_3_randomdag uunifast_node -n node6_0_2 -p 21 -st topic6_0_1 -pt None -u 0.03281815810090949 > ./result_8chains/node6_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_1_2 -p 59 -st topic6_1_1 -pt None -u 0.04052681989948037 > ./result_8chains/node6_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_2_2 -p 260 -st topic6_2_1 -pt None -u 0.03655525592708103 > ./result_8chains/node6_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_3_2 -p 273 -st topic6_3_1 -pt None -u 0.004503210772824756 > ./result_8chains/node6_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_4_2 -p 322 -st topic6_4_1 -pt None -u 0.008503840330917029 > ./result_8chains/node6_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_5_2 -p 506 -st topic6_5_1 -pt None -u 0.00044409317398702575 > ./result_8chains/node6_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_6_2 -p 587 -st topic6_6_1 -pt None -u 0.01226142088807139 > ./result_8chains/node6_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_7_2 -p 884 -st topic6_7_1 -pt None -u 0.01580439779787591 > ./result_8chains/node6_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_0_0 -p 21 -st none -pt topic6_0_0 -u 0.0026588428642116413 > ./result_8chains/node6_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_1_0 -p 59 -st none -pt topic6_1_0 -u 0.011966097041515522 > ./result_8chains/node6_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_2_0 -p 260 -st none -pt topic6_2_0 -u 0.010474771709830466 > ./result_8chains/node6_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_3_0 -p 273 -st none -pt topic6_3_0 -u 0.011100699057704333 > ./result_8chains/node6_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_4_0 -p 322 -st none -pt topic6_4_0 -u 0.003621119064199485 > ./result_8chains/node6_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_5_0 -p 506 -st none -pt topic6_5_0 -u 0.0014502779316043213 > ./result_8chains/node6_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_6_0 -p 587 -st none -pt topic6_6_0 -u 0.018966902882561823 > ./result_8chains/node6_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_7_0 -p 884 -st none -pt topic6_7_0 -u 0.01117827213646054 > ./result_8chains/node6_7_0.txt &
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
    "./result_8chains/node6_0_0.txt 90"
    "./result_8chains/node6_0_2.txt 90"
    "./result_8chains/node6_1_0.txt 89"
    "./result_8chains/node6_1_2.txt 89"
    "./result_8chains/node6_2_0.txt 88"
    "./result_8chains/node6_2_2.txt 88"
    "./result_8chains/node6_3_0.txt 87"
    "./result_8chains/node6_3_2.txt 87"
    "./result_8chains/node6_4_0.txt 86"
    "./result_8chains/node6_4_2.txt 86"
    "./result_8chains/node6_5_0.txt 85"
    "./result_8chains/node6_5_2.txt 85"
    "./result_8chains/node6_6_0.txt 84"
    "./result_8chains/node6_6_2.txt 84"
    "./result_8chains/node6_7_0.txt 83"
    "./result_8chains/node6_7_2.txt 83"
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
