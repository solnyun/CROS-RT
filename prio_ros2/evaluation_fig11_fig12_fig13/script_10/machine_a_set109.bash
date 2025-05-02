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
ros2 run evaluation_3_randomdag uunifast_node -n node109_0_2 -p 36 -st topic109_0_1 -pt None -u 0.010953451512639878 > ./result_10chains/node109_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_1_2 -p 79 -st topic109_1_1 -pt None -u 0.006384019974201627 > ./result_10chains/node109_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_2_2 -p 131 -st topic109_2_1 -pt None -u 2.8429591851952818e-05 > ./result_10chains/node109_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_3_2 -p 240 -st topic109_3_1 -pt None -u 0.011597946460651543 > ./result_10chains/node109_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_4_2 -p 397 -st topic109_4_1 -pt None -u 0.0080746914115703 > ./result_10chains/node109_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_5_2 -p 410 -st topic109_5_1 -pt None -u 0.009001202885335097 > ./result_10chains/node109_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_6_2 -p 411 -st topic109_6_1 -pt None -u 0.009537964197712162 > ./result_10chains/node109_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_7_2 -p 547 -st topic109_7_1 -pt None -u 0.008240287158861173 > ./result_10chains/node109_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_8_2 -p 884 -st topic109_8_1 -pt None -u 0.006269473275516663 > ./result_10chains/node109_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_9_2 -p 967 -st topic109_9_1 -pt None -u 0.01735736992022695 > ./result_10chains/node109_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_0_0 -p 36 -st none -pt topic109_0_0 -u 0.034596492807092094 > ./result_10chains/node109_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_1_0 -p 79 -st none -pt topic109_1_0 -u 0.04029140829008193 > ./result_10chains/node109_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_2_0 -p 131 -st none -pt topic109_2_0 -u 0.0034982989756738303 > ./result_10chains/node109_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_3_0 -p 240 -st none -pt topic109_3_0 -u 0.05152932951358802 > ./result_10chains/node109_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_4_0 -p 397 -st none -pt topic109_4_0 -u 0.02559214521627423 > ./result_10chains/node109_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_5_0 -p 410 -st none -pt topic109_5_0 -u 0.028132222611331414 > ./result_10chains/node109_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_6_0 -p 411 -st none -pt topic109_6_0 -u 0.01462723958046161 > ./result_10chains/node109_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_7_0 -p 547 -st none -pt topic109_7_0 -u 0.00903767290590013 > ./result_10chains/node109_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node109_8_0 -p 884 -st none -pt topic109_8_0 -u 0.019085241962277733 > ./result_10chains/node109_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node109_9_0 -p 967 -st none -pt topic109_9_0 -u 0.04987164342414592 > ./result_10chains/node109_9_0.txt &
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
    "./result_10chains/node109_0_0.txt 90"
    "./result_10chains/node109_0_2.txt 90"
    "./result_10chains/node109_1_0.txt 89"
    "./result_10chains/node109_1_2.txt 89"
    "./result_10chains/node109_2_0.txt 88"
    "./result_10chains/node109_2_2.txt 88"
    "./result_10chains/node109_3_0.txt 87"
    "./result_10chains/node109_3_2.txt 87"
    "./result_10chains/node109_4_0.txt 86"
    "./result_10chains/node109_4_2.txt 86"
    "./result_10chains/node109_5_0.txt 85"
    "./result_10chains/node109_5_2.txt 85"
    "./result_10chains/node109_6_0.txt 84"
    "./result_10chains/node109_6_2.txt 84"
    "./result_10chains/node109_7_0.txt 83"
    "./result_10chains/node109_7_2.txt 83"
    "./result_10chains/node109_8_0.txt 82"
    "./result_10chains/node109_8_2.txt 82"
    "./result_10chains/node109_9_0.txt 81"
    "./result_10chains/node109_9_2.txt 81"
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
