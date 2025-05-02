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
ros2 run evaluation_3_randomdag uunifast_node -n node34_0_2 -p 39 -st topic34_0_1 -pt None -u 0.004488792299767175 > ./result_10chains/node34_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_1_2 -p 61 -st topic34_1_1 -pt None -u 0.0041934545923486555 > ./result_10chains/node34_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_2_2 -p 82 -st topic34_2_1 -pt None -u 0.002824348437528712 > ./result_10chains/node34_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_3_2 -p 100 -st topic34_3_1 -pt None -u 0.004773247353639765 > ./result_10chains/node34_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_4_2 -p 164 -st topic34_4_1 -pt None -u 0.01778649540721533 > ./result_10chains/node34_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_5_2 -p 221 -st topic34_5_1 -pt None -u 0.02857187846405973 > ./result_10chains/node34_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_6_2 -p 508 -st topic34_6_1 -pt None -u 0.04960036041939697 > ./result_10chains/node34_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_7_2 -p 703 -st topic34_7_1 -pt None -u 0.004341771771438074 > ./result_10chains/node34_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_8_2 -p 901 -st topic34_8_1 -pt None -u 0.023752159690268837 > ./result_10chains/node34_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_9_2 -p 969 -st topic34_9_1 -pt None -u 0.034878577418113 > ./result_10chains/node34_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_0_0 -p 39 -st none -pt topic34_0_0 -u 0.015624066915244483 > ./result_10chains/node34_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_1_0 -p 61 -st none -pt topic34_1_0 -u 0.016084177003522215 > ./result_10chains/node34_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_2_0 -p 82 -st none -pt topic34_2_0 -u 0.0055899128371666995 > ./result_10chains/node34_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_3_0 -p 100 -st none -pt topic34_3_0 -u 0.003234825832202637 > ./result_10chains/node34_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_4_0 -p 164 -st none -pt topic34_4_0 -u 0.011173339965899476 > ./result_10chains/node34_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_5_0 -p 221 -st none -pt topic34_5_0 -u 0.008619018091459651 > ./result_10chains/node34_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_6_0 -p 508 -st none -pt topic34_6_0 -u 7.49538906658076e-05 > ./result_10chains/node34_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_7_0 -p 703 -st none -pt topic34_7_0 -u 0.0088229891111605 > ./result_10chains/node34_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node34_8_0 -p 901 -st none -pt topic34_8_0 -u 0.003736588931401996 > ./result_10chains/node34_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node34_9_0 -p 969 -st none -pt topic34_9_0 -u 0.07256007220954161 > ./result_10chains/node34_9_0.txt &
sleep 10
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
    "./result_10chains/node34_0_0.txt 90"
    "./result_10chains/node34_0_2.txt 90"
    "./result_10chains/node34_1_0.txt 89"
    "./result_10chains/node34_1_2.txt 89"
    "./result_10chains/node34_2_0.txt 88"
    "./result_10chains/node34_2_2.txt 88"
    "./result_10chains/node34_3_0.txt 87"
    "./result_10chains/node34_3_2.txt 87"
    "./result_10chains/node34_4_0.txt 86"
    "./result_10chains/node34_4_2.txt 86"
    "./result_10chains/node34_5_0.txt 85"
    "./result_10chains/node34_5_2.txt 85"
    "./result_10chains/node34_6_0.txt 84"
    "./result_10chains/node34_6_2.txt 84"
    "./result_10chains/node34_7_0.txt 83"
    "./result_10chains/node34_7_2.txt 83"
    "./result_10chains/node34_8_0.txt 82"
    "./result_10chains/node34_8_2.txt 82"
    "./result_10chains/node34_9_0.txt 81"
    "./result_10chains/node34_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
