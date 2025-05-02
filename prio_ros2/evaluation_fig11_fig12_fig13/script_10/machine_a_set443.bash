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
ros2 run evaluation_3_randomdag uunifast_node -n node443_0_2 -p 201 -st topic443_0_1 -pt None -u 0.011542827509534781 > ./result_10chains/node443_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_1_2 -p 284 -st topic443_1_1 -pt None -u 0.00242723358832575 > ./result_10chains/node443_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_2_2 -p 307 -st topic443_2_1 -pt None -u 0.006546900119904275 > ./result_10chains/node443_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_3_2 -p 351 -st topic443_3_1 -pt None -u 0.010185113326598938 > ./result_10chains/node443_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_4_2 -p 430 -st topic443_4_1 -pt None -u 0.011949603308340329 > ./result_10chains/node443_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_5_2 -p 515 -st topic443_5_1 -pt None -u 0.008076486429937024 > ./result_10chains/node443_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_6_2 -p 717 -st topic443_6_1 -pt None -u 0.0001575910689587956 > ./result_10chains/node443_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_7_2 -p 740 -st topic443_7_1 -pt None -u 0.03229857259431948 > ./result_10chains/node443_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_8_2 -p 783 -st topic443_8_1 -pt None -u 0.012682958921709939 > ./result_10chains/node443_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_9_2 -p 921 -st topic443_9_1 -pt None -u 0.0535555332355352 > ./result_10chains/node443_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_0_0 -p 201 -st none -pt topic443_0_0 -u 0.007213675403631881 > ./result_10chains/node443_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_1_0 -p 284 -st none -pt topic443_1_0 -u 0.00809101047400912 > ./result_10chains/node443_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_2_0 -p 307 -st none -pt topic443_2_0 -u 0.004986979881101805 > ./result_10chains/node443_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_3_0 -p 351 -st none -pt topic443_3_0 -u 0.024035347082534686 > ./result_10chains/node443_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_4_0 -p 430 -st none -pt topic443_4_0 -u 0.007009584501406485 > ./result_10chains/node443_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_5_0 -p 515 -st none -pt topic443_5_0 -u 0.028492600147769942 > ./result_10chains/node443_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_6_0 -p 717 -st none -pt topic443_6_0 -u 0.013906656388936178 > ./result_10chains/node443_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_7_0 -p 740 -st none -pt topic443_7_0 -u 0.00530323256039994 > ./result_10chains/node443_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_8_0 -p 783 -st none -pt topic443_8_0 -u 0.024390057570244345 > ./result_10chains/node443_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_9_0 -p 921 -st none -pt topic443_9_0 -u 0.005341010984108649 > ./result_10chains/node443_9_0.txt &
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
    "./result_10chains/node443_0_0.txt 90"
    "./result_10chains/node443_0_2.txt 90"
    "./result_10chains/node443_1_0.txt 89"
    "./result_10chains/node443_1_2.txt 89"
    "./result_10chains/node443_2_0.txt 88"
    "./result_10chains/node443_2_2.txt 88"
    "./result_10chains/node443_3_0.txt 87"
    "./result_10chains/node443_3_2.txt 87"
    "./result_10chains/node443_4_0.txt 86"
    "./result_10chains/node443_4_2.txt 86"
    "./result_10chains/node443_5_0.txt 85"
    "./result_10chains/node443_5_2.txt 85"
    "./result_10chains/node443_6_0.txt 84"
    "./result_10chains/node443_6_2.txt 84"
    "./result_10chains/node443_7_0.txt 83"
    "./result_10chains/node443_7_2.txt 83"
    "./result_10chains/node443_8_0.txt 82"
    "./result_10chains/node443_8_2.txt 82"
    "./result_10chains/node443_9_0.txt 81"
    "./result_10chains/node443_9_2.txt 81"
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
