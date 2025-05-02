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
ros2 run evaluation_3_randomdag uunifast_node -n node346_0_2 -p 87 -st topic346_0_1 -pt None -u 0.00210742998028024 > ./result_8chains/node346_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_1_2 -p 109 -st topic346_1_1 -pt None -u 0.005152369498475529 > ./result_8chains/node346_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_2_2 -p 332 -st topic346_2_1 -pt None -u 0.0015294328009149982 > ./result_8chains/node346_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_3_2 -p 427 -st topic346_3_1 -pt None -u 0.005297844567231813 > ./result_8chains/node346_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_4_2 -p 587 -st topic346_4_1 -pt None -u 0.02044007972213202 > ./result_8chains/node346_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_5_2 -p 745 -st topic346_5_1 -pt None -u 0.03561402025347765 > ./result_8chains/node346_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_6_2 -p 839 -st topic346_6_1 -pt None -u 0.004037925592646888 > ./result_8chains/node346_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_7_2 -p 959 -st topic346_7_1 -pt None -u 0.03963247457289851 > ./result_8chains/node346_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_0_0 -p 87 -st none -pt topic346_0_0 -u 0.10002686813611561 > ./result_8chains/node346_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_1_0 -p 109 -st none -pt topic346_1_0 -u 0.009269215171810286 > ./result_8chains/node346_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_2_0 -p 332 -st none -pt topic346_2_0 -u 0.0032526607252277295 > ./result_8chains/node346_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_3_0 -p 427 -st none -pt topic346_3_0 -u 0.03885596271642394 > ./result_8chains/node346_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_4_0 -p 587 -st none -pt topic346_4_0 -u 0.036804028254057375 > ./result_8chains/node346_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_5_0 -p 745 -st none -pt topic346_5_0 -u 0.02370697629394261 > ./result_8chains/node346_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node346_6_0 -p 839 -st none -pt topic346_6_0 -u 0.027008532339180158 > ./result_8chains/node346_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node346_7_0 -p 959 -st none -pt topic346_7_0 -u 0.01419651494637561 > ./result_8chains/node346_7_0.txt &
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
    "./result_8chains/node346_0_0.txt 90"
    "./result_8chains/node346_0_2.txt 90"
    "./result_8chains/node346_1_0.txt 89"
    "./result_8chains/node346_1_2.txt 89"
    "./result_8chains/node346_2_0.txt 88"
    "./result_8chains/node346_2_2.txt 88"
    "./result_8chains/node346_3_0.txt 87"
    "./result_8chains/node346_3_2.txt 87"
    "./result_8chains/node346_4_0.txt 86"
    "./result_8chains/node346_4_2.txt 86"
    "./result_8chains/node346_5_0.txt 85"
    "./result_8chains/node346_5_2.txt 85"
    "./result_8chains/node346_6_0.txt 84"
    "./result_8chains/node346_6_2.txt 84"
    "./result_8chains/node346_7_0.txt 83"
    "./result_8chains/node346_7_2.txt 83"
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
