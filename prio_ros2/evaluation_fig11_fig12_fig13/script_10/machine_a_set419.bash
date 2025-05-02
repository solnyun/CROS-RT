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
ros2 run evaluation_3_randomdag uunifast_node -n node419_0_2 -p 94 -st topic419_0_1 -pt None -u 0.005600228941842977 > ./result_10chains/node419_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_1_2 -p 134 -st topic419_1_1 -pt None -u 0.003167496209005305 > ./result_10chains/node419_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_2_2 -p 155 -st topic419_2_1 -pt None -u 0.06740453143932668 > ./result_10chains/node419_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_3_2 -p 198 -st topic419_3_1 -pt None -u 0.02752727981898928 > ./result_10chains/node419_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_4_2 -p 246 -st topic419_4_1 -pt None -u 0.008486361878531551 > ./result_10chains/node419_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_5_2 -p 266 -st topic419_5_1 -pt None -u 0.0009979982690027367 > ./result_10chains/node419_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_6_2 -p 294 -st topic419_6_1 -pt None -u 0.008148544427932836 > ./result_10chains/node419_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_7_2 -p 416 -st topic419_7_1 -pt None -u 0.08141893500263803 > ./result_10chains/node419_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_8_2 -p 475 -st topic419_8_1 -pt None -u 0.010268173449803405 > ./result_10chains/node419_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_9_2 -p 819 -st topic419_9_1 -pt None -u 0.009724240371294922 > ./result_10chains/node419_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_0_0 -p 94 -st none -pt topic419_0_0 -u 0.041688181931294366 > ./result_10chains/node419_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_1_0 -p 134 -st none -pt topic419_1_0 -u 0.026984491229799623 > ./result_10chains/node419_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_2_0 -p 155 -st none -pt topic419_2_0 -u 0.010941313151807242 > ./result_10chains/node419_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_3_0 -p 198 -st none -pt topic419_3_0 -u 0.0028865076619320473 > ./result_10chains/node419_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_4_0 -p 246 -st none -pt topic419_4_0 -u 0.021600141179664745 > ./result_10chains/node419_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_5_0 -p 266 -st none -pt topic419_5_0 -u 0.0045676619873999125 > ./result_10chains/node419_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_6_0 -p 294 -st none -pt topic419_6_0 -u 0.021704071307779682 > ./result_10chains/node419_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_7_0 -p 416 -st none -pt topic419_7_0 -u 0.017200135212095014 > ./result_10chains/node419_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_8_0 -p 475 -st none -pt topic419_8_0 -u 0.021228724782447583 > ./result_10chains/node419_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_9_0 -p 819 -st none -pt topic419_9_0 -u 0.0019719449378917363 > ./result_10chains/node419_9_0.txt &
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
    "./result_10chains/node419_0_0.txt 90"
    "./result_10chains/node419_0_2.txt 90"
    "./result_10chains/node419_1_0.txt 89"
    "./result_10chains/node419_1_2.txt 89"
    "./result_10chains/node419_2_0.txt 88"
    "./result_10chains/node419_2_2.txt 88"
    "./result_10chains/node419_3_0.txt 87"
    "./result_10chains/node419_3_2.txt 87"
    "./result_10chains/node419_4_0.txt 86"
    "./result_10chains/node419_4_2.txt 86"
    "./result_10chains/node419_5_0.txt 85"
    "./result_10chains/node419_5_2.txt 85"
    "./result_10chains/node419_6_0.txt 84"
    "./result_10chains/node419_6_2.txt 84"
    "./result_10chains/node419_7_0.txt 83"
    "./result_10chains/node419_7_2.txt 83"
    "./result_10chains/node419_8_0.txt 82"
    "./result_10chains/node419_8_2.txt 82"
    "./result_10chains/node419_9_0.txt 81"
    "./result_10chains/node419_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
