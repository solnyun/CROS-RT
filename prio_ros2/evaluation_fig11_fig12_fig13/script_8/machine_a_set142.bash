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
ros2 run evaluation_3_randomdag uunifast_node -n node142_0_2 -p 269 -st topic142_0_1 -pt None -u 0.018505660563018833 > ./result_8chains/node142_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_1_2 -p 270 -st topic142_1_1 -pt None -u 0.014470219517790706 > ./result_8chains/node142_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_2_2 -p 304 -st topic142_2_1 -pt None -u 0.027210216840427015 > ./result_8chains/node142_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_3_2 -p 351 -st topic142_3_1 -pt None -u 0.0030913240153376265 > ./result_8chains/node142_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_4_2 -p 556 -st topic142_4_1 -pt None -u 0.001534003046743948 > ./result_8chains/node142_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_5_2 -p 861 -st topic142_5_1 -pt None -u 0.06165511139861393 > ./result_8chains/node142_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_6_2 -p 918 -st topic142_6_1 -pt None -u 0.0037128721486274913 > ./result_8chains/node142_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_7_2 -p 967 -st topic142_7_1 -pt None -u 0.025511865250360137 > ./result_8chains/node142_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_0_0 -p 269 -st none -pt topic142_0_0 -u 0.035852514604658936 > ./result_8chains/node142_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_1_0 -p 270 -st none -pt topic142_1_0 -u 0.00025194306415299295 > ./result_8chains/node142_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_2_0 -p 304 -st none -pt topic142_2_0 -u 0.03891998683840481 > ./result_8chains/node142_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_3_0 -p 351 -st none -pt topic142_3_0 -u 0.01792659387632206 > ./result_8chains/node142_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_4_0 -p 556 -st none -pt topic142_4_0 -u 0.0029562420099182307 > ./result_8chains/node142_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_5_0 -p 861 -st none -pt topic142_5_0 -u 0.02746215980513228 > ./result_8chains/node142_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_6_0 -p 918 -st none -pt topic142_6_0 -u 0.00033799916074186975 > ./result_8chains/node142_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node142_7_0 -p 967 -st none -pt topic142_7_0 -u 0.04990046020388916 > ./result_8chains/node142_7_0.txt &
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
    "./result_8chains/node142_0_0.txt 90"
    "./result_8chains/node142_0_2.txt 90"
    "./result_8chains/node142_1_0.txt 89"
    "./result_8chains/node142_1_2.txt 89"
    "./result_8chains/node142_2_0.txt 88"
    "./result_8chains/node142_2_2.txt 88"
    "./result_8chains/node142_3_0.txt 87"
    "./result_8chains/node142_3_2.txt 87"
    "./result_8chains/node142_4_0.txt 86"
    "./result_8chains/node142_4_2.txt 86"
    "./result_8chains/node142_5_0.txt 85"
    "./result_8chains/node142_5_2.txt 85"
    "./result_8chains/node142_6_0.txt 84"
    "./result_8chains/node142_6_2.txt 84"
    "./result_8chains/node142_7_0.txt 83"
    "./result_8chains/node142_7_2.txt 83"
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
