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
ros2 run evaluation_3_randomdag uunifast_node -n node348_0_2 -p 95 -st topic348_0_1 -pt None -u 0.0021393865697166836 > ./result_6chains/node348_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_1_2 -p 180 -st topic348_1_1 -pt None -u 0.02220756455982681 > ./result_6chains/node348_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_2_2 -p 293 -st topic348_2_1 -pt None -u 0.008277925379895856 > ./result_6chains/node348_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_3_2 -p 399 -st topic348_3_1 -pt None -u 0.001609678523625535 > ./result_6chains/node348_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_4_2 -p 671 -st topic348_4_1 -pt None -u 0.022109485458253808 > ./result_6chains/node348_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_5_2 -p 740 -st topic348_5_1 -pt None -u 0.02785746759317594 > ./result_6chains/node348_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_0_0 -p 95 -st none -pt topic348_0_0 -u 0.026993459028389344 > ./result_6chains/node348_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_1_0 -p 180 -st none -pt topic348_1_0 -u 0.015910201168583993 > ./result_6chains/node348_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_2_0 -p 293 -st none -pt topic348_2_0 -u 0.00581876422924632 > ./result_6chains/node348_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_3_0 -p 399 -st none -pt topic348_3_0 -u 0.031534720014626316 > ./result_6chains/node348_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_4_0 -p 671 -st none -pt topic348_4_0 -u 0.010858347223177772 > ./result_6chains/node348_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_5_0 -p 740 -st none -pt topic348_5_0 -u 0.12084971047224935 > ./result_6chains/node348_5_0.txt &
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
    "./result_6chains/node348_0_0.txt 90"
    "./result_6chains/node348_0_2.txt 90"
    "./result_6chains/node348_1_0.txt 89"
    "./result_6chains/node348_1_2.txt 89"
    "./result_6chains/node348_2_0.txt 88"
    "./result_6chains/node348_2_2.txt 88"
    "./result_6chains/node348_3_0.txt 87"
    "./result_6chains/node348_3_2.txt 87"
    "./result_6chains/node348_4_0.txt 86"
    "./result_6chains/node348_4_2.txt 86"
    "./result_6chains/node348_5_0.txt 85"
    "./result_6chains/node348_5_2.txt 85"
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
