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
ros2 run evaluation_3_randomdag uunifast_node -n node360_0_2 -p 49 -st topic360_0_1 -pt None -u 0.0019002486321434975 > ./result_10chains/node360_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_1_2 -p 151 -st topic360_1_1 -pt None -u 0.014995673903481888 > ./result_10chains/node360_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_2_2 -p 188 -st topic360_2_1 -pt None -u 0.032894934960771116 > ./result_10chains/node360_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_3_2 -p 241 -st topic360_3_1 -pt None -u 0.001994915789172269 > ./result_10chains/node360_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_4_2 -p 387 -st topic360_4_1 -pt None -u 0.019306838854261016 > ./result_10chains/node360_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_5_2 -p 431 -st topic360_5_1 -pt None -u 0.005440562928496179 > ./result_10chains/node360_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_6_2 -p 613 -st topic360_6_1 -pt None -u 0.0129361602322908 > ./result_10chains/node360_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_7_2 -p 716 -st topic360_7_1 -pt None -u 0.028743222055365197 > ./result_10chains/node360_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_8_2 -p 793 -st topic360_8_1 -pt None -u 0.02045232818935233 > ./result_10chains/node360_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_9_2 -p 926 -st topic360_9_1 -pt None -u 0.02700877819261593 > ./result_10chains/node360_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_0_0 -p 49 -st none -pt topic360_0_0 -u 6.842623470260101e-05 > ./result_10chains/node360_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_1_0 -p 151 -st none -pt topic360_1_0 -u 0.029582632711149193 > ./result_10chains/node360_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_2_0 -p 188 -st none -pt topic360_2_0 -u 0.047029914595897115 > ./result_10chains/node360_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_3_0 -p 241 -st none -pt topic360_3_0 -u 0.04270491574287644 > ./result_10chains/node360_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_4_0 -p 387 -st none -pt topic360_4_0 -u 0.04081324810359849 > ./result_10chains/node360_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_5_0 -p 431 -st none -pt topic360_5_0 -u 0.009946104623271501 > ./result_10chains/node360_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_6_0 -p 613 -st none -pt topic360_6_0 -u 0.013257539753385117 > ./result_10chains/node360_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_7_0 -p 716 -st none -pt topic360_7_0 -u 0.0029787520331918116 > ./result_10chains/node360_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_8_0 -p 793 -st none -pt topic360_8_0 -u 0.0025659939375427127 > ./result_10chains/node360_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_9_0 -p 926 -st none -pt topic360_9_0 -u 0.0182728227585744 > ./result_10chains/node360_9_0.txt &
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
    "./result_10chains/node360_0_0.txt 90"
    "./result_10chains/node360_0_2.txt 90"
    "./result_10chains/node360_1_0.txt 89"
    "./result_10chains/node360_1_2.txt 89"
    "./result_10chains/node360_2_0.txt 88"
    "./result_10chains/node360_2_2.txt 88"
    "./result_10chains/node360_3_0.txt 87"
    "./result_10chains/node360_3_2.txt 87"
    "./result_10chains/node360_4_0.txt 86"
    "./result_10chains/node360_4_2.txt 86"
    "./result_10chains/node360_5_0.txt 85"
    "./result_10chains/node360_5_2.txt 85"
    "./result_10chains/node360_6_0.txt 84"
    "./result_10chains/node360_6_2.txt 84"
    "./result_10chains/node360_7_0.txt 83"
    "./result_10chains/node360_7_2.txt 83"
    "./result_10chains/node360_8_0.txt 82"
    "./result_10chains/node360_8_2.txt 82"
    "./result_10chains/node360_9_0.txt 81"
    "./result_10chains/node360_9_2.txt 81"
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
