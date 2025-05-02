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
ros2 run evaluation_3_randomdag uunifast_node -n node428_0_2 -p 275 -st topic428_0_1 -pt None -u 5.153224621345931e-05 > ./result_8chains/node428_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_1_2 -p 361 -st topic428_1_1 -pt None -u 0.0052365612071881285 > ./result_8chains/node428_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_2_2 -p 466 -st topic428_2_1 -pt None -u 0.0307291331364683 > ./result_8chains/node428_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_3_2 -p 837 -st topic428_3_1 -pt None -u 0.0018167569062485511 > ./result_8chains/node428_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_4_2 -p 857 -st topic428_4_1 -pt None -u 0.0033892302325249923 > ./result_8chains/node428_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_5_2 -p 860 -st topic428_5_1 -pt None -u 0.056141725184331887 > ./result_8chains/node428_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_6_2 -p 922 -st topic428_6_1 -pt None -u 0.003091311338386804 > ./result_8chains/node428_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_7_2 -p 953 -st topic428_7_1 -pt None -u 0.027361641422945737 > ./result_8chains/node428_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_0_0 -p 275 -st none -pt topic428_0_0 -u 0.020441773164302512 > ./result_8chains/node428_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_1_0 -p 361 -st none -pt topic428_1_0 -u 0.013742132551063324 > ./result_8chains/node428_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_2_0 -p 466 -st none -pt topic428_2_0 -u 0.023340874748785545 > ./result_8chains/node428_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_3_0 -p 837 -st none -pt topic428_3_0 -u 0.031613451291757744 > ./result_8chains/node428_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_4_0 -p 857 -st none -pt topic428_4_0 -u 0.032646831785906716 > ./result_8chains/node428_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_5_0 -p 860 -st none -pt topic428_5_0 -u 0.02413496297669257 > ./result_8chains/node428_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node428_6_0 -p 922 -st none -pt topic428_6_0 -u 0.004770596597249377 > ./result_8chains/node428_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node428_7_0 -p 953 -st none -pt topic428_7_0 -u 0.008917049307537353 > ./result_8chains/node428_7_0.txt &
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
    "./result_8chains/node428_0_0.txt 90"
    "./result_8chains/node428_0_2.txt 90"
    "./result_8chains/node428_1_0.txt 89"
    "./result_8chains/node428_1_2.txt 89"
    "./result_8chains/node428_2_0.txt 88"
    "./result_8chains/node428_2_2.txt 88"
    "./result_8chains/node428_3_0.txt 87"
    "./result_8chains/node428_3_2.txt 87"
    "./result_8chains/node428_4_0.txt 86"
    "./result_8chains/node428_4_2.txt 86"
    "./result_8chains/node428_5_0.txt 85"
    "./result_8chains/node428_5_2.txt 85"
    "./result_8chains/node428_6_0.txt 84"
    "./result_8chains/node428_6_2.txt 84"
    "./result_8chains/node428_7_0.txt 83"
    "./result_8chains/node428_7_2.txt 83"
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
