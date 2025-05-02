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
ros2 run evaluation_3_randomdag uunifast_node -n node436_0_2 -p 92 -st topic436_0_1 -pt None -u 0.009908098834200185 > ./result_10chains/node436_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_1_2 -p 256 -st topic436_1_1 -pt None -u 0.008238995222113743 > ./result_10chains/node436_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_2_2 -p 395 -st topic436_2_1 -pt None -u 0.002739421564183775 > ./result_10chains/node436_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_3_2 -p 400 -st topic436_3_1 -pt None -u 0.052348208035858546 > ./result_10chains/node436_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_4_2 -p 421 -st topic436_4_1 -pt None -u 0.027120777222576775 > ./result_10chains/node436_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_5_2 -p 483 -st topic436_5_1 -pt None -u 0.023023177962759905 > ./result_10chains/node436_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_6_2 -p 647 -st topic436_6_1 -pt None -u 0.009245722788071092 > ./result_10chains/node436_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_7_2 -p 666 -st topic436_7_1 -pt None -u 0.006185081929852676 > ./result_10chains/node436_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_8_2 -p 765 -st topic436_8_1 -pt None -u 0.0010106718630681216 > ./result_10chains/node436_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_9_2 -p 944 -st topic436_9_1 -pt None -u 0.006015084179755772 > ./result_10chains/node436_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_0_0 -p 92 -st none -pt topic436_0_0 -u 0.003172593202148577 > ./result_10chains/node436_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_1_0 -p 256 -st none -pt topic436_1_0 -u 0.00947397994706195 > ./result_10chains/node436_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_2_0 -p 395 -st none -pt topic436_2_0 -u 0.021128072227409922 > ./result_10chains/node436_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_3_0 -p 400 -st none -pt topic436_3_0 -u 0.03150626725417155 > ./result_10chains/node436_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_4_0 -p 421 -st none -pt topic436_4_0 -u 0.03142565516070664 > ./result_10chains/node436_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_5_0 -p 483 -st none -pt topic436_5_0 -u 0.02650887876813643 > ./result_10chains/node436_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_6_0 -p 647 -st none -pt topic436_6_0 -u 0.0006058677530233619 > ./result_10chains/node436_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_7_0 -p 666 -st none -pt topic436_7_0 -u 0.002436250160721687 > ./result_10chains/node436_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_8_0 -p 765 -st none -pt topic436_8_0 -u 0.005114916254274682 > ./result_10chains/node436_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node436_9_0 -p 944 -st none -pt topic436_9_0 -u 0.02618032654847635 > ./result_10chains/node436_9_0.txt &
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
    "./result_10chains/node436_0_0.txt 90"
    "./result_10chains/node436_0_2.txt 90"
    "./result_10chains/node436_1_0.txt 89"
    "./result_10chains/node436_1_2.txt 89"
    "./result_10chains/node436_2_0.txt 88"
    "./result_10chains/node436_2_2.txt 88"
    "./result_10chains/node436_3_0.txt 87"
    "./result_10chains/node436_3_2.txt 87"
    "./result_10chains/node436_4_0.txt 86"
    "./result_10chains/node436_4_2.txt 86"
    "./result_10chains/node436_5_0.txt 85"
    "./result_10chains/node436_5_2.txt 85"
    "./result_10chains/node436_6_0.txt 84"
    "./result_10chains/node436_6_2.txt 84"
    "./result_10chains/node436_7_0.txt 83"
    "./result_10chains/node436_7_2.txt 83"
    "./result_10chains/node436_8_0.txt 82"
    "./result_10chains/node436_8_2.txt 82"
    "./result_10chains/node436_9_0.txt 81"
    "./result_10chains/node436_9_2.txt 81"
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
