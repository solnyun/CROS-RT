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
ros2 run evaluation_3_randomdag uunifast_node -n node164_0_2 -p 432 -st topic164_0_1 -pt None -u 0.017216377025210228 > ./result_8chains/node164_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_1_2 -p 493 -st topic164_1_1 -pt None -u 0.010623685835605023 > ./result_8chains/node164_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_2_2 -p 497 -st topic164_2_1 -pt None -u 0.0030793213621311266 > ./result_8chains/node164_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_3_2 -p 514 -st topic164_3_1 -pt None -u 0.004534342935103519 > ./result_8chains/node164_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_4_2 -p 755 -st topic164_4_1 -pt None -u 0.0015452191238046198 > ./result_8chains/node164_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_5_2 -p 782 -st topic164_5_1 -pt None -u 0.031976686186328235 > ./result_8chains/node164_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_6_2 -p 948 -st topic164_6_1 -pt None -u 0.004972926062627725 > ./result_8chains/node164_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_7_2 -p 960 -st topic164_7_1 -pt None -u 0.07104424345448641 > ./result_8chains/node164_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_0_0 -p 432 -st none -pt topic164_0_0 -u 0.017258773699910912 > ./result_8chains/node164_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_1_0 -p 493 -st none -pt topic164_1_0 -u 0.0004180651299857119 > ./result_8chains/node164_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_2_0 -p 497 -st none -pt topic164_2_0 -u 0.03500383700627907 > ./result_8chains/node164_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_3_0 -p 514 -st none -pt topic164_3_0 -u 0.005386886250533629 > ./result_8chains/node164_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_4_0 -p 755 -st none -pt topic164_4_0 -u 0.02648230501004062 > ./result_8chains/node164_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_5_0 -p 782 -st none -pt topic164_5_0 -u 0.038463588186648856 > ./result_8chains/node164_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_6_0 -p 948 -st none -pt topic164_6_0 -u 0.0025235066699073605 > ./result_8chains/node164_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node164_7_0 -p 960 -st none -pt topic164_7_0 -u 0.05958657546779156 > ./result_8chains/node164_7_0.txt &
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
    "./result_8chains/node164_0_0.txt 90"
    "./result_8chains/node164_0_2.txt 90"
    "./result_8chains/node164_1_0.txt 89"
    "./result_8chains/node164_1_2.txt 89"
    "./result_8chains/node164_2_0.txt 88"
    "./result_8chains/node164_2_2.txt 88"
    "./result_8chains/node164_3_0.txt 87"
    "./result_8chains/node164_3_2.txt 87"
    "./result_8chains/node164_4_0.txt 86"
    "./result_8chains/node164_4_2.txt 86"
    "./result_8chains/node164_5_0.txt 85"
    "./result_8chains/node164_5_2.txt 85"
    "./result_8chains/node164_6_0.txt 84"
    "./result_8chains/node164_6_2.txt 84"
    "./result_8chains/node164_7_0.txt 83"
    "./result_8chains/node164_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
