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
ros2 run evaluation_3_randomdag uunifast_node -n node202_0_2 -p 10 -st topic202_0_1 -pt None -u 0.004004089354250728 > ./result_10chains/node202_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_1_2 -p 28 -st topic202_1_1 -pt None -u 0.015347911519290491 > ./result_10chains/node202_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_2_2 -p 172 -st topic202_2_1 -pt None -u 0.08747947456355987 > ./result_10chains/node202_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_3_2 -p 287 -st topic202_3_1 -pt None -u 0.016653511332175075 > ./result_10chains/node202_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_4_2 -p 385 -st topic202_4_1 -pt None -u 0.001451439103947072 > ./result_10chains/node202_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_5_2 -p 463 -st topic202_5_1 -pt None -u 0.008056716424673871 > ./result_10chains/node202_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_6_2 -p 493 -st topic202_6_1 -pt None -u 0.032614018745908 > ./result_10chains/node202_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_7_2 -p 669 -st topic202_7_1 -pt None -u 0.006987355998417016 > ./result_10chains/node202_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_8_2 -p 769 -st topic202_8_1 -pt None -u 0.024217073790425613 > ./result_10chains/node202_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_9_2 -p 923 -st topic202_9_1 -pt None -u 0.005404948040042383 > ./result_10chains/node202_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_0_0 -p 10 -st none -pt topic202_0_0 -u 0.0002840885971152618 > ./result_10chains/node202_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_1_0 -p 28 -st none -pt topic202_1_0 -u 0.019523957664989378 > ./result_10chains/node202_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_2_0 -p 172 -st none -pt topic202_2_0 -u 0.013503328519856195 > ./result_10chains/node202_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_3_0 -p 287 -st none -pt topic202_3_0 -u 0.052484869459584194 > ./result_10chains/node202_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_4_0 -p 385 -st none -pt topic202_4_0 -u 0.02504784211274602 > ./result_10chains/node202_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_5_0 -p 463 -st none -pt topic202_5_0 -u 0.00722369428653688 > ./result_10chains/node202_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_6_0 -p 493 -st none -pt topic202_6_0 -u 0.01775857588507951 > ./result_10chains/node202_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_7_0 -p 669 -st none -pt topic202_7_0 -u 0.036847613985175776 > ./result_10chains/node202_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_8_0 -p 769 -st none -pt topic202_8_0 -u 0.0009576467605265371 > ./result_10chains/node202_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_9_0 -p 923 -st none -pt topic202_9_0 -u 0.011695653854454797 > ./result_10chains/node202_9_0.txt &
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
    "./result_10chains/node202_0_0.txt 90"
    "./result_10chains/node202_0_2.txt 90"
    "./result_10chains/node202_1_0.txt 89"
    "./result_10chains/node202_1_2.txt 89"
    "./result_10chains/node202_2_0.txt 88"
    "./result_10chains/node202_2_2.txt 88"
    "./result_10chains/node202_3_0.txt 87"
    "./result_10chains/node202_3_2.txt 87"
    "./result_10chains/node202_4_0.txt 86"
    "./result_10chains/node202_4_2.txt 86"
    "./result_10chains/node202_5_0.txt 85"
    "./result_10chains/node202_5_2.txt 85"
    "./result_10chains/node202_6_0.txt 84"
    "./result_10chains/node202_6_2.txt 84"
    "./result_10chains/node202_7_0.txt 83"
    "./result_10chains/node202_7_2.txt 83"
    "./result_10chains/node202_8_0.txt 82"
    "./result_10chains/node202_8_2.txt 82"
    "./result_10chains/node202_9_0.txt 81"
    "./result_10chains/node202_9_2.txt 81"
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
