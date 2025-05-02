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
ros2 run evaluation_3_randomdag uunifast_node -n node438_0_2 -p 295 -st topic438_0_1 -pt None -u 0.0037827882528156387 > ./result_10chains/node438_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_1_2 -p 360 -st topic438_1_1 -pt None -u 0.0017900399533036793 > ./result_10chains/node438_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_2_2 -p 428 -st topic438_2_1 -pt None -u 0.03977190752193893 > ./result_10chains/node438_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_3_2 -p 600 -st topic438_3_1 -pt None -u 0.017116320850391553 > ./result_10chains/node438_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_4_2 -p 657 -st topic438_4_1 -pt None -u 0.04091863734872209 > ./result_10chains/node438_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_5_2 -p 806 -st topic438_5_1 -pt None -u 0.0010751099205086323 > ./result_10chains/node438_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_6_2 -p 850 -st topic438_6_1 -pt None -u 0.028062200151959843 > ./result_10chains/node438_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_7_2 -p 905 -st topic438_7_1 -pt None -u 0.0007242145693531488 > ./result_10chains/node438_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_8_2 -p 914 -st topic438_8_1 -pt None -u 0.009809203897006333 > ./result_10chains/node438_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_9_2 -p 976 -st topic438_9_1 -pt None -u 0.0043160043776816585 > ./result_10chains/node438_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_0_0 -p 295 -st none -pt topic438_0_0 -u 0.02925614132839377 > ./result_10chains/node438_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_1_0 -p 360 -st none -pt topic438_1_0 -u 0.013316804132351312 > ./result_10chains/node438_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_2_0 -p 428 -st none -pt topic438_2_0 -u 0.025238629886460973 > ./result_10chains/node438_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_3_0 -p 600 -st none -pt topic438_3_0 -u 0.006054279999353318 > ./result_10chains/node438_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_4_0 -p 657 -st none -pt topic438_4_0 -u 0.02116689106048575 > ./result_10chains/node438_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_5_0 -p 806 -st none -pt topic438_5_0 -u 0.00635145285778993 > ./result_10chains/node438_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_6_0 -p 850 -st none -pt topic438_6_0 -u 0.007834879334350009 > ./result_10chains/node438_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_7_0 -p 905 -st none -pt topic438_7_0 -u 0.02371113920941817 > ./result_10chains/node438_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node438_8_0 -p 914 -st none -pt topic438_8_0 -u 0.011039194967323418 > ./result_10chains/node438_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node438_9_0 -p 976 -st none -pt topic438_9_0 -u 0.11336063554215431 > ./result_10chains/node438_9_0.txt &
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
    "./result_10chains/node438_0_0.txt 90"
    "./result_10chains/node438_0_2.txt 90"
    "./result_10chains/node438_1_0.txt 89"
    "./result_10chains/node438_1_2.txt 89"
    "./result_10chains/node438_2_0.txt 88"
    "./result_10chains/node438_2_2.txt 88"
    "./result_10chains/node438_3_0.txt 87"
    "./result_10chains/node438_3_2.txt 87"
    "./result_10chains/node438_4_0.txt 86"
    "./result_10chains/node438_4_2.txt 86"
    "./result_10chains/node438_5_0.txt 85"
    "./result_10chains/node438_5_2.txt 85"
    "./result_10chains/node438_6_0.txt 84"
    "./result_10chains/node438_6_2.txt 84"
    "./result_10chains/node438_7_0.txt 83"
    "./result_10chains/node438_7_2.txt 83"
    "./result_10chains/node438_8_0.txt 82"
    "./result_10chains/node438_8_2.txt 82"
    "./result_10chains/node438_9_0.txt 81"
    "./result_10chains/node438_9_2.txt 81"
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
