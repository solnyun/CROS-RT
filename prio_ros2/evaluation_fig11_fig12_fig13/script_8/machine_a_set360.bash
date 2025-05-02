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
ros2 run evaluation_3_randomdag uunifast_node -n node360_0_2 -p 76 -st topic360_0_1 -pt None -u 0.026362226727388194 > ./result_8chains/node360_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_1_2 -p 88 -st topic360_1_1 -pt None -u 0.013224804275791924 > ./result_8chains/node360_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_2_2 -p 619 -st topic360_2_1 -pt None -u 0.0026843497701768415 > ./result_8chains/node360_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_3_2 -p 644 -st topic360_3_1 -pt None -u 0.006427574865864122 > ./result_8chains/node360_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_4_2 -p 716 -st topic360_4_1 -pt None -u 0.004500647518540263 > ./result_8chains/node360_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_5_2 -p 718 -st topic360_5_1 -pt None -u 0.00038009961836904527 > ./result_8chains/node360_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_6_2 -p 853 -st topic360_6_1 -pt None -u 0.02162534722297111 > ./result_8chains/node360_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_7_2 -p 910 -st topic360_7_1 -pt None -u 0.003047451663561306 > ./result_8chains/node360_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_0_0 -p 76 -st none -pt topic360_0_0 -u 0.010494168702275097 > ./result_8chains/node360_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_1_0 -p 88 -st none -pt topic360_1_0 -u 0.07318636805853285 > ./result_8chains/node360_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_2_0 -p 619 -st none -pt topic360_2_0 -u 0.0007237441027640457 > ./result_8chains/node360_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_3_0 -p 644 -st none -pt topic360_3_0 -u 0.006363766616231448 > ./result_8chains/node360_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_4_0 -p 716 -st none -pt topic360_4_0 -u 0.02584546976121868 > ./result_8chains/node360_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_5_0 -p 718 -st none -pt topic360_5_0 -u 0.008055742198640414 > ./result_8chains/node360_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_6_0 -p 853 -st none -pt topic360_6_0 -u 0.06183805809833641 > ./result_8chains/node360_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_7_0 -p 910 -st none -pt topic360_7_0 -u 0.018473525385149382 > ./result_8chains/node360_7_0.txt &
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
    "./result_8chains/node360_0_0.txt 90"
    "./result_8chains/node360_0_2.txt 90"
    "./result_8chains/node360_1_0.txt 89"
    "./result_8chains/node360_1_2.txt 89"
    "./result_8chains/node360_2_0.txt 88"
    "./result_8chains/node360_2_2.txt 88"
    "./result_8chains/node360_3_0.txt 87"
    "./result_8chains/node360_3_2.txt 87"
    "./result_8chains/node360_4_0.txt 86"
    "./result_8chains/node360_4_2.txt 86"
    "./result_8chains/node360_5_0.txt 85"
    "./result_8chains/node360_5_2.txt 85"
    "./result_8chains/node360_6_0.txt 84"
    "./result_8chains/node360_6_2.txt 84"
    "./result_8chains/node360_7_0.txt 83"
    "./result_8chains/node360_7_2.txt 83"
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
