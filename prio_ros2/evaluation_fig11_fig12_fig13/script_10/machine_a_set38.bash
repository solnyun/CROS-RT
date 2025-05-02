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
ros2 run evaluation_3_randomdag uunifast_node -n node38_0_2 -p 68 -st topic38_0_1 -pt None -u 0.0796574829854888 > ./result_10chains/node38_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_1_2 -p 195 -st topic38_1_1 -pt None -u 0.0062243981708390295 > ./result_10chains/node38_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_2_2 -p 222 -st topic38_2_1 -pt None -u 0.009208553286777998 > ./result_10chains/node38_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_3_2 -p 286 -st topic38_3_1 -pt None -u 0.02522632886564652 > ./result_10chains/node38_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_4_2 -p 599 -st topic38_4_1 -pt None -u 0.04071617721132681 > ./result_10chains/node38_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_5_2 -p 623 -st topic38_5_1 -pt None -u 0.022191272316635924 > ./result_10chains/node38_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_6_2 -p 635 -st topic38_6_1 -pt None -u 0.007187549761974998 > ./result_10chains/node38_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_7_2 -p 852 -st topic38_7_1 -pt None -u 0.021891355035488183 > ./result_10chains/node38_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_8_2 -p 878 -st topic38_8_1 -pt None -u 0.007125857897203346 > ./result_10chains/node38_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_9_2 -p 997 -st topic38_9_1 -pt None -u 0.031015993021173003 > ./result_10chains/node38_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_0_0 -p 68 -st none -pt topic38_0_0 -u 0.008253474589092313 > ./result_10chains/node38_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_1_0 -p 195 -st none -pt topic38_1_0 -u 0.0025165916965246837 > ./result_10chains/node38_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_2_0 -p 222 -st none -pt topic38_2_0 -u 0.001103552993482193 > ./result_10chains/node38_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_3_0 -p 286 -st none -pt topic38_3_0 -u 0.027237739366502922 > ./result_10chains/node38_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_4_0 -p 599 -st none -pt topic38_4_0 -u 0.01259008889526908 > ./result_10chains/node38_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_5_0 -p 623 -st none -pt topic38_5_0 -u 0.011002269210116877 > ./result_10chains/node38_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_6_0 -p 635 -st none -pt topic38_6_0 -u 0.054727746053855664 > ./result_10chains/node38_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_7_0 -p 852 -st none -pt topic38_7_0 -u 0.006814239947286305 > ./result_10chains/node38_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node38_8_0 -p 878 -st none -pt topic38_8_0 -u 0.010237276507302745 > ./result_10chains/node38_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node38_9_0 -p 997 -st none -pt topic38_9_0 -u 0.019429344326187266 > ./result_10chains/node38_9_0.txt &
sleep 10
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
    "./result_10chains/node38_0_0.txt 90"
    "./result_10chains/node38_0_2.txt 90"
    "./result_10chains/node38_1_0.txt 89"
    "./result_10chains/node38_1_2.txt 89"
    "./result_10chains/node38_2_0.txt 88"
    "./result_10chains/node38_2_2.txt 88"
    "./result_10chains/node38_3_0.txt 87"
    "./result_10chains/node38_3_2.txt 87"
    "./result_10chains/node38_4_0.txt 86"
    "./result_10chains/node38_4_2.txt 86"
    "./result_10chains/node38_5_0.txt 85"
    "./result_10chains/node38_5_2.txt 85"
    "./result_10chains/node38_6_0.txt 84"
    "./result_10chains/node38_6_2.txt 84"
    "./result_10chains/node38_7_0.txt 83"
    "./result_10chains/node38_7_2.txt 83"
    "./result_10chains/node38_8_0.txt 82"
    "./result_10chains/node38_8_2.txt 82"
    "./result_10chains/node38_9_0.txt 81"
    "./result_10chains/node38_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
