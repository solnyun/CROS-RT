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
ros2 run evaluation_3_randomdag uunifast_node -n node307_0_2 -p 107 -st topic307_0_1 -pt None -u 0.022495125334118293 > ./result_10chains/node307_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_1_2 -p 302 -st topic307_1_1 -pt None -u 0.026680212914813595 > ./result_10chains/node307_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_2_2 -p 352 -st topic307_2_1 -pt None -u 0.0012499091562103715 > ./result_10chains/node307_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_3_2 -p 463 -st topic307_3_1 -pt None -u 0.02131401737118782 > ./result_10chains/node307_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_4_2 -p 652 -st topic307_4_1 -pt None -u 0.015474208671821643 > ./result_10chains/node307_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_5_2 -p 751 -st topic307_5_1 -pt None -u 0.020900871869017235 > ./result_10chains/node307_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_6_2 -p 772 -st topic307_6_1 -pt None -u 0.002358792632633361 > ./result_10chains/node307_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_7_2 -p 844 -st topic307_7_1 -pt None -u 0.030763168769186666 > ./result_10chains/node307_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_8_2 -p 923 -st topic307_8_1 -pt None -u 0.011005828377893823 > ./result_10chains/node307_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_9_2 -p 938 -st topic307_9_1 -pt None -u 0.02805313595343031 > ./result_10chains/node307_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_0_0 -p 107 -st none -pt topic307_0_0 -u 0.005933212132497756 > ./result_10chains/node307_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_1_0 -p 302 -st none -pt topic307_1_0 -u 0.018628924807959857 > ./result_10chains/node307_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_2_0 -p 352 -st none -pt topic307_2_0 -u 0.003213807733030205 > ./result_10chains/node307_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_3_0 -p 463 -st none -pt topic307_3_0 -u 0.0020486348962576173 > ./result_10chains/node307_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_4_0 -p 652 -st none -pt topic307_4_0 -u 0.017393000940618075 > ./result_10chains/node307_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_5_0 -p 751 -st none -pt topic307_5_0 -u 0.0008201457525674472 > ./result_10chains/node307_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_6_0 -p 772 -st none -pt topic307_6_0 -u 0.0046361255731805495 > ./result_10chains/node307_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_7_0 -p 844 -st none -pt topic307_7_0 -u 0.013588959108810389 > ./result_10chains/node307_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node307_8_0 -p 923 -st none -pt topic307_8_0 -u 0.006590082671333014 > ./result_10chains/node307_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node307_9_0 -p 938 -st none -pt topic307_9_0 -u 0.007744066102599735 > ./result_10chains/node307_9_0.txt &
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
    "./result_10chains/node307_0_0.txt 90"
    "./result_10chains/node307_0_2.txt 90"
    "./result_10chains/node307_1_0.txt 89"
    "./result_10chains/node307_1_2.txt 89"
    "./result_10chains/node307_2_0.txt 88"
    "./result_10chains/node307_2_2.txt 88"
    "./result_10chains/node307_3_0.txt 87"
    "./result_10chains/node307_3_2.txt 87"
    "./result_10chains/node307_4_0.txt 86"
    "./result_10chains/node307_4_2.txt 86"
    "./result_10chains/node307_5_0.txt 85"
    "./result_10chains/node307_5_2.txt 85"
    "./result_10chains/node307_6_0.txt 84"
    "./result_10chains/node307_6_2.txt 84"
    "./result_10chains/node307_7_0.txt 83"
    "./result_10chains/node307_7_2.txt 83"
    "./result_10chains/node307_8_0.txt 82"
    "./result_10chains/node307_8_2.txt 82"
    "./result_10chains/node307_9_0.txt 81"
    "./result_10chains/node307_9_2.txt 81"
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
