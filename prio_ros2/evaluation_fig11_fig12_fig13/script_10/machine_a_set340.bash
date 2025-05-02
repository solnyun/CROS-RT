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
ros2 run evaluation_3_randomdag uunifast_node -n node340_0_2 -p 84 -st topic340_0_1 -pt None -u 0.05173780853939369 > ./result_10chains/node340_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_1_2 -p 121 -st topic340_1_1 -pt None -u 0.04929725243291894 > ./result_10chains/node340_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_2_2 -p 324 -st topic340_2_1 -pt None -u 0.020138790383605665 > ./result_10chains/node340_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_3_2 -p 452 -st topic340_3_1 -pt None -u 0.005904894949832734 > ./result_10chains/node340_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_4_2 -p 474 -st topic340_4_1 -pt None -u 0.01255864739735471 > ./result_10chains/node340_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_5_2 -p 569 -st topic340_5_1 -pt None -u 0.002057292582704512 > ./result_10chains/node340_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_6_2 -p 691 -st topic340_6_1 -pt None -u 0.005003308722323324 > ./result_10chains/node340_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_7_2 -p 788 -st topic340_7_1 -pt None -u 0.01917532641062552 > ./result_10chains/node340_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_8_2 -p 803 -st topic340_8_1 -pt None -u 0.0011286982822110454 > ./result_10chains/node340_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_9_2 -p 855 -st topic340_9_1 -pt None -u 0.0006233237297086923 > ./result_10chains/node340_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_0_0 -p 84 -st none -pt topic340_0_0 -u 0.0012789962443054415 > ./result_10chains/node340_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_1_0 -p 121 -st none -pt topic340_1_0 -u 0.04759784822598251 > ./result_10chains/node340_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_2_0 -p 324 -st none -pt topic340_2_0 -u 0.010990046573604084 > ./result_10chains/node340_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_3_0 -p 452 -st none -pt topic340_3_0 -u 0.0018586544142019934 > ./result_10chains/node340_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_4_0 -p 474 -st none -pt topic340_4_0 -u 0.030180659362898238 > ./result_10chains/node340_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_5_0 -p 569 -st none -pt topic340_5_0 -u 0.012483923200970776 > ./result_10chains/node340_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_6_0 -p 691 -st none -pt topic340_6_0 -u 0.016706182384471857 > ./result_10chains/node340_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_7_0 -p 788 -st none -pt topic340_7_0 -u 0.016943904933791124 > ./result_10chains/node340_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_8_0 -p 803 -st none -pt topic340_8_0 -u 0.0044817708191538415 > ./result_10chains/node340_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_9_0 -p 855 -st none -pt topic340_9_0 -u 0.003987137791449316 > ./result_10chains/node340_9_0.txt &
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
    "./result_10chains/node340_0_0.txt 90"
    "./result_10chains/node340_0_2.txt 90"
    "./result_10chains/node340_1_0.txt 89"
    "./result_10chains/node340_1_2.txt 89"
    "./result_10chains/node340_2_0.txt 88"
    "./result_10chains/node340_2_2.txt 88"
    "./result_10chains/node340_3_0.txt 87"
    "./result_10chains/node340_3_2.txt 87"
    "./result_10chains/node340_4_0.txt 86"
    "./result_10chains/node340_4_2.txt 86"
    "./result_10chains/node340_5_0.txt 85"
    "./result_10chains/node340_5_2.txt 85"
    "./result_10chains/node340_6_0.txt 84"
    "./result_10chains/node340_6_2.txt 84"
    "./result_10chains/node340_7_0.txt 83"
    "./result_10chains/node340_7_2.txt 83"
    "./result_10chains/node340_8_0.txt 82"
    "./result_10chains/node340_8_2.txt 82"
    "./result_10chains/node340_9_0.txt 81"
    "./result_10chains/node340_9_2.txt 81"
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
