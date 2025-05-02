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
ros2 run evaluation_3_randomdag uunifast_node -n node178_0_2 -p 101 -st topic178_0_1 -pt None -u 0.013249268828456118 > ./result_10chains/node178_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_1_2 -p 289 -st topic178_1_1 -pt None -u 0.0025732771021541034 > ./result_10chains/node178_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_2_2 -p 308 -st topic178_2_1 -pt None -u 0.013096039057793551 > ./result_10chains/node178_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_3_2 -p 377 -st topic178_3_1 -pt None -u 0.04940424387740919 > ./result_10chains/node178_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_4_2 -p 530 -st topic178_4_1 -pt None -u 0.0360445471237858 > ./result_10chains/node178_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_5_2 -p 764 -st topic178_5_1 -pt None -u 0.01006486316591819 > ./result_10chains/node178_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_6_2 -p 841 -st topic178_6_1 -pt None -u 0.000530520071604132 > ./result_10chains/node178_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_7_2 -p 843 -st topic178_7_1 -pt None -u 0.03844469035556937 > ./result_10chains/node178_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_8_2 -p 890 -st topic178_8_1 -pt None -u 0.008878282089484588 > ./result_10chains/node178_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_9_2 -p 906 -st topic178_9_1 -pt None -u 0.002823533116194639 > ./result_10chains/node178_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_0_0 -p 101 -st none -pt topic178_0_0 -u 0.007788695233787779 > ./result_10chains/node178_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_1_0 -p 289 -st none -pt topic178_1_0 -u 0.03341141931833602 > ./result_10chains/node178_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_2_0 -p 308 -st none -pt topic178_2_0 -u 0.03910960051234208 > ./result_10chains/node178_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_3_0 -p 377 -st none -pt topic178_3_0 -u 0.004836592791011229 > ./result_10chains/node178_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_4_0 -p 530 -st none -pt topic178_4_0 -u 0.008665511475972887 > ./result_10chains/node178_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_5_0 -p 764 -st none -pt topic178_5_0 -u 0.0023032578052628594 > ./result_10chains/node178_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_6_0 -p 841 -st none -pt topic178_6_0 -u 0.01307841409006441 > ./result_10chains/node178_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_7_0 -p 843 -st none -pt topic178_7_0 -u 0.005204151555026307 > ./result_10chains/node178_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_8_0 -p 890 -st none -pt topic178_8_0 -u 0.0012657475753593966 > ./result_10chains/node178_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_9_0 -p 906 -st none -pt topic178_9_0 -u 0.023590438675304935 > ./result_10chains/node178_9_0.txt &
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
    "./result_10chains/node178_0_0.txt 90"
    "./result_10chains/node178_0_2.txt 90"
    "./result_10chains/node178_1_0.txt 89"
    "./result_10chains/node178_1_2.txt 89"
    "./result_10chains/node178_2_0.txt 88"
    "./result_10chains/node178_2_2.txt 88"
    "./result_10chains/node178_3_0.txt 87"
    "./result_10chains/node178_3_2.txt 87"
    "./result_10chains/node178_4_0.txt 86"
    "./result_10chains/node178_4_2.txt 86"
    "./result_10chains/node178_5_0.txt 85"
    "./result_10chains/node178_5_2.txt 85"
    "./result_10chains/node178_6_0.txt 84"
    "./result_10chains/node178_6_2.txt 84"
    "./result_10chains/node178_7_0.txt 83"
    "./result_10chains/node178_7_2.txt 83"
    "./result_10chains/node178_8_0.txt 82"
    "./result_10chains/node178_8_2.txt 82"
    "./result_10chains/node178_9_0.txt 81"
    "./result_10chains/node178_9_2.txt 81"
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
