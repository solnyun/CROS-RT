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
ros2 run evaluation_3_randomdag uunifast_node -n node354_0_2 -p 95 -st topic354_0_1 -pt None -u 0.03702093662892769 > ./result_10chains/node354_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_1_2 -p 173 -st topic354_1_1 -pt None -u 0.002728302085908796 > ./result_10chains/node354_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_2_2 -p 231 -st topic354_2_1 -pt None -u 0.005934388479031161 > ./result_10chains/node354_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_3_2 -p 306 -st topic354_3_1 -pt None -u 0.0023055689765529574 > ./result_10chains/node354_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_4_2 -p 312 -st topic354_4_1 -pt None -u 0.004905296345432797 > ./result_10chains/node354_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_5_2 -p 460 -st topic354_5_1 -pt None -u 0.01400729157904676 > ./result_10chains/node354_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_6_2 -p 577 -st topic354_6_1 -pt None -u 0.04405788570010116 > ./result_10chains/node354_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_7_2 -p 642 -st topic354_7_1 -pt None -u 0.015199658393608165 > ./result_10chains/node354_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_8_2 -p 723 -st topic354_8_1 -pt None -u 0.00478656758471931 > ./result_10chains/node354_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_9_2 -p 737 -st topic354_9_1 -pt None -u 0.004908217618673684 > ./result_10chains/node354_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_0_0 -p 95 -st none -pt topic354_0_0 -u 0.00627320037483059 > ./result_10chains/node354_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_1_0 -p 173 -st none -pt topic354_1_0 -u 0.059572959393713876 > ./result_10chains/node354_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_2_0 -p 231 -st none -pt topic354_2_0 -u 0.02615098077018735 > ./result_10chains/node354_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_3_0 -p 306 -st none -pt topic354_3_0 -u 0.0467135695591927 > ./result_10chains/node354_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_4_0 -p 312 -st none -pt topic354_4_0 -u 0.0011957005644307461 > ./result_10chains/node354_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_5_0 -p 460 -st none -pt topic354_5_0 -u 0.0032842414651808594 > ./result_10chains/node354_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_6_0 -p 577 -st none -pt topic354_6_0 -u 0.013689628303565793 > ./result_10chains/node354_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_7_0 -p 642 -st none -pt topic354_7_0 -u 0.04330021372609573 > ./result_10chains/node354_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_8_0 -p 723 -st none -pt topic354_8_0 -u 0.016850826641607287 > ./result_10chains/node354_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_9_0 -p 737 -st none -pt topic354_9_0 -u 0.02203452494819296 > ./result_10chains/node354_9_0.txt &
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
    "./result_10chains/node354_0_0.txt 90"
    "./result_10chains/node354_0_2.txt 90"
    "./result_10chains/node354_1_0.txt 89"
    "./result_10chains/node354_1_2.txt 89"
    "./result_10chains/node354_2_0.txt 88"
    "./result_10chains/node354_2_2.txt 88"
    "./result_10chains/node354_3_0.txt 87"
    "./result_10chains/node354_3_2.txt 87"
    "./result_10chains/node354_4_0.txt 86"
    "./result_10chains/node354_4_2.txt 86"
    "./result_10chains/node354_5_0.txt 85"
    "./result_10chains/node354_5_2.txt 85"
    "./result_10chains/node354_6_0.txt 84"
    "./result_10chains/node354_6_2.txt 84"
    "./result_10chains/node354_7_0.txt 83"
    "./result_10chains/node354_7_2.txt 83"
    "./result_10chains/node354_8_0.txt 82"
    "./result_10chains/node354_8_2.txt 82"
    "./result_10chains/node354_9_0.txt 81"
    "./result_10chains/node354_9_2.txt 81"
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
