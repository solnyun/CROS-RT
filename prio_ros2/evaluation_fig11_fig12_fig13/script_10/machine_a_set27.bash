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
ros2 run evaluation_3_randomdag uunifast_node -n node27_0_2 -p 166 -st topic27_0_1 -pt None -u 0.04564045907168446 > ./result_10chains/node27_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_1_2 -p 224 -st topic27_1_1 -pt None -u 0.024236325087214294 > ./result_10chains/node27_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_2_2 -p 304 -st topic27_2_1 -pt None -u 0.0022656735356044178 > ./result_10chains/node27_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_3_2 -p 331 -st topic27_3_1 -pt None -u 0.028357231221811274 > ./result_10chains/node27_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_4_2 -p 357 -st topic27_4_1 -pt None -u 0.023372941787446838 > ./result_10chains/node27_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_5_2 -p 648 -st topic27_5_1 -pt None -u 0.005887479489233016 > ./result_10chains/node27_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_6_2 -p 654 -st topic27_6_1 -pt None -u 0.006470914067265077 > ./result_10chains/node27_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_7_2 -p 682 -st topic27_7_1 -pt None -u 0.01767025829758298 > ./result_10chains/node27_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_8_2 -p 745 -st topic27_8_1 -pt None -u 0.004431992539948054 > ./result_10chains/node27_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_9_2 -p 851 -st topic27_9_1 -pt None -u 9.859983186248274e-05 > ./result_10chains/node27_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_0_0 -p 166 -st none -pt topic27_0_0 -u 0.004977618090827862 > ./result_10chains/node27_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_1_0 -p 224 -st none -pt topic27_1_0 -u 0.06134203408296668 > ./result_10chains/node27_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_2_0 -p 304 -st none -pt topic27_2_0 -u 0.014906866893373338 > ./result_10chains/node27_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_3_0 -p 331 -st none -pt topic27_3_0 -u 0.030423413297748447 > ./result_10chains/node27_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_4_0 -p 357 -st none -pt topic27_4_0 -u 0.0023904415276548574 > ./result_10chains/node27_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_5_0 -p 648 -st none -pt topic27_5_0 -u 0.020662272394891934 > ./result_10chains/node27_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_6_0 -p 654 -st none -pt topic27_6_0 -u 0.0007796060075522249 > ./result_10chains/node27_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_7_0 -p 682 -st none -pt topic27_7_0 -u 0.01109087200972797 > ./result_10chains/node27_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node27_8_0 -p 745 -st none -pt topic27_8_0 -u 0.004744619297960342 > ./result_10chains/node27_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node27_9_0 -p 851 -st none -pt topic27_9_0 -u 0.013188715164203973 > ./result_10chains/node27_9_0.txt &
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
    "./result_10chains/node27_0_0.txt 90"
    "./result_10chains/node27_0_2.txt 90"
    "./result_10chains/node27_1_0.txt 89"
    "./result_10chains/node27_1_2.txt 89"
    "./result_10chains/node27_2_0.txt 88"
    "./result_10chains/node27_2_2.txt 88"
    "./result_10chains/node27_3_0.txt 87"
    "./result_10chains/node27_3_2.txt 87"
    "./result_10chains/node27_4_0.txt 86"
    "./result_10chains/node27_4_2.txt 86"
    "./result_10chains/node27_5_0.txt 85"
    "./result_10chains/node27_5_2.txt 85"
    "./result_10chains/node27_6_0.txt 84"
    "./result_10chains/node27_6_2.txt 84"
    "./result_10chains/node27_7_0.txt 83"
    "./result_10chains/node27_7_2.txt 83"
    "./result_10chains/node27_8_0.txt 82"
    "./result_10chains/node27_8_2.txt 82"
    "./result_10chains/node27_9_0.txt 81"
    "./result_10chains/node27_9_2.txt 81"
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
