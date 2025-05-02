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
ros2 run evaluation_3_randomdag uunifast_node -n node204_0_2 -p 66 -st topic204_0_1 -pt None -u 0.007621486069301686 > ./result_10chains/node204_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_1_2 -p 144 -st topic204_1_1 -pt None -u 0.005608048191636683 > ./result_10chains/node204_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_2_2 -p 240 -st topic204_2_1 -pt None -u 0.0006590739352596575 > ./result_10chains/node204_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_3_2 -p 335 -st topic204_3_1 -pt None -u 0.009562039918295184 > ./result_10chains/node204_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_4_2 -p 385 -st topic204_4_1 -pt None -u 0.004793914999352278 > ./result_10chains/node204_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_5_2 -p 407 -st topic204_5_1 -pt None -u 0.01124193985357344 > ./result_10chains/node204_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_6_2 -p 420 -st topic204_6_1 -pt None -u 0.03610385877897124 > ./result_10chains/node204_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_7_2 -p 812 -st topic204_7_1 -pt None -u 0.03127251104318468 > ./result_10chains/node204_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_8_2 -p 879 -st topic204_8_1 -pt None -u 0.03315286883497044 > ./result_10chains/node204_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_9_2 -p 956 -st topic204_9_1 -pt None -u 0.0291753765463233 > ./result_10chains/node204_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_0_0 -p 66 -st none -pt topic204_0_0 -u 0.06277110900892335 > ./result_10chains/node204_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_1_0 -p 144 -st none -pt topic204_1_0 -u 0.021189212713602523 > ./result_10chains/node204_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_2_0 -p 240 -st none -pt topic204_2_0 -u 0.03807823957349665 > ./result_10chains/node204_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_3_0 -p 335 -st none -pt topic204_3_0 -u 0.030538004483168513 > ./result_10chains/node204_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_4_0 -p 385 -st none -pt topic204_4_0 -u 0.02631417193357488 > ./result_10chains/node204_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_5_0 -p 407 -st none -pt topic204_5_0 -u 0.0072371653103783795 > ./result_10chains/node204_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_6_0 -p 420 -st none -pt topic204_6_0 -u 0.0025809039150076207 > ./result_10chains/node204_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_7_0 -p 812 -st none -pt topic204_7_0 -u 0.018663541808240314 > ./result_10chains/node204_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_8_0 -p 879 -st none -pt topic204_8_0 -u 0.01032615273652443 > ./result_10chains/node204_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node204_9_0 -p 956 -st none -pt topic204_9_0 -u 0.004717919761070027 > ./result_10chains/node204_9_0.txt &
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
    "./result_10chains/node204_0_0.txt 90"
    "./result_10chains/node204_0_2.txt 90"
    "./result_10chains/node204_1_0.txt 89"
    "./result_10chains/node204_1_2.txt 89"
    "./result_10chains/node204_2_0.txt 88"
    "./result_10chains/node204_2_2.txt 88"
    "./result_10chains/node204_3_0.txt 87"
    "./result_10chains/node204_3_2.txt 87"
    "./result_10chains/node204_4_0.txt 86"
    "./result_10chains/node204_4_2.txt 86"
    "./result_10chains/node204_5_0.txt 85"
    "./result_10chains/node204_5_2.txt 85"
    "./result_10chains/node204_6_0.txt 84"
    "./result_10chains/node204_6_2.txt 84"
    "./result_10chains/node204_7_0.txt 83"
    "./result_10chains/node204_7_2.txt 83"
    "./result_10chains/node204_8_0.txt 82"
    "./result_10chains/node204_8_2.txt 82"
    "./result_10chains/node204_9_0.txt 81"
    "./result_10chains/node204_9_2.txt 81"
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
