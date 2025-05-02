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
ros2 run evaluation_3_randomdag uunifast_node -n node287_0_2 -p 122 -st topic287_0_1 -pt None -u 0.026504931643330065 > ./result_6chains/node287_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_1_2 -p 500 -st topic287_1_1 -pt None -u 0.03035302883362012 > ./result_6chains/node287_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_2_2 -p 773 -st topic287_2_1 -pt None -u 0.06502275556546311 > ./result_6chains/node287_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_3_2 -p 869 -st topic287_3_1 -pt None -u 0.020330241588406406 > ./result_6chains/node287_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_4_2 -p 887 -st topic287_4_1 -pt None -u 0.040581601491895075 > ./result_6chains/node287_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_5_2 -p 983 -st topic287_5_1 -pt None -u 0.016166951008199818 > ./result_6chains/node287_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_0_0 -p 122 -st none -pt topic287_0_0 -u 0.034826509410240736 > ./result_6chains/node287_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_1_0 -p 500 -st none -pt topic287_1_0 -u 0.008876321817019805 > ./result_6chains/node287_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_2_0 -p 773 -st none -pt topic287_2_0 -u 0.03371061338032977 > ./result_6chains/node287_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_3_0 -p 869 -st none -pt topic287_3_0 -u 0.005091184202572319 > ./result_6chains/node287_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_4_0 -p 887 -st none -pt topic287_4_0 -u 0.04718695222873148 > ./result_6chains/node287_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_5_0 -p 983 -st none -pt topic287_5_0 -u 0.04402847985613764 > ./result_6chains/node287_5_0.txt &
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
    "./result_6chains/node287_0_0.txt 90"
    "./result_6chains/node287_0_2.txt 90"
    "./result_6chains/node287_1_0.txt 89"
    "./result_6chains/node287_1_2.txt 89"
    "./result_6chains/node287_2_0.txt 88"
    "./result_6chains/node287_2_2.txt 88"
    "./result_6chains/node287_3_0.txt 87"
    "./result_6chains/node287_3_2.txt 87"
    "./result_6chains/node287_4_0.txt 86"
    "./result_6chains/node287_4_2.txt 86"
    "./result_6chains/node287_5_0.txt 85"
    "./result_6chains/node287_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
