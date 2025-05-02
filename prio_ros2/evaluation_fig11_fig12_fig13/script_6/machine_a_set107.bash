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
ros2 run evaluation_3_randomdag uunifast_node -n node107_0_2 -p 300 -st topic107_0_1 -pt None -u 0.002490929758664051 > ./result_6chains/node107_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_1_2 -p 463 -st topic107_1_1 -pt None -u 0.04064868933924204 > ./result_6chains/node107_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_2_2 -p 575 -st topic107_2_1 -pt None -u 0.011931224687593833 > ./result_6chains/node107_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_3_2 -p 630 -st topic107_3_1 -pt None -u 0.021982072900952193 > ./result_6chains/node107_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_4_2 -p 757 -st topic107_4_1 -pt None -u 0.03810559002194311 > ./result_6chains/node107_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_5_2 -p 795 -st topic107_5_1 -pt None -u 0.004280476354130726 > ./result_6chains/node107_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_0_0 -p 300 -st none -pt topic107_0_0 -u 0.018604938576477548 > ./result_6chains/node107_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_1_0 -p 463 -st none -pt topic107_1_0 -u 0.04366878681762232 > ./result_6chains/node107_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_2_0 -p 575 -st none -pt topic107_2_0 -u 0.035851818615060094 > ./result_6chains/node107_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_3_0 -p 630 -st none -pt topic107_3_0 -u 0.03754050462050479 > ./result_6chains/node107_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node107_4_0 -p 757 -st none -pt topic107_4_0 -u 0.03262375099818629 > ./result_6chains/node107_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node107_5_0 -p 795 -st none -pt topic107_5_0 -u 0.005211986811025804 > ./result_6chains/node107_5_0.txt &
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
    "./result_6chains/node107_0_0.txt 90"
    "./result_6chains/node107_0_2.txt 90"
    "./result_6chains/node107_1_0.txt 89"
    "./result_6chains/node107_1_2.txt 89"
    "./result_6chains/node107_2_0.txt 88"
    "./result_6chains/node107_2_2.txt 88"
    "./result_6chains/node107_3_0.txt 87"
    "./result_6chains/node107_3_2.txt 87"
    "./result_6chains/node107_4_0.txt 86"
    "./result_6chains/node107_4_2.txt 86"
    "./result_6chains/node107_5_0.txt 85"
    "./result_6chains/node107_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
