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
ros2 run evaluation_3_randomdag uunifast_node -n node191_0_2 -p 17 -st topic191_0_1 -pt None -u 0.001209328772321161 > ./result_10chains/node191_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_1_2 -p 18 -st topic191_1_1 -pt None -u 0.03735381063140725 > ./result_10chains/node191_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_2_2 -p 68 -st topic191_2_1 -pt None -u 0.0035373845412626226 > ./result_10chains/node191_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_3_2 -p 136 -st topic191_3_1 -pt None -u 0.06218464255838929 > ./result_10chains/node191_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_4_2 -p 257 -st topic191_4_1 -pt None -u 0.02583057446043277 > ./result_10chains/node191_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_5_2 -p 318 -st topic191_5_1 -pt None -u 0.035028568392489884 > ./result_10chains/node191_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_6_2 -p 387 -st topic191_6_1 -pt None -u 0.019011985649879937 > ./result_10chains/node191_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_7_2 -p 498 -st topic191_7_1 -pt None -u 0.009897614978168809 > ./result_10chains/node191_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_8_2 -p 844 -st topic191_8_1 -pt None -u 0.020800159095024404 > ./result_10chains/node191_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_9_2 -p 871 -st topic191_9_1 -pt None -u 0.01320252077824778 > ./result_10chains/node191_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_0_0 -p 17 -st none -pt topic191_0_0 -u 0.02191723533899781 > ./result_10chains/node191_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_1_0 -p 18 -st none -pt topic191_1_0 -u 0.01219639277982576 > ./result_10chains/node191_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_2_0 -p 68 -st none -pt topic191_2_0 -u 0.008460853474493046 > ./result_10chains/node191_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_3_0 -p 136 -st none -pt topic191_3_0 -u 0.014276337675131423 > ./result_10chains/node191_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_4_0 -p 257 -st none -pt topic191_4_0 -u 0.04677668136614016 > ./result_10chains/node191_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_5_0 -p 318 -st none -pt topic191_5_0 -u 0.01748953872465811 > ./result_10chains/node191_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_6_0 -p 387 -st none -pt topic191_6_0 -u 0.003994427314237242 > ./result_10chains/node191_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_7_0 -p 498 -st none -pt topic191_7_0 -u 0.01078457732041646 > ./result_10chains/node191_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_8_0 -p 844 -st none -pt topic191_8_0 -u 0.005740132090937711 > ./result_10chains/node191_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_9_0 -p 871 -st none -pt topic191_9_0 -u 0.028576931137152504 > ./result_10chains/node191_9_0.txt &
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
    "./result_10chains/node191_0_0.txt 90"
    "./result_10chains/node191_0_2.txt 90"
    "./result_10chains/node191_1_0.txt 89"
    "./result_10chains/node191_1_2.txt 89"
    "./result_10chains/node191_2_0.txt 88"
    "./result_10chains/node191_2_2.txt 88"
    "./result_10chains/node191_3_0.txt 87"
    "./result_10chains/node191_3_2.txt 87"
    "./result_10chains/node191_4_0.txt 86"
    "./result_10chains/node191_4_2.txt 86"
    "./result_10chains/node191_5_0.txt 85"
    "./result_10chains/node191_5_2.txt 85"
    "./result_10chains/node191_6_0.txt 84"
    "./result_10chains/node191_6_2.txt 84"
    "./result_10chains/node191_7_0.txt 83"
    "./result_10chains/node191_7_2.txt 83"
    "./result_10chains/node191_8_0.txt 82"
    "./result_10chains/node191_8_2.txt 82"
    "./result_10chains/node191_9_0.txt 81"
    "./result_10chains/node191_9_2.txt 81"
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
