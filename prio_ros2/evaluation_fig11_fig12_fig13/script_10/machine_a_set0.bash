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
ros2 run evaluation_3_randomdag uunifast_node -n node0_0_2 -p 107 -st topic0_0_1 -pt None -u 0.01829663964299738 > ./result_10chains/node0_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_1_2 -p 112 -st topic0_1_1 -pt None -u 0.036507055981475356 > ./result_10chains/node0_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_2_2 -p 160 -st topic0_2_1 -pt None -u 0.01757948218860561 > ./result_10chains/node0_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_3_2 -p 462 -st topic0_3_1 -pt None -u 0.019094048469341346 > ./result_10chains/node0_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_4_2 -p 473 -st topic0_4_1 -pt None -u 0.017391168201319696 > ./result_10chains/node0_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_5_2 -p 484 -st topic0_5_1 -pt None -u 0.0020214202874421355 > ./result_10chains/node0_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_6_2 -p 501 -st topic0_6_1 -pt None -u 0.015770660260932726 > ./result_10chains/node0_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_7_2 -p 777 -st topic0_7_1 -pt None -u 0.004014424033659314 > ./result_10chains/node0_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_8_2 -p 842 -st topic0_8_1 -pt None -u 0.0030265320195196586 > ./result_10chains/node0_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_9_2 -p 999 -st topic0_9_1 -pt None -u 0.007308926493173412 > ./result_10chains/node0_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_0_0 -p 107 -st none -pt topic0_0_0 -u 0.03477156290478273 > ./result_10chains/node0_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_1_0 -p 112 -st none -pt topic0_1_0 -u 0.006933927255478478 > ./result_10chains/node0_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_2_0 -p 160 -st none -pt topic0_2_0 -u 0.05042562139614193 > ./result_10chains/node0_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_3_0 -p 462 -st none -pt topic0_3_0 -u 0.03664958562398185 > ./result_10chains/node0_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_4_0 -p 473 -st none -pt topic0_4_0 -u 0.005928693399470719 > ./result_10chains/node0_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_5_0 -p 484 -st none -pt topic0_5_0 -u 0.005788413890971095 > ./result_10chains/node0_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_6_0 -p 501 -st none -pt topic0_6_0 -u 0.006677818529954596 > ./result_10chains/node0_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_7_0 -p 777 -st none -pt topic0_7_0 -u 0.007336438742071114 > ./result_10chains/node0_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_8_0 -p 842 -st none -pt topic0_8_0 -u 0.013872923697472145 > ./result_10chains/node0_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_9_0 -p 999 -st none -pt topic0_9_0 -u 0.00801561969581565 > ./result_10chains/node0_9_0.txt &
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
    "./result_10chains/node0_0_0.txt 90"
    "./result_10chains/node0_0_2.txt 90"
    "./result_10chains/node0_1_0.txt 89"
    "./result_10chains/node0_1_2.txt 89"
    "./result_10chains/node0_2_0.txt 88"
    "./result_10chains/node0_2_2.txt 88"
    "./result_10chains/node0_3_0.txt 87"
    "./result_10chains/node0_3_2.txt 87"
    "./result_10chains/node0_4_0.txt 86"
    "./result_10chains/node0_4_2.txt 86"
    "./result_10chains/node0_5_0.txt 85"
    "./result_10chains/node0_5_2.txt 85"
    "./result_10chains/node0_6_0.txt 84"
    "./result_10chains/node0_6_2.txt 84"
    "./result_10chains/node0_7_0.txt 83"
    "./result_10chains/node0_7_2.txt 83"
    "./result_10chains/node0_8_0.txt 82"
    "./result_10chains/node0_8_2.txt 82"
    "./result_10chains/node0_9_0.txt 81"
    "./result_10chains/node0_9_2.txt 81"
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
