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
ros2 run evaluation_3_randomdag uunifast_node -n node295_0_2 -p 107 -st topic295_0_1 -pt None -u 0.0165059144476285 > ./result_10chains/node295_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_1_2 -p 168 -st topic295_1_1 -pt None -u 0.004326073234507288 > ./result_10chains/node295_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_2_2 -p 208 -st topic295_2_1 -pt None -u 0.018119115026068167 > ./result_10chains/node295_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_3_2 -p 276 -st topic295_3_1 -pt None -u 0.01124250921643305 > ./result_10chains/node295_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_4_2 -p 358 -st topic295_4_1 -pt None -u 0.016523464221941675 > ./result_10chains/node295_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_5_2 -p 406 -st topic295_5_1 -pt None -u 0.007896017247083276 > ./result_10chains/node295_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_6_2 -p 426 -st topic295_6_1 -pt None -u 0.007425252685180156 > ./result_10chains/node295_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_7_2 -p 464 -st topic295_7_1 -pt None -u 0.0011962032102854903 > ./result_10chains/node295_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_8_2 -p 546 -st topic295_8_1 -pt None -u 0.04757995229647296 > ./result_10chains/node295_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_9_2 -p 650 -st topic295_9_1 -pt None -u 0.006864720861962595 > ./result_10chains/node295_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_0_0 -p 107 -st none -pt topic295_0_0 -u 0.008758800320822713 > ./result_10chains/node295_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_1_0 -p 168 -st none -pt topic295_1_0 -u 0.009074126075818145 > ./result_10chains/node295_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_2_0 -p 208 -st none -pt topic295_2_0 -u 0.00032239741021022894 > ./result_10chains/node295_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_3_0 -p 276 -st none -pt topic295_3_0 -u 0.0076142671224374014 > ./result_10chains/node295_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_4_0 -p 358 -st none -pt topic295_4_0 -u 0.0005213969804424012 > ./result_10chains/node295_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_5_0 -p 406 -st none -pt topic295_5_0 -u 0.020726760692463098 > ./result_10chains/node295_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_6_0 -p 426 -st none -pt topic295_6_0 -u 0.05763030975231301 > ./result_10chains/node295_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_7_0 -p 464 -st none -pt topic295_7_0 -u 0.017683238879461494 > ./result_10chains/node295_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_8_0 -p 546 -st none -pt topic295_8_0 -u 0.03469695726768082 > ./result_10chains/node295_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_9_0 -p 650 -st none -pt topic295_9_0 -u 0.022334837264618632 > ./result_10chains/node295_9_0.txt &
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
    "./result_10chains/node295_0_0.txt 90"
    "./result_10chains/node295_0_2.txt 90"
    "./result_10chains/node295_1_0.txt 89"
    "./result_10chains/node295_1_2.txt 89"
    "./result_10chains/node295_2_0.txt 88"
    "./result_10chains/node295_2_2.txt 88"
    "./result_10chains/node295_3_0.txt 87"
    "./result_10chains/node295_3_2.txt 87"
    "./result_10chains/node295_4_0.txt 86"
    "./result_10chains/node295_4_2.txt 86"
    "./result_10chains/node295_5_0.txt 85"
    "./result_10chains/node295_5_2.txt 85"
    "./result_10chains/node295_6_0.txt 84"
    "./result_10chains/node295_6_2.txt 84"
    "./result_10chains/node295_7_0.txt 83"
    "./result_10chains/node295_7_2.txt 83"
    "./result_10chains/node295_8_0.txt 82"
    "./result_10chains/node295_8_2.txt 82"
    "./result_10chains/node295_9_0.txt 81"
    "./result_10chains/node295_9_2.txt 81"
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
