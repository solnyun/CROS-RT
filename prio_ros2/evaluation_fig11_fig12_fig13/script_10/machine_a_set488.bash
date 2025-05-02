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
ros2 run evaluation_3_randomdag uunifast_node -n node488_0_2 -p 67 -st topic488_0_1 -pt None -u 0.025363845530093965 > ./result_10chains/node488_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_1_2 -p 80 -st topic488_1_1 -pt None -u 0.0046517082677202115 > ./result_10chains/node488_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_2_2 -p 115 -st topic488_2_1 -pt None -u 0.019538500976835016 > ./result_10chains/node488_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_3_2 -p 188 -st topic488_3_1 -pt None -u 0.038726562795575126 > ./result_10chains/node488_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_4_2 -p 405 -st topic488_4_1 -pt None -u 0.009505904537138204 > ./result_10chains/node488_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_5_2 -p 727 -st topic488_5_1 -pt None -u 0.005601765642224171 > ./result_10chains/node488_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_6_2 -p 764 -st topic488_6_1 -pt None -u 0.013819824276575715 > ./result_10chains/node488_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_7_2 -p 785 -st topic488_7_1 -pt None -u 0.021630813984207117 > ./result_10chains/node488_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_8_2 -p 860 -st topic488_8_1 -pt None -u 0.022493186961054113 > ./result_10chains/node488_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_9_2 -p 979 -st topic488_9_1 -pt None -u 0.007627956949010792 > ./result_10chains/node488_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_0_0 -p 67 -st none -pt topic488_0_0 -u 0.0024677451151525753 > ./result_10chains/node488_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_1_0 -p 80 -st none -pt topic488_1_0 -u 0.012005822029737045 > ./result_10chains/node488_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_2_0 -p 115 -st none -pt topic488_2_0 -u 0.028076385666195747 > ./result_10chains/node488_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_3_0 -p 188 -st none -pt topic488_3_0 -u 0.0015402361569158418 > ./result_10chains/node488_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_4_0 -p 405 -st none -pt topic488_4_0 -u 0.013651788632947137 > ./result_10chains/node488_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_5_0 -p 727 -st none -pt topic488_5_0 -u 0.0018277480865177553 > ./result_10chains/node488_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_6_0 -p 764 -st none -pt topic488_6_0 -u 0.0009307868408304498 > ./result_10chains/node488_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_7_0 -p 785 -st none -pt topic488_7_0 -u 0.04233527346244481 > ./result_10chains/node488_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_8_0 -p 860 -st none -pt topic488_8_0 -u 0.014429226484689334 > ./result_10chains/node488_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_9_0 -p 979 -st none -pt topic488_9_0 -u 0.0076770930863654194 > ./result_10chains/node488_9_0.txt &
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
    "./result_10chains/node488_0_0.txt 90"
    "./result_10chains/node488_0_2.txt 90"
    "./result_10chains/node488_1_0.txt 89"
    "./result_10chains/node488_1_2.txt 89"
    "./result_10chains/node488_2_0.txt 88"
    "./result_10chains/node488_2_2.txt 88"
    "./result_10chains/node488_3_0.txt 87"
    "./result_10chains/node488_3_2.txt 87"
    "./result_10chains/node488_4_0.txt 86"
    "./result_10chains/node488_4_2.txt 86"
    "./result_10chains/node488_5_0.txt 85"
    "./result_10chains/node488_5_2.txt 85"
    "./result_10chains/node488_6_0.txt 84"
    "./result_10chains/node488_6_2.txt 84"
    "./result_10chains/node488_7_0.txt 83"
    "./result_10chains/node488_7_2.txt 83"
    "./result_10chains/node488_8_0.txt 82"
    "./result_10chains/node488_8_2.txt 82"
    "./result_10chains/node488_9_0.txt 81"
    "./result_10chains/node488_9_2.txt 81"
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
