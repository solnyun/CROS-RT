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
ros2 run evaluation_3_randomdag uunifast_node -n node489_0_2 -p 147 -st topic489_0_1 -pt None -u 0.019344446865025844 > ./result_8chains/node489_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_1_2 -p 150 -st topic489_1_1 -pt None -u 0.011284309625469169 > ./result_8chains/node489_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_2_2 -p 283 -st topic489_2_1 -pt None -u 0.025221736551323537 > ./result_8chains/node489_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_3_2 -p 388 -st topic489_3_1 -pt None -u 0.03503655603791542 > ./result_8chains/node489_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_4_2 -p 778 -st topic489_4_1 -pt None -u 0.03116790342213485 > ./result_8chains/node489_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_5_2 -p 827 -st topic489_5_1 -pt None -u 0.010933098782872575 > ./result_8chains/node489_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_6_2 -p 834 -st topic489_6_1 -pt None -u 0.0018637086985202542 > ./result_8chains/node489_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_7_2 -p 992 -st topic489_7_1 -pt None -u 0.02481434133909398 > ./result_8chains/node489_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_0_0 -p 147 -st none -pt topic489_0_0 -u 0.03679580385915232 > ./result_8chains/node489_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_1_0 -p 150 -st none -pt topic489_1_0 -u 0.015685969019585133 > ./result_8chains/node489_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_2_0 -p 283 -st none -pt topic489_2_0 -u 0.007218680113666165 > ./result_8chains/node489_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_3_0 -p 388 -st none -pt topic489_3_0 -u 0.0021999416396008 > ./result_8chains/node489_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_4_0 -p 778 -st none -pt topic489_4_0 -u 0.02439151647814078 > ./result_8chains/node489_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_5_0 -p 827 -st none -pt topic489_5_0 -u 0.006231535369839364 > ./result_8chains/node489_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_6_0 -p 834 -st none -pt topic489_6_0 -u 0.04559909598229571 > ./result_8chains/node489_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_7_0 -p 992 -st none -pt topic489_7_0 -u 0.004198685931621676 > ./result_8chains/node489_7_0.txt &
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
    "./result_8chains/node489_0_0.txt 90"
    "./result_8chains/node489_0_2.txt 90"
    "./result_8chains/node489_1_0.txt 89"
    "./result_8chains/node489_1_2.txt 89"
    "./result_8chains/node489_2_0.txt 88"
    "./result_8chains/node489_2_2.txt 88"
    "./result_8chains/node489_3_0.txt 87"
    "./result_8chains/node489_3_2.txt 87"
    "./result_8chains/node489_4_0.txt 86"
    "./result_8chains/node489_4_2.txt 86"
    "./result_8chains/node489_5_0.txt 85"
    "./result_8chains/node489_5_2.txt 85"
    "./result_8chains/node489_6_0.txt 84"
    "./result_8chains/node489_6_2.txt 84"
    "./result_8chains/node489_7_0.txt 83"
    "./result_8chains/node489_7_2.txt 83"
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
