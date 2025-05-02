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
ros2 run evaluation_3_randomdag uunifast_node -n node410_0_2 -p 39 -st topic410_0_1 -pt None -u 8.5120285429785e-05 > ./result_10chains/node410_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_1_2 -p 217 -st topic410_1_1 -pt None -u 0.039473340727984585 > ./result_10chains/node410_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_2_2 -p 218 -st topic410_2_1 -pt None -u 0.0020782735878597247 > ./result_10chains/node410_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_3_2 -p 446 -st topic410_3_1 -pt None -u 0.009974726988035476 > ./result_10chains/node410_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_4_2 -p 499 -st topic410_4_1 -pt None -u 0.006810840236107341 > ./result_10chains/node410_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_5_2 -p 571 -st topic410_5_1 -pt None -u 0.015006471425302204 > ./result_10chains/node410_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_6_2 -p 574 -st topic410_6_1 -pt None -u 0.013703183752622874 > ./result_10chains/node410_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_7_2 -p 873 -st topic410_7_1 -pt None -u 0.022708746432487638 > ./result_10chains/node410_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_8_2 -p 925 -st topic410_8_1 -pt None -u 0.014511019166754627 > ./result_10chains/node410_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_9_2 -p 991 -st topic410_9_1 -pt None -u 0.02105457397283467 > ./result_10chains/node410_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_0_0 -p 39 -st none -pt topic410_0_0 -u 0.06562037033352136 > ./result_10chains/node410_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_1_0 -p 217 -st none -pt topic410_1_0 -u 0.008396482460439336 > ./result_10chains/node410_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_2_0 -p 218 -st none -pt topic410_2_0 -u 0.016102112812646674 > ./result_10chains/node410_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_3_0 -p 446 -st none -pt topic410_3_0 -u 0.009196523095848008 > ./result_10chains/node410_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_4_0 -p 499 -st none -pt topic410_4_0 -u 0.0025350399926037936 > ./result_10chains/node410_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_5_0 -p 571 -st none -pt topic410_5_0 -u 0.02041508475704712 > ./result_10chains/node410_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_6_0 -p 574 -st none -pt topic410_6_0 -u 0.027774602785719138 > ./result_10chains/node410_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_7_0 -p 873 -st none -pt topic410_7_0 -u 0.007710293878837607 > ./result_10chains/node410_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_8_0 -p 925 -st none -pt topic410_8_0 -u 0.004280404789728111 > ./result_10chains/node410_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node410_9_0 -p 991 -st none -pt topic410_9_0 -u 0.002492022893329844 > ./result_10chains/node410_9_0.txt &
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
    "./result_10chains/node410_0_0.txt 90"
    "./result_10chains/node410_0_2.txt 90"
    "./result_10chains/node410_1_0.txt 89"
    "./result_10chains/node410_1_2.txt 89"
    "./result_10chains/node410_2_0.txt 88"
    "./result_10chains/node410_2_2.txt 88"
    "./result_10chains/node410_3_0.txt 87"
    "./result_10chains/node410_3_2.txt 87"
    "./result_10chains/node410_4_0.txt 86"
    "./result_10chains/node410_4_2.txt 86"
    "./result_10chains/node410_5_0.txt 85"
    "./result_10chains/node410_5_2.txt 85"
    "./result_10chains/node410_6_0.txt 84"
    "./result_10chains/node410_6_2.txt 84"
    "./result_10chains/node410_7_0.txt 83"
    "./result_10chains/node410_7_2.txt 83"
    "./result_10chains/node410_8_0.txt 82"
    "./result_10chains/node410_8_2.txt 82"
    "./result_10chains/node410_9_0.txt 81"
    "./result_10chains/node410_9_2.txt 81"
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
