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
ros2 run evaluation_3_randomdag uunifast_node -n node171_0_2 -p 263 -st topic171_0_1 -pt None -u 0.027037266793063897 > ./result_10chains/node171_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_1_2 -p 376 -st topic171_1_1 -pt None -u 0.00969690638669457 > ./result_10chains/node171_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_2_2 -p 379 -st topic171_2_1 -pt None -u 0.002169695428688001 > ./result_10chains/node171_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_3_2 -p 429 -st topic171_3_1 -pt None -u 0.03523642458927695 > ./result_10chains/node171_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_4_2 -p 580 -st topic171_4_1 -pt None -u 0.011658005357909063 > ./result_10chains/node171_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_5_2 -p 635 -st topic171_5_1 -pt None -u 0.017977168332263038 > ./result_10chains/node171_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_6_2 -p 647 -st topic171_6_1 -pt None -u 0.00041314816625531714 > ./result_10chains/node171_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_7_2 -p 916 -st topic171_7_1 -pt None -u 0.0360825033566599 > ./result_10chains/node171_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_8_2 -p 926 -st topic171_8_1 -pt None -u 0.0007758673129495477 > ./result_10chains/node171_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_9_2 -p 933 -st topic171_9_1 -pt None -u 0.01173697015401383 > ./result_10chains/node171_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_0_0 -p 263 -st none -pt topic171_0_0 -u 0.001205827700387796 > ./result_10chains/node171_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_1_0 -p 376 -st none -pt topic171_1_0 -u 0.02345340989470296 > ./result_10chains/node171_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_2_0 -p 379 -st none -pt topic171_2_0 -u 0.024791476379129262 > ./result_10chains/node171_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_3_0 -p 429 -st none -pt topic171_3_0 -u 0.008629093791421905 > ./result_10chains/node171_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_4_0 -p 580 -st none -pt topic171_4_0 -u 0.0001635914039587738 > ./result_10chains/node171_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_5_0 -p 635 -st none -pt topic171_5_0 -u 0.0526194130749561 > ./result_10chains/node171_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_6_0 -p 647 -st none -pt topic171_6_0 -u 0.02190243246618931 > ./result_10chains/node171_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_7_0 -p 916 -st none -pt topic171_7_0 -u 0.0006699116380338155 > ./result_10chains/node171_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_8_0 -p 926 -st none -pt topic171_8_0 -u 0.022326704436871972 > ./result_10chains/node171_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_9_0 -p 933 -st none -pt topic171_9_0 -u 0.001802220759189621 > ./result_10chains/node171_9_0.txt &
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
    "./result_10chains/node171_0_0.txt 90"
    "./result_10chains/node171_0_2.txt 90"
    "./result_10chains/node171_1_0.txt 89"
    "./result_10chains/node171_1_2.txt 89"
    "./result_10chains/node171_2_0.txt 88"
    "./result_10chains/node171_2_2.txt 88"
    "./result_10chains/node171_3_0.txt 87"
    "./result_10chains/node171_3_2.txt 87"
    "./result_10chains/node171_4_0.txt 86"
    "./result_10chains/node171_4_2.txt 86"
    "./result_10chains/node171_5_0.txt 85"
    "./result_10chains/node171_5_2.txt 85"
    "./result_10chains/node171_6_0.txt 84"
    "./result_10chains/node171_6_2.txt 84"
    "./result_10chains/node171_7_0.txt 83"
    "./result_10chains/node171_7_2.txt 83"
    "./result_10chains/node171_8_0.txt 82"
    "./result_10chains/node171_8_2.txt 82"
    "./result_10chains/node171_9_0.txt 81"
    "./result_10chains/node171_9_2.txt 81"
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
