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
ros2 run evaluation_3_randomdag uunifast_node -n node496_0_2 -p 76 -st topic496_0_1 -pt None -u 0.021506229949080746 > ./result_10chains/node496_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_1_2 -p 114 -st topic496_1_1 -pt None -u 0.027683925056317338 > ./result_10chains/node496_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_2_2 -p 196 -st topic496_2_1 -pt None -u 0.00725623942742365 > ./result_10chains/node496_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_3_2 -p 241 -st topic496_3_1 -pt None -u 0.011403282376777513 > ./result_10chains/node496_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_4_2 -p 438 -st topic496_4_1 -pt None -u 0.07666226045580557 > ./result_10chains/node496_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_5_2 -p 578 -st topic496_5_1 -pt None -u 0.006316856272731375 > ./result_10chains/node496_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_6_2 -p 711 -st topic496_6_1 -pt None -u 0.004059622254788203 > ./result_10chains/node496_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_7_2 -p 731 -st topic496_7_1 -pt None -u 0.01476963503941929 > ./result_10chains/node496_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_8_2 -p 780 -st topic496_8_1 -pt None -u 0.038655709926134534 > ./result_10chains/node496_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_9_2 -p 996 -st topic496_9_1 -pt None -u 0.001344019343568332 > ./result_10chains/node496_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_0_0 -p 76 -st none -pt topic496_0_0 -u 0.014222391391716993 > ./result_10chains/node496_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_1_0 -p 114 -st none -pt topic496_1_0 -u 0.021264798474068425 > ./result_10chains/node496_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_2_0 -p 196 -st none -pt topic496_2_0 -u 0.02667738860174884 > ./result_10chains/node496_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_3_0 -p 241 -st none -pt topic496_3_0 -u 0.01896349882811932 > ./result_10chains/node496_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_4_0 -p 438 -st none -pt topic496_4_0 -u 0.0012426719980002665 > ./result_10chains/node496_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_5_0 -p 578 -st none -pt topic496_5_0 -u 0.0009771485709142713 > ./result_10chains/node496_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_6_0 -p 711 -st none -pt topic496_6_0 -u 0.0038827943935013653 > ./result_10chains/node496_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_7_0 -p 731 -st none -pt topic496_7_0 -u 0.013403014878048514 > ./result_10chains/node496_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_8_0 -p 780 -st none -pt topic496_8_0 -u 0.040433396980670853 > ./result_10chains/node496_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_9_0 -p 996 -st none -pt topic496_9_0 -u 0.000665342838328524 > ./result_10chains/node496_9_0.txt &
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
    "./result_10chains/node496_0_0.txt 90"
    "./result_10chains/node496_0_2.txt 90"
    "./result_10chains/node496_1_0.txt 89"
    "./result_10chains/node496_1_2.txt 89"
    "./result_10chains/node496_2_0.txt 88"
    "./result_10chains/node496_2_2.txt 88"
    "./result_10chains/node496_3_0.txt 87"
    "./result_10chains/node496_3_2.txt 87"
    "./result_10chains/node496_4_0.txt 86"
    "./result_10chains/node496_4_2.txt 86"
    "./result_10chains/node496_5_0.txt 85"
    "./result_10chains/node496_5_2.txt 85"
    "./result_10chains/node496_6_0.txt 84"
    "./result_10chains/node496_6_2.txt 84"
    "./result_10chains/node496_7_0.txt 83"
    "./result_10chains/node496_7_2.txt 83"
    "./result_10chains/node496_8_0.txt 82"
    "./result_10chains/node496_8_2.txt 82"
    "./result_10chains/node496_9_0.txt 81"
    "./result_10chains/node496_9_2.txt 81"
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
