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
ros2 run evaluation_3_randomdag uunifast_node -n node348_0_2 -p 49 -st topic348_0_1 -pt None -u 0.013251697111026972 > ./result_10chains/node348_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_1_2 -p 71 -st topic348_1_1 -pt None -u 0.0009099613206803303 > ./result_10chains/node348_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_2_2 -p 125 -st topic348_2_1 -pt None -u 0.010609650284289285 > ./result_10chains/node348_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_3_2 -p 144 -st topic348_3_1 -pt None -u 0.015055018200800796 > ./result_10chains/node348_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_4_2 -p 174 -st topic348_4_1 -pt None -u 0.011092544398500381 > ./result_10chains/node348_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_5_2 -p 209 -st topic348_5_1 -pt None -u 0.014772722418974343 > ./result_10chains/node348_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_6_2 -p 279 -st topic348_6_1 -pt None -u 0.0016918629805097452 > ./result_10chains/node348_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_7_2 -p 296 -st topic348_7_1 -pt None -u 0.025669382641163696 > ./result_10chains/node348_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_8_2 -p 612 -st topic348_8_1 -pt None -u 0.030161002927622624 > ./result_10chains/node348_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_9_2 -p 778 -st topic348_9_1 -pt None -u 0.009795424101257149 > ./result_10chains/node348_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_0_0 -p 49 -st none -pt topic348_0_0 -u 0.0018257515885578002 > ./result_10chains/node348_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_1_0 -p 71 -st none -pt topic348_1_0 -u 0.007843605199271686 > ./result_10chains/node348_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_2_0 -p 125 -st none -pt topic348_2_0 -u 0.02492324887358477 > ./result_10chains/node348_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_3_0 -p 144 -st none -pt topic348_3_0 -u 0.020453461884418822 > ./result_10chains/node348_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_4_0 -p 174 -st none -pt topic348_4_0 -u 0.023995604834901096 > ./result_10chains/node348_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_5_0 -p 209 -st none -pt topic348_5_0 -u 0.014214896050166181 > ./result_10chains/node348_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_6_0 -p 279 -st none -pt topic348_6_0 -u 0.021800776983615183 > ./result_10chains/node348_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_7_0 -p 296 -st none -pt topic348_7_0 -u 0.024071120050469547 > ./result_10chains/node348_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node348_8_0 -p 612 -st none -pt topic348_8_0 -u 0.02529042388880892 > ./result_10chains/node348_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node348_9_0 -p 778 -st none -pt topic348_9_0 -u 0.028111787148294265 > ./result_10chains/node348_9_0.txt &
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
    "./result_10chains/node348_0_0.txt 90"
    "./result_10chains/node348_0_2.txt 90"
    "./result_10chains/node348_1_0.txt 89"
    "./result_10chains/node348_1_2.txt 89"
    "./result_10chains/node348_2_0.txt 88"
    "./result_10chains/node348_2_2.txt 88"
    "./result_10chains/node348_3_0.txt 87"
    "./result_10chains/node348_3_2.txt 87"
    "./result_10chains/node348_4_0.txt 86"
    "./result_10chains/node348_4_2.txt 86"
    "./result_10chains/node348_5_0.txt 85"
    "./result_10chains/node348_5_2.txt 85"
    "./result_10chains/node348_6_0.txt 84"
    "./result_10chains/node348_6_2.txt 84"
    "./result_10chains/node348_7_0.txt 83"
    "./result_10chains/node348_7_2.txt 83"
    "./result_10chains/node348_8_0.txt 82"
    "./result_10chains/node348_8_2.txt 82"
    "./result_10chains/node348_9_0.txt 81"
    "./result_10chains/node348_9_2.txt 81"
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
