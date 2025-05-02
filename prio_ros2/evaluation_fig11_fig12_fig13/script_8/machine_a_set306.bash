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
ros2 run evaluation_3_randomdag uunifast_node -n node306_0_2 -p 109 -st topic306_0_1 -pt None -u 0.04017640638132425 > ./result_8chains/node306_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_1_2 -p 314 -st topic306_1_1 -pt None -u 0.026410283309406812 > ./result_8chains/node306_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_2_2 -p 348 -st topic306_2_1 -pt None -u 0.017278578174344972 > ./result_8chains/node306_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_3_2 -p 513 -st topic306_3_1 -pt None -u 0.005607982624944219 > ./result_8chains/node306_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_4_2 -p 650 -st topic306_4_1 -pt None -u 0.016310640315364222 > ./result_8chains/node306_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_5_2 -p 749 -st topic306_5_1 -pt None -u 0.01739013057060429 > ./result_8chains/node306_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_6_2 -p 802 -st topic306_6_1 -pt None -u 0.050294000828583055 > ./result_8chains/node306_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_7_2 -p 976 -st topic306_7_1 -pt None -u 0.0060116363809919054 > ./result_8chains/node306_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_0_0 -p 109 -st none -pt topic306_0_0 -u 0.012063337329791979 > ./result_8chains/node306_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_1_0 -p 314 -st none -pt topic306_1_0 -u 0.007038247103081041 > ./result_8chains/node306_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_2_0 -p 348 -st none -pt topic306_2_0 -u 0.013232925088106251 > ./result_8chains/node306_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_3_0 -p 513 -st none -pt topic306_3_0 -u 0.0173059990159401 > ./result_8chains/node306_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_4_0 -p 650 -st none -pt topic306_4_0 -u 0.0038921114770253395 > ./result_8chains/node306_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_5_0 -p 749 -st none -pt topic306_5_0 -u 0.039133775801779486 > ./result_8chains/node306_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node306_6_0 -p 802 -st none -pt topic306_6_0 -u 0.02034544243785187 > ./result_8chains/node306_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node306_7_0 -p 976 -st none -pt topic306_7_0 -u 0.018263650335057453 > ./result_8chains/node306_7_0.txt &
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
    "./result_8chains/node306_0_0.txt 90"
    "./result_8chains/node306_0_2.txt 90"
    "./result_8chains/node306_1_0.txt 89"
    "./result_8chains/node306_1_2.txt 89"
    "./result_8chains/node306_2_0.txt 88"
    "./result_8chains/node306_2_2.txt 88"
    "./result_8chains/node306_3_0.txt 87"
    "./result_8chains/node306_3_2.txt 87"
    "./result_8chains/node306_4_0.txt 86"
    "./result_8chains/node306_4_2.txt 86"
    "./result_8chains/node306_5_0.txt 85"
    "./result_8chains/node306_5_2.txt 85"
    "./result_8chains/node306_6_0.txt 84"
    "./result_8chains/node306_6_2.txt 84"
    "./result_8chains/node306_7_0.txt 83"
    "./result_8chains/node306_7_2.txt 83"
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
