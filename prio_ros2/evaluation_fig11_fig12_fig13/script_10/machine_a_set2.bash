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
ros2 run evaluation_3_randomdag uunifast_node -n node2_0_2 -p 58 -st topic2_0_1 -pt None -u 0.0003666976629105867 > ./result_10chains/node2_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_1_2 -p 90 -st topic2_1_1 -pt None -u 0.024905005729788376 > ./result_10chains/node2_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_2_2 -p 178 -st topic2_2_1 -pt None -u 0.003729395687103121 > ./result_10chains/node2_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_3_2 -p 241 -st topic2_3_1 -pt None -u 0.006980687454543277 > ./result_10chains/node2_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_4_2 -p 275 -st topic2_4_1 -pt None -u 0.007858929455298203 > ./result_10chains/node2_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_5_2 -p 648 -st topic2_5_1 -pt None -u 0.0022123528546192928 > ./result_10chains/node2_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_6_2 -p 680 -st topic2_6_1 -pt None -u 0.004145542752552189 > ./result_10chains/node2_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_7_2 -p 831 -st topic2_7_1 -pt None -u 0.013385253008910025 > ./result_10chains/node2_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_8_2 -p 842 -st topic2_8_1 -pt None -u 0.014756051582517513 > ./result_10chains/node2_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_9_2 -p 975 -st topic2_9_1 -pt None -u 0.03734093297420996 > ./result_10chains/node2_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_0_0 -p 58 -st none -pt topic2_0_0 -u 0.0063299079959293625 > ./result_10chains/node2_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_1_0 -p 90 -st none -pt topic2_1_0 -u 0.01856022325711698 > ./result_10chains/node2_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_2_0 -p 178 -st none -pt topic2_2_0 -u 0.015161151647590965 > ./result_10chains/node2_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_3_0 -p 241 -st none -pt topic2_3_0 -u 0.03463906351282825 > ./result_10chains/node2_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_4_0 -p 275 -st none -pt topic2_4_0 -u 0.013861266211907697 > ./result_10chains/node2_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_5_0 -p 648 -st none -pt topic2_5_0 -u 0.009655562272216367 > ./result_10chains/node2_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_6_0 -p 680 -st none -pt topic2_6_0 -u 0.0031508568312104135 > ./result_10chains/node2_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_7_0 -p 831 -st none -pt topic2_7_0 -u 0.01675290089897047 > ./result_10chains/node2_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node2_8_0 -p 842 -st none -pt topic2_8_0 -u 0.05255298350845802 > ./result_10chains/node2_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node2_9_0 -p 975 -st none -pt topic2_9_0 -u 0.03572852235392599 > ./result_10chains/node2_9_0.txt &
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
    "./result_10chains/node2_0_0.txt 90"
    "./result_10chains/node2_0_2.txt 90"
    "./result_10chains/node2_1_0.txt 89"
    "./result_10chains/node2_1_2.txt 89"
    "./result_10chains/node2_2_0.txt 88"
    "./result_10chains/node2_2_2.txt 88"
    "./result_10chains/node2_3_0.txt 87"
    "./result_10chains/node2_3_2.txt 87"
    "./result_10chains/node2_4_0.txt 86"
    "./result_10chains/node2_4_2.txt 86"
    "./result_10chains/node2_5_0.txt 85"
    "./result_10chains/node2_5_2.txt 85"
    "./result_10chains/node2_6_0.txt 84"
    "./result_10chains/node2_6_2.txt 84"
    "./result_10chains/node2_7_0.txt 83"
    "./result_10chains/node2_7_2.txt 83"
    "./result_10chains/node2_8_0.txt 82"
    "./result_10chains/node2_8_2.txt 82"
    "./result_10chains/node2_9_0.txt 81"
    "./result_10chains/node2_9_2.txt 81"
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
