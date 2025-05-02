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
ros2 run evaluation_3_randomdag uunifast_node -n node376_0_2 -p 36 -st topic376_0_1 -pt None -u 0.03711965733167377 > ./result_8chains/node376_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_1_2 -p 144 -st topic376_1_1 -pt None -u 0.05303467735824419 > ./result_8chains/node376_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_2_2 -p 166 -st topic376_2_1 -pt None -u 0.0060788896974777185 > ./result_8chains/node376_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_3_2 -p 234 -st topic376_3_1 -pt None -u 0.005235974320310394 > ./result_8chains/node376_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_4_2 -p 299 -st topic376_4_1 -pt None -u 0.0021124944076823804 > ./result_8chains/node376_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_5_2 -p 380 -st topic376_5_1 -pt None -u 0.011676266356021758 > ./result_8chains/node376_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_6_2 -p 662 -st topic376_6_1 -pt None -u 0.00522150396463511 > ./result_8chains/node376_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_7_2 -p 719 -st topic376_7_1 -pt None -u 0.03470851219067564 > ./result_8chains/node376_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_0_0 -p 36 -st none -pt topic376_0_0 -u 0.024479974487307155 > ./result_8chains/node376_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_1_0 -p 144 -st none -pt topic376_1_0 -u 0.009278024295649001 > ./result_8chains/node376_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_2_0 -p 166 -st none -pt topic376_2_0 -u 0.016867869439773253 > ./result_8chains/node376_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_3_0 -p 234 -st none -pt topic376_3_0 -u 0.04980461804209027 > ./result_8chains/node376_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_4_0 -p 299 -st none -pt topic376_4_0 -u 0.010655137173883916 > ./result_8chains/node376_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_5_0 -p 380 -st none -pt topic376_5_0 -u 0.017303315723870116 > ./result_8chains/node376_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node376_6_0 -p 662 -st none -pt topic376_6_0 -u 0.02708073725952026 > ./result_8chains/node376_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node376_7_0 -p 719 -st none -pt topic376_7_0 -u 0.0061605439284799154 > ./result_8chains/node376_7_0.txt &
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
    "./result_8chains/node376_0_0.txt 90"
    "./result_8chains/node376_0_2.txt 90"
    "./result_8chains/node376_1_0.txt 89"
    "./result_8chains/node376_1_2.txt 89"
    "./result_8chains/node376_2_0.txt 88"
    "./result_8chains/node376_2_2.txt 88"
    "./result_8chains/node376_3_0.txt 87"
    "./result_8chains/node376_3_2.txt 87"
    "./result_8chains/node376_4_0.txt 86"
    "./result_8chains/node376_4_2.txt 86"
    "./result_8chains/node376_5_0.txt 85"
    "./result_8chains/node376_5_2.txt 85"
    "./result_8chains/node376_6_0.txt 84"
    "./result_8chains/node376_6_2.txt 84"
    "./result_8chains/node376_7_0.txt 83"
    "./result_8chains/node376_7_2.txt 83"
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
