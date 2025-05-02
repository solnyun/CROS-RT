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
ros2 run evaluation_3_randomdag uunifast_node -n node493_0_2 -p 96 -st topic493_0_1 -pt None -u 0.0015515667540695888 > ./result_8chains/node493_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_1_2 -p 124 -st topic493_1_1 -pt None -u 0.015460434891343633 > ./result_8chains/node493_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_2_2 -p 408 -st topic493_2_1 -pt None -u 0.005186659820171469 > ./result_8chains/node493_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_3_2 -p 586 -st topic493_3_1 -pt None -u 0.004597483866450813 > ./result_8chains/node493_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_4_2 -p 702 -st topic493_4_1 -pt None -u 0.014034314986994673 > ./result_8chains/node493_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_5_2 -p 860 -st topic493_5_1 -pt None -u 0.04408553780182864 > ./result_8chains/node493_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_6_2 -p 865 -st topic493_6_1 -pt None -u 0.02000180094001136 > ./result_8chains/node493_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_7_2 -p 966 -st topic493_7_1 -pt None -u 0.02529587253855499 > ./result_8chains/node493_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_0_0 -p 96 -st none -pt topic493_0_0 -u 0.0131780577597444 > ./result_8chains/node493_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_1_0 -p 124 -st none -pt topic493_1_0 -u 0.0029371869995153954 > ./result_8chains/node493_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_2_0 -p 408 -st none -pt topic493_2_0 -u 0.02092547414567031 > ./result_8chains/node493_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_3_0 -p 586 -st none -pt topic493_3_0 -u 0.027141437216432474 > ./result_8chains/node493_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_4_0 -p 702 -st none -pt topic493_4_0 -u 0.04161826623064899 > ./result_8chains/node493_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_5_0 -p 860 -st none -pt topic493_5_0 -u 0.002924053659270509 > ./result_8chains/node493_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_6_0 -p 865 -st none -pt topic493_6_0 -u 0.002427825004665929 > ./result_8chains/node493_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_7_0 -p 966 -st none -pt topic493_7_0 -u 0.04772831379050117 > ./result_8chains/node493_7_0.txt &
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
    "./result_8chains/node493_0_0.txt 90"
    "./result_8chains/node493_0_2.txt 90"
    "./result_8chains/node493_1_0.txt 89"
    "./result_8chains/node493_1_2.txt 89"
    "./result_8chains/node493_2_0.txt 88"
    "./result_8chains/node493_2_2.txt 88"
    "./result_8chains/node493_3_0.txt 87"
    "./result_8chains/node493_3_2.txt 87"
    "./result_8chains/node493_4_0.txt 86"
    "./result_8chains/node493_4_2.txt 86"
    "./result_8chains/node493_5_0.txt 85"
    "./result_8chains/node493_5_2.txt 85"
    "./result_8chains/node493_6_0.txt 84"
    "./result_8chains/node493_6_2.txt 84"
    "./result_8chains/node493_7_0.txt 83"
    "./result_8chains/node493_7_2.txt 83"
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
