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
ros2 run evaluation_3_randomdag uunifast_node -n node442_0_2 -p 255 -st topic442_0_1 -pt None -u 0.006845612224859354 > ./result_10chains/node442_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_1_2 -p 459 -st topic442_1_1 -pt None -u 0.013751705265929948 > ./result_10chains/node442_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_2_2 -p 630 -st topic442_2_1 -pt None -u 0.029483283570080343 > ./result_10chains/node442_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_3_2 -p 645 -st topic442_3_1 -pt None -u 0.009280215603508224 > ./result_10chains/node442_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_4_2 -p 666 -st topic442_4_1 -pt None -u 0.02256520335526585 > ./result_10chains/node442_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_5_2 -p 812 -st topic442_5_1 -pt None -u 0.010221647352132296 > ./result_10chains/node442_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_6_2 -p 860 -st topic442_6_1 -pt None -u 0.022129680313812267 > ./result_10chains/node442_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_7_2 -p 886 -st topic442_7_1 -pt None -u 0.05129205647452913 > ./result_10chains/node442_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_8_2 -p 976 -st topic442_8_1 -pt None -u 0.029630435475508886 > ./result_10chains/node442_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_9_2 -p 999 -st topic442_9_1 -pt None -u 0.008841526571070665 > ./result_10chains/node442_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_0_0 -p 255 -st none -pt topic442_0_0 -u 0.013569264127871239 > ./result_10chains/node442_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_1_0 -p 459 -st none -pt topic442_1_0 -u 0.006209026650749683 > ./result_10chains/node442_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_2_0 -p 630 -st none -pt topic442_2_0 -u 0.008509510018075261 > ./result_10chains/node442_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_3_0 -p 645 -st none -pt topic442_3_0 -u 0.0013392476056364178 > ./result_10chains/node442_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_4_0 -p 666 -st none -pt topic442_4_0 -u 0.018198091819812856 > ./result_10chains/node442_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_5_0 -p 812 -st none -pt topic442_5_0 -u 0.01628987756448963 > ./result_10chains/node442_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_6_0 -p 860 -st none -pt topic442_6_0 -u 0.04109598285225108 > ./result_10chains/node442_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_7_0 -p 886 -st none -pt topic442_7_0 -u 0.0004144241166456064 > ./result_10chains/node442_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node442_8_0 -p 976 -st none -pt topic442_8_0 -u 0.00852217880816121 > ./result_10chains/node442_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node442_9_0 -p 999 -st none -pt topic442_9_0 -u 0.004891209239246817 > ./result_10chains/node442_9_0.txt &
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
    "./result_10chains/node442_0_0.txt 90"
    "./result_10chains/node442_0_2.txt 90"
    "./result_10chains/node442_1_0.txt 89"
    "./result_10chains/node442_1_2.txt 89"
    "./result_10chains/node442_2_0.txt 88"
    "./result_10chains/node442_2_2.txt 88"
    "./result_10chains/node442_3_0.txt 87"
    "./result_10chains/node442_3_2.txt 87"
    "./result_10chains/node442_4_0.txt 86"
    "./result_10chains/node442_4_2.txt 86"
    "./result_10chains/node442_5_0.txt 85"
    "./result_10chains/node442_5_2.txt 85"
    "./result_10chains/node442_6_0.txt 84"
    "./result_10chains/node442_6_2.txt 84"
    "./result_10chains/node442_7_0.txt 83"
    "./result_10chains/node442_7_2.txt 83"
    "./result_10chains/node442_8_0.txt 82"
    "./result_10chains/node442_8_2.txt 82"
    "./result_10chains/node442_9_0.txt 81"
    "./result_10chains/node442_9_2.txt 81"
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
