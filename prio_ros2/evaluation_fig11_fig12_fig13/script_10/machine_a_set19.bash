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
ros2 run evaluation_3_randomdag uunifast_node -n node19_0_2 -p 105 -st topic19_0_1 -pt None -u 0.03204757684389303 > ./result_10chains/node19_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_1_2 -p 159 -st topic19_1_1 -pt None -u 0.03610247319591847 > ./result_10chains/node19_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_2_2 -p 227 -st topic19_2_1 -pt None -u 0.015478918311205125 > ./result_10chains/node19_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_3_2 -p 424 -st topic19_3_1 -pt None -u 0.026474221496308847 > ./result_10chains/node19_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_4_2 -p 486 -st topic19_4_1 -pt None -u 0.00516935976965735 > ./result_10chains/node19_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_5_2 -p 644 -st topic19_5_1 -pt None -u 0.01823546749706098 > ./result_10chains/node19_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_6_2 -p 685 -st topic19_6_1 -pt None -u 0.007046447597639366 > ./result_10chains/node19_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_7_2 -p 693 -st topic19_7_1 -pt None -u 0.0031257915864808944 > ./result_10chains/node19_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_8_2 -p 845 -st topic19_8_1 -pt None -u 0.01429014192633174 > ./result_10chains/node19_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_9_2 -p 926 -st topic19_9_1 -pt None -u 0.013747278603930014 > ./result_10chains/node19_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_0_0 -p 105 -st none -pt topic19_0_0 -u 0.018402989078953547 > ./result_10chains/node19_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_1_0 -p 159 -st none -pt topic19_1_0 -u 0.0031688600140243883 > ./result_10chains/node19_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_2_0 -p 227 -st none -pt topic19_2_0 -u 0.005946008131358371 > ./result_10chains/node19_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_3_0 -p 424 -st none -pt topic19_3_0 -u 0.010284255413123167 > ./result_10chains/node19_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_4_0 -p 486 -st none -pt topic19_4_0 -u 0.02486873606492912 > ./result_10chains/node19_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_5_0 -p 644 -st none -pt topic19_5_0 -u 0.0002917321512058979 > ./result_10chains/node19_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_6_0 -p 685 -st none -pt topic19_6_0 -u 0.008191867877691522 > ./result_10chains/node19_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_7_0 -p 693 -st none -pt topic19_7_0 -u 0.010641835863094334 > ./result_10chains/node19_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_8_0 -p 845 -st none -pt topic19_8_0 -u 0.030872357647517404 > ./result_10chains/node19_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_9_0 -p 926 -st none -pt topic19_9_0 -u 0.03645718834308165 > ./result_10chains/node19_9_0.txt &
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
    "./result_10chains/node19_0_0.txt 90"
    "./result_10chains/node19_0_2.txt 90"
    "./result_10chains/node19_1_0.txt 89"
    "./result_10chains/node19_1_2.txt 89"
    "./result_10chains/node19_2_0.txt 88"
    "./result_10chains/node19_2_2.txt 88"
    "./result_10chains/node19_3_0.txt 87"
    "./result_10chains/node19_3_2.txt 87"
    "./result_10chains/node19_4_0.txt 86"
    "./result_10chains/node19_4_2.txt 86"
    "./result_10chains/node19_5_0.txt 85"
    "./result_10chains/node19_5_2.txt 85"
    "./result_10chains/node19_6_0.txt 84"
    "./result_10chains/node19_6_2.txt 84"
    "./result_10chains/node19_7_0.txt 83"
    "./result_10chains/node19_7_2.txt 83"
    "./result_10chains/node19_8_0.txt 82"
    "./result_10chains/node19_8_2.txt 82"
    "./result_10chains/node19_9_0.txt 81"
    "./result_10chains/node19_9_2.txt 81"
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
