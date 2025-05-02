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
ros2 run evaluation_3_randomdag uunifast_node -n node322_0_1 -p 143 -st topic322_0_0 -pt topic322_0_1 -u 0.02621824028594072 > ./result_10chains/node322_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_1_1 -p 157 -st topic322_1_0 -pt topic322_1_1 -u 0.0032394732673592386 > ./result_10chains/node322_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_2_1 -p 161 -st topic322_2_0 -pt topic322_2_1 -u 0.005119041781917966 > ./result_10chains/node322_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_3_1 -p 250 -st topic322_3_0 -pt topic322_3_1 -u 0.004323047858041107 > ./result_10chains/node322_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_4_1 -p 470 -st topic322_4_0 -pt topic322_4_1 -u 0.03605833358269889 > ./result_10chains/node322_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_5_1 -p 505 -st topic322_5_0 -pt topic322_5_1 -u 0.009826848399730637 > ./result_10chains/node322_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_6_1 -p 666 -st topic322_6_0 -pt topic322_6_1 -u 0.0127189400302046 > ./result_10chains/node322_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_7_1 -p 675 -st topic322_7_0 -pt topic322_7_1 -u 0.009991751098273896 > ./result_10chains/node322_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_8_1 -p 767 -st topic322_8_0 -pt topic322_8_1 -u 0.03234453781475877 > ./result_10chains/node322_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_9_1 -p 883 -st topic322_9_0 -pt topic322_9_1 -u 0.004817522389121868 > ./result_10chains/node322_9_1.txt &
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
    "./result_10chains/node322_0_1.txt 90"
    "./result_10chains/node322_1_1.txt 89"
    "./result_10chains/node322_2_1.txt 88"
    "./result_10chains/node322_3_1.txt 87"
    "./result_10chains/node322_4_1.txt 86"
    "./result_10chains/node322_5_1.txt 85"
    "./result_10chains/node322_6_1.txt 84"
    "./result_10chains/node322_7_1.txt 83"
    "./result_10chains/node322_8_1.txt 82"
    "./result_10chains/node322_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
