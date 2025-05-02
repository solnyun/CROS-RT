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
ros2 run evaluation_3_randomdag uunifast_node -n node106_0_2 -p 54 -st topic106_0_1 -pt None -u 0.00212889712138975 > ./result_8chains/node106_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_1_2 -p 393 -st topic106_1_1 -pt None -u 0.012935960842008376 > ./result_8chains/node106_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_2_2 -p 493 -st topic106_2_1 -pt None -u 0.017269863427648025 > ./result_8chains/node106_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_3_2 -p 495 -st topic106_3_1 -pt None -u 0.018176535540739003 > ./result_8chains/node106_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_4_2 -p 714 -st topic106_4_1 -pt None -u 0.018602687290344727 > ./result_8chains/node106_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_5_2 -p 857 -st topic106_5_1 -pt None -u 0.04513349929600306 > ./result_8chains/node106_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_6_2 -p 889 -st topic106_6_1 -pt None -u 0.0016586526469555378 > ./result_8chains/node106_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_7_2 -p 916 -st topic106_7_1 -pt None -u 0.0031865192777099155 > ./result_8chains/node106_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_0_0 -p 54 -st none -pt topic106_0_0 -u 0.037826677949925 > ./result_8chains/node106_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_1_0 -p 393 -st none -pt topic106_1_0 -u 0.010720938885904197 > ./result_8chains/node106_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_2_0 -p 493 -st none -pt topic106_2_0 -u 0.03675283625848724 > ./result_8chains/node106_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_3_0 -p 495 -st none -pt topic106_3_0 -u 0.0010401819937160828 > ./result_8chains/node106_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_4_0 -p 714 -st none -pt topic106_4_0 -u 0.024617784126485465 > ./result_8chains/node106_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_5_0 -p 857 -st none -pt topic106_5_0 -u 0.008075908862008513 > ./result_8chains/node106_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_6_0 -p 889 -st none -pt topic106_6_0 -u 0.037105501787511944 > ./result_8chains/node106_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_7_0 -p 916 -st none -pt topic106_7_0 -u 0.010028121792074726 > ./result_8chains/node106_7_0.txt &
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
    "./result_8chains/node106_0_0.txt 90"
    "./result_8chains/node106_0_2.txt 90"
    "./result_8chains/node106_1_0.txt 89"
    "./result_8chains/node106_1_2.txt 89"
    "./result_8chains/node106_2_0.txt 88"
    "./result_8chains/node106_2_2.txt 88"
    "./result_8chains/node106_3_0.txt 87"
    "./result_8chains/node106_3_2.txt 87"
    "./result_8chains/node106_4_0.txt 86"
    "./result_8chains/node106_4_2.txt 86"
    "./result_8chains/node106_5_0.txt 85"
    "./result_8chains/node106_5_2.txt 85"
    "./result_8chains/node106_6_0.txt 84"
    "./result_8chains/node106_6_2.txt 84"
    "./result_8chains/node106_7_0.txt 83"
    "./result_8chains/node106_7_2.txt 83"
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
