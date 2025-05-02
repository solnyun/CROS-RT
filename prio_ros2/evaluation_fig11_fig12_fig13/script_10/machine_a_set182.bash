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
ros2 run evaluation_3_randomdag uunifast_node -n node182_0_2 -p 73 -st topic182_0_1 -pt None -u 0.006226770910419843 > ./result_10chains/node182_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_1_2 -p 333 -st topic182_1_1 -pt None -u 0.009266465182437178 > ./result_10chains/node182_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_2_2 -p 341 -st topic182_2_1 -pt None -u 0.001858759159734269 > ./result_10chains/node182_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_3_2 -p 414 -st topic182_3_1 -pt None -u 0.0018026130325280443 > ./result_10chains/node182_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_4_2 -p 552 -st topic182_4_1 -pt None -u 0.028234520663898477 > ./result_10chains/node182_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_5_2 -p 710 -st topic182_5_1 -pt None -u 0.0220906058999914 > ./result_10chains/node182_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_6_2 -p 736 -st topic182_6_1 -pt None -u 0.016738986312236664 > ./result_10chains/node182_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_7_2 -p 928 -st topic182_7_1 -pt None -u 0.0058663385935571605 > ./result_10chains/node182_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_8_2 -p 976 -st topic182_8_1 -pt None -u 0.006623299787064635 > ./result_10chains/node182_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_9_2 -p 982 -st topic182_9_1 -pt None -u 0.001733005339211452 > ./result_10chains/node182_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_0_0 -p 73 -st none -pt topic182_0_0 -u 0.006994117955741841 > ./result_10chains/node182_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_1_0 -p 333 -st none -pt topic182_1_0 -u 0.010299506715609363 > ./result_10chains/node182_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_2_0 -p 341 -st none -pt topic182_2_0 -u 0.003970778353803217 > ./result_10chains/node182_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_3_0 -p 414 -st none -pt topic182_3_0 -u 0.028576706403149243 > ./result_10chains/node182_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_4_0 -p 552 -st none -pt topic182_4_0 -u 0.031155453785767118 > ./result_10chains/node182_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_5_0 -p 710 -st none -pt topic182_5_0 -u 0.010222753080938424 > ./result_10chains/node182_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_6_0 -p 736 -st none -pt topic182_6_0 -u 0.0016169976956273147 > ./result_10chains/node182_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_7_0 -p 928 -st none -pt topic182_7_0 -u 0.020986956092766726 > ./result_10chains/node182_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_8_0 -p 976 -st none -pt topic182_8_0 -u 0.006988452149927535 > ./result_10chains/node182_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_9_0 -p 982 -st none -pt topic182_9_0 -u 0.03676518464698347 > ./result_10chains/node182_9_0.txt &
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
    "./result_10chains/node182_0_0.txt 90"
    "./result_10chains/node182_0_2.txt 90"
    "./result_10chains/node182_1_0.txt 89"
    "./result_10chains/node182_1_2.txt 89"
    "./result_10chains/node182_2_0.txt 88"
    "./result_10chains/node182_2_2.txt 88"
    "./result_10chains/node182_3_0.txt 87"
    "./result_10chains/node182_3_2.txt 87"
    "./result_10chains/node182_4_0.txt 86"
    "./result_10chains/node182_4_2.txt 86"
    "./result_10chains/node182_5_0.txt 85"
    "./result_10chains/node182_5_2.txt 85"
    "./result_10chains/node182_6_0.txt 84"
    "./result_10chains/node182_6_2.txt 84"
    "./result_10chains/node182_7_0.txt 83"
    "./result_10chains/node182_7_2.txt 83"
    "./result_10chains/node182_8_0.txt 82"
    "./result_10chains/node182_8_2.txt 82"
    "./result_10chains/node182_9_0.txt 81"
    "./result_10chains/node182_9_2.txt 81"
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
