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
ros2 run evaluation_3_randomdag uunifast_node -n node294_0_2 -p 37 -st topic294_0_1 -pt None -u 0.014026262095144848 > ./result_8chains/node294_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_1_2 -p 245 -st topic294_1_1 -pt None -u 0.01603939445279673 > ./result_8chains/node294_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_2_2 -p 264 -st topic294_2_1 -pt None -u 0.0046789907154449195 > ./result_8chains/node294_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_3_2 -p 294 -st topic294_3_1 -pt None -u 0.08360341370809365 > ./result_8chains/node294_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_4_2 -p 349 -st topic294_4_1 -pt None -u 0.014349598907900385 > ./result_8chains/node294_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_5_2 -p 382 -st topic294_5_1 -pt None -u 0.05227679244072675 > ./result_8chains/node294_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_6_2 -p 403 -st topic294_6_1 -pt None -u 0.006854016962363235 > ./result_8chains/node294_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_7_2 -p 894 -st topic294_7_1 -pt None -u 0.0018468487143489549 > ./result_8chains/node294_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_0_0 -p 37 -st none -pt topic294_0_0 -u 0.012885547283113252 > ./result_8chains/node294_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_1_0 -p 245 -st none -pt topic294_1_0 -u 0.015103655956298423 > ./result_8chains/node294_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_2_0 -p 264 -st none -pt topic294_2_0 -u 0.005616099826555976 > ./result_8chains/node294_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_3_0 -p 294 -st none -pt topic294_3_0 -u 0.004234040724489463 > ./result_8chains/node294_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_4_0 -p 349 -st none -pt topic294_4_0 -u 0.03913329817738362 > ./result_8chains/node294_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_5_0 -p 382 -st none -pt topic294_5_0 -u 0.022384290906182824 > ./result_8chains/node294_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_6_0 -p 403 -st none -pt topic294_6_0 -u 0.033975136241543455 > ./result_8chains/node294_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_7_0 -p 894 -st none -pt topic294_7_0 -u 0.0019610309981039327 > ./result_8chains/node294_7_0.txt &
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
    "./result_8chains/node294_0_0.txt 90"
    "./result_8chains/node294_0_2.txt 90"
    "./result_8chains/node294_1_0.txt 89"
    "./result_8chains/node294_1_2.txt 89"
    "./result_8chains/node294_2_0.txt 88"
    "./result_8chains/node294_2_2.txt 88"
    "./result_8chains/node294_3_0.txt 87"
    "./result_8chains/node294_3_2.txt 87"
    "./result_8chains/node294_4_0.txt 86"
    "./result_8chains/node294_4_2.txt 86"
    "./result_8chains/node294_5_0.txt 85"
    "./result_8chains/node294_5_2.txt 85"
    "./result_8chains/node294_6_0.txt 84"
    "./result_8chains/node294_6_2.txt 84"
    "./result_8chains/node294_7_0.txt 83"
    "./result_8chains/node294_7_2.txt 83"
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
