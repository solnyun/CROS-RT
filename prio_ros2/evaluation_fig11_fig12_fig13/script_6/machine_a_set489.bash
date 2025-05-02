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
ros2 run evaluation_3_randomdag uunifast_node -n node489_0_2 -p 235 -st topic489_0_1 -pt None -u 0.04986996449889586 > ./result_6chains/node489_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_1_2 -p 306 -st topic489_1_1 -pt None -u 0.035006521941156665 > ./result_6chains/node489_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_2_2 -p 369 -st topic489_2_1 -pt None -u 0.03955517589903687 > ./result_6chains/node489_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_3_2 -p 709 -st topic489_3_1 -pt None -u 0.030577800807405076 > ./result_6chains/node489_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_4_2 -p 757 -st topic489_4_1 -pt None -u 0.010601818911224574 > ./result_6chains/node489_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_5_2 -p 960 -st topic489_5_1 -pt None -u 0.0015613308433723365 > ./result_6chains/node489_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_0_0 -p 235 -st none -pt topic489_0_0 -u 0.013788223719761461 > ./result_6chains/node489_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_1_0 -p 306 -st none -pt topic489_1_0 -u 0.005474394630047841 > ./result_6chains/node489_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_2_0 -p 369 -st none -pt topic489_2_0 -u 0.016756757539414746 > ./result_6chains/node489_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_3_0 -p 709 -st none -pt topic489_3_0 -u 0.05243094935252171 > ./result_6chains/node489_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_4_0 -p 757 -st none -pt topic489_4_0 -u 0.06437644241229544 > ./result_6chains/node489_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_5_0 -p 960 -st none -pt topic489_5_0 -u 0.024666357117029282 > ./result_6chains/node489_5_0.txt &
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
    "./result_6chains/node489_0_0.txt 90"
    "./result_6chains/node489_0_2.txt 90"
    "./result_6chains/node489_1_0.txt 89"
    "./result_6chains/node489_1_2.txt 89"
    "./result_6chains/node489_2_0.txt 88"
    "./result_6chains/node489_2_2.txt 88"
    "./result_6chains/node489_3_0.txt 87"
    "./result_6chains/node489_3_2.txt 87"
    "./result_6chains/node489_4_0.txt 86"
    "./result_6chains/node489_4_2.txt 86"
    "./result_6chains/node489_5_0.txt 85"
    "./result_6chains/node489_5_2.txt 85"
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
