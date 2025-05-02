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
ros2 run evaluation_3_randomdag uunifast_node -n node378_0_2 -p 297 -st topic378_0_1 -pt None -u 0.017321665339258774 > ./result_10chains/node378_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_1_2 -p 326 -st topic378_1_1 -pt None -u 0.003758916372969212 > ./result_10chains/node378_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_2_2 -p 498 -st topic378_2_1 -pt None -u 0.00023480298103878416 > ./result_10chains/node378_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_3_2 -p 640 -st topic378_3_1 -pt None -u 0.020207078421090152 > ./result_10chains/node378_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_4_2 -p 666 -st topic378_4_1 -pt None -u 0.016351669428222082 > ./result_10chains/node378_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_5_2 -p 677 -st topic378_5_1 -pt None -u 0.031466690740105746 > ./result_10chains/node378_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_6_2 -p 781 -st topic378_6_1 -pt None -u 0.017757761466656433 > ./result_10chains/node378_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_7_2 -p 789 -st topic378_7_1 -pt None -u 0.009135939285568315 > ./result_10chains/node378_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_8_2 -p 862 -st topic378_8_1 -pt None -u 0.000717104086091748 > ./result_10chains/node378_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_9_2 -p 864 -st topic378_9_1 -pt None -u 0.009683985298357994 > ./result_10chains/node378_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_0_0 -p 297 -st none -pt topic378_0_0 -u 0.006751027998078085 > ./result_10chains/node378_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_1_0 -p 326 -st none -pt topic378_1_0 -u 0.0338758550470567 > ./result_10chains/node378_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_2_0 -p 498 -st none -pt topic378_2_0 -u 0.0036886741293445935 > ./result_10chains/node378_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_3_0 -p 640 -st none -pt topic378_3_0 -u 0.0340064642574226 > ./result_10chains/node378_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_4_0 -p 666 -st none -pt topic378_4_0 -u 0.010030073547396767 > ./result_10chains/node378_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_5_0 -p 677 -st none -pt topic378_5_0 -u 0.03000914532886778 > ./result_10chains/node378_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_6_0 -p 781 -st none -pt topic378_6_0 -u 0.005032256131580287 > ./result_10chains/node378_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_7_0 -p 789 -st none -pt topic378_7_0 -u 0.0036149283429078166 > ./result_10chains/node378_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_8_0 -p 862 -st none -pt topic378_8_0 -u 0.001063969302689781 > ./result_10chains/node378_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_9_0 -p 864 -st none -pt topic378_9_0 -u 0.02874121387976409 > ./result_10chains/node378_9_0.txt &
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
    "./result_10chains/node378_0_0.txt 90"
    "./result_10chains/node378_0_2.txt 90"
    "./result_10chains/node378_1_0.txt 89"
    "./result_10chains/node378_1_2.txt 89"
    "./result_10chains/node378_2_0.txt 88"
    "./result_10chains/node378_2_2.txt 88"
    "./result_10chains/node378_3_0.txt 87"
    "./result_10chains/node378_3_2.txt 87"
    "./result_10chains/node378_4_0.txt 86"
    "./result_10chains/node378_4_2.txt 86"
    "./result_10chains/node378_5_0.txt 85"
    "./result_10chains/node378_5_2.txt 85"
    "./result_10chains/node378_6_0.txt 84"
    "./result_10chains/node378_6_2.txt 84"
    "./result_10chains/node378_7_0.txt 83"
    "./result_10chains/node378_7_2.txt 83"
    "./result_10chains/node378_8_0.txt 82"
    "./result_10chains/node378_8_2.txt 82"
    "./result_10chains/node378_9_0.txt 81"
    "./result_10chains/node378_9_2.txt 81"
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
