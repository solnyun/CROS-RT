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
ros2 run evaluation_3_randomdag uunifast_node -n node244_0_2 -p 102 -st topic244_0_1 -pt None -u 0.0055495523897886034 > ./result_8chains/node244_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_1_2 -p 190 -st topic244_1_1 -pt None -u 0.051887669249894464 > ./result_8chains/node244_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_2_2 -p 211 -st topic244_2_1 -pt None -u 0.04702056358482931 > ./result_8chains/node244_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_3_2 -p 404 -st topic244_3_1 -pt None -u 0.0016705623630185462 > ./result_8chains/node244_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_4_2 -p 592 -st topic244_4_1 -pt None -u 0.0035148853164040372 > ./result_8chains/node244_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_5_2 -p 633 -st topic244_5_1 -pt None -u 0.014169306779183016 > ./result_8chains/node244_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_6_2 -p 729 -st topic244_6_1 -pt None -u 0.014051865571563057 > ./result_8chains/node244_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_7_2 -p 998 -st topic244_7_1 -pt None -u 0.018083577333024455 > ./result_8chains/node244_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_0_0 -p 102 -st none -pt topic244_0_0 -u 0.024942977759163265 > ./result_8chains/node244_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_1_0 -p 190 -st none -pt topic244_1_0 -u 0.04977089530486267 > ./result_8chains/node244_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_2_0 -p 211 -st none -pt topic244_2_0 -u 0.10033601530907915 > ./result_8chains/node244_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_3_0 -p 404 -st none -pt topic244_3_0 -u 0.01118265054457207 > ./result_8chains/node244_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_4_0 -p 592 -st none -pt topic244_4_0 -u 0.011023417376484934 > ./result_8chains/node244_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_5_0 -p 633 -st none -pt topic244_5_0 -u 0.024608477935180673 > ./result_8chains/node244_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_6_0 -p 729 -st none -pt topic244_6_0 -u 0.007364927060633075 > ./result_8chains/node244_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_7_0 -p 998 -st none -pt topic244_7_0 -u 0.0004127847010352431 > ./result_8chains/node244_7_0.txt &
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
    "./result_8chains/node244_0_0.txt 90"
    "./result_8chains/node244_0_2.txt 90"
    "./result_8chains/node244_1_0.txt 89"
    "./result_8chains/node244_1_2.txt 89"
    "./result_8chains/node244_2_0.txt 88"
    "./result_8chains/node244_2_2.txt 88"
    "./result_8chains/node244_3_0.txt 87"
    "./result_8chains/node244_3_2.txt 87"
    "./result_8chains/node244_4_0.txt 86"
    "./result_8chains/node244_4_2.txt 86"
    "./result_8chains/node244_5_0.txt 85"
    "./result_8chains/node244_5_2.txt 85"
    "./result_8chains/node244_6_0.txt 84"
    "./result_8chains/node244_6_2.txt 84"
    "./result_8chains/node244_7_0.txt 83"
    "./result_8chains/node244_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
