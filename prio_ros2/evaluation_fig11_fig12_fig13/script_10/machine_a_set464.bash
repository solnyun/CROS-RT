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
ros2 run evaluation_3_randomdag uunifast_node -n node464_0_2 -p 130 -st topic464_0_1 -pt None -u 0.030708719944710916 > ./result_10chains/node464_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_1_2 -p 162 -st topic464_1_1 -pt None -u 0.001300195832261597 > ./result_10chains/node464_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_2_2 -p 185 -st topic464_2_1 -pt None -u 0.005413834549893859 > ./result_10chains/node464_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_3_2 -p 428 -st topic464_3_1 -pt None -u 0.012896985799079053 > ./result_10chains/node464_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_4_2 -p 672 -st topic464_4_1 -pt None -u 0.007246768395082426 > ./result_10chains/node464_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_5_2 -p 763 -st topic464_5_1 -pt None -u 0.00615329716557661 > ./result_10chains/node464_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_6_2 -p 808 -st topic464_6_1 -pt None -u 0.02517110898459704 > ./result_10chains/node464_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_7_2 -p 962 -st topic464_7_1 -pt None -u 0.004010112404121691 > ./result_10chains/node464_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_8_2 -p 973 -st topic464_8_1 -pt None -u 0.014862220593971881 > ./result_10chains/node464_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_9_2 -p 988 -st topic464_9_1 -pt None -u 0.017267076910747328 > ./result_10chains/node464_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_0_0 -p 130 -st none -pt topic464_0_0 -u 0.0014201699629265985 > ./result_10chains/node464_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_1_0 -p 162 -st none -pt topic464_1_0 -u 0.015852331422200883 > ./result_10chains/node464_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_2_0 -p 185 -st none -pt topic464_2_0 -u 0.0195893523681554 > ./result_10chains/node464_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_3_0 -p 428 -st none -pt topic464_3_0 -u 0.031762104447969064 > ./result_10chains/node464_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_4_0 -p 672 -st none -pt topic464_4_0 -u 0.000885297400974483 > ./result_10chains/node464_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_5_0 -p 763 -st none -pt topic464_5_0 -u 0.03338015175211939 > ./result_10chains/node464_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_6_0 -p 808 -st none -pt topic464_6_0 -u 0.035512769031484315 > ./result_10chains/node464_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_7_0 -p 962 -st none -pt topic464_7_0 -u 0.0023199810443260693 > ./result_10chains/node464_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_8_0 -p 973 -st none -pt topic464_8_0 -u 0.02462991092871969 > ./result_10chains/node464_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node464_9_0 -p 988 -st none -pt topic464_9_0 -u 0.0559470897964761 > ./result_10chains/node464_9_0.txt &
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
    "./result_10chains/node464_0_0.txt 90"
    "./result_10chains/node464_0_2.txt 90"
    "./result_10chains/node464_1_0.txt 89"
    "./result_10chains/node464_1_2.txt 89"
    "./result_10chains/node464_2_0.txt 88"
    "./result_10chains/node464_2_2.txt 88"
    "./result_10chains/node464_3_0.txt 87"
    "./result_10chains/node464_3_2.txt 87"
    "./result_10chains/node464_4_0.txt 86"
    "./result_10chains/node464_4_2.txt 86"
    "./result_10chains/node464_5_0.txt 85"
    "./result_10chains/node464_5_2.txt 85"
    "./result_10chains/node464_6_0.txt 84"
    "./result_10chains/node464_6_2.txt 84"
    "./result_10chains/node464_7_0.txt 83"
    "./result_10chains/node464_7_2.txt 83"
    "./result_10chains/node464_8_0.txt 82"
    "./result_10chains/node464_8_2.txt 82"
    "./result_10chains/node464_9_0.txt 81"
    "./result_10chains/node464_9_2.txt 81"
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
