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
ros2 run evaluation_3_randomdag uunifast_node -n node160_0_2 -p 146 -st topic160_0_1 -pt None -u 0.0002897919890597622 > ./result_10chains/node160_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_1_2 -p 254 -st topic160_1_1 -pt None -u 0.016952455043250936 > ./result_10chains/node160_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_2_2 -p 271 -st topic160_2_1 -pt None -u 0.0003742412306963483 > ./result_10chains/node160_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_3_2 -p 302 -st topic160_3_1 -pt None -u 0.0036342674576133605 > ./result_10chains/node160_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_4_2 -p 323 -st topic160_4_1 -pt None -u 0.01698390237165953 > ./result_10chains/node160_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_5_2 -p 342 -st topic160_5_1 -pt None -u 0.025872374510671592 > ./result_10chains/node160_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_6_2 -p 353 -st topic160_6_1 -pt None -u 0.036542869495108515 > ./result_10chains/node160_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_7_2 -p 485 -st topic160_7_1 -pt None -u 0.006133155485611358 > ./result_10chains/node160_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_8_2 -p 643 -st topic160_8_1 -pt None -u 0.025882546004414732 > ./result_10chains/node160_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_9_2 -p 883 -st topic160_9_1 -pt None -u 0.007858532004730313 > ./result_10chains/node160_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_0_0 -p 146 -st none -pt topic160_0_0 -u 0.005982202929208702 > ./result_10chains/node160_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_1_0 -p 254 -st none -pt topic160_1_0 -u 0.01370452324424809 > ./result_10chains/node160_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_2_0 -p 271 -st none -pt topic160_2_0 -u 0.008465229481797842 > ./result_10chains/node160_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_3_0 -p 302 -st none -pt topic160_3_0 -u 0.015822832833714884 > ./result_10chains/node160_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_4_0 -p 323 -st none -pt topic160_4_0 -u 0.009065758774736588 > ./result_10chains/node160_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_5_0 -p 342 -st none -pt topic160_5_0 -u 0.02108542647419892 > ./result_10chains/node160_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_6_0 -p 353 -st none -pt topic160_6_0 -u 0.02692345928351733 > ./result_10chains/node160_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_7_0 -p 485 -st none -pt topic160_7_0 -u 0.003590610934292221 > ./result_10chains/node160_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_8_0 -p 643 -st none -pt topic160_8_0 -u 0.039486625480798704 > ./result_10chains/node160_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_9_0 -p 883 -st none -pt topic160_9_0 -u 0.026066583830307237 > ./result_10chains/node160_9_0.txt &
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
    "./result_10chains/node160_0_0.txt 90"
    "./result_10chains/node160_0_2.txt 90"
    "./result_10chains/node160_1_0.txt 89"
    "./result_10chains/node160_1_2.txt 89"
    "./result_10chains/node160_2_0.txt 88"
    "./result_10chains/node160_2_2.txt 88"
    "./result_10chains/node160_3_0.txt 87"
    "./result_10chains/node160_3_2.txt 87"
    "./result_10chains/node160_4_0.txt 86"
    "./result_10chains/node160_4_2.txt 86"
    "./result_10chains/node160_5_0.txt 85"
    "./result_10chains/node160_5_2.txt 85"
    "./result_10chains/node160_6_0.txt 84"
    "./result_10chains/node160_6_2.txt 84"
    "./result_10chains/node160_7_0.txt 83"
    "./result_10chains/node160_7_2.txt 83"
    "./result_10chains/node160_8_0.txt 82"
    "./result_10chains/node160_8_2.txt 82"
    "./result_10chains/node160_9_0.txt 81"
    "./result_10chains/node160_9_2.txt 81"
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
