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
ros2 run evaluation_3_randomdag uunifast_node -n node56_0_2 -p 208 -st topic56_0_1 -pt None -u 0.017907030902953758 > ./result_6chains/node56_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_1_2 -p 241 -st topic56_1_1 -pt None -u 0.019031042532387465 > ./result_6chains/node56_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_2_2 -p 502 -st topic56_2_1 -pt None -u 0.03610310377346604 > ./result_6chains/node56_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_3_2 -p 776 -st topic56_3_1 -pt None -u 0.007552478773870025 > ./result_6chains/node56_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_4_2 -p 835 -st topic56_4_1 -pt None -u 0.03489781279883465 > ./result_6chains/node56_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_5_2 -p 928 -st topic56_5_1 -pt None -u 0.005738095937531787 > ./result_6chains/node56_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_0_0 -p 208 -st none -pt topic56_0_0 -u 0.09108960313724046 > ./result_6chains/node56_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_1_0 -p 241 -st none -pt topic56_1_0 -u 0.024808352932524536 > ./result_6chains/node56_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_2_0 -p 502 -st none -pt topic56_2_0 -u 0.03682426721122661 > ./result_6chains/node56_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_3_0 -p 776 -st none -pt topic56_3_0 -u 0.003462092471477357 > ./result_6chains/node56_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node56_4_0 -p 835 -st none -pt topic56_4_0 -u 0.006758228647210512 > ./result_6chains/node56_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node56_5_0 -p 928 -st none -pt topic56_5_0 -u 0.09652326875789718 > ./result_6chains/node56_5_0.txt &
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
    "./result_6chains/node56_0_0.txt 90"
    "./result_6chains/node56_0_2.txt 90"
    "./result_6chains/node56_1_0.txt 89"
    "./result_6chains/node56_1_2.txt 89"
    "./result_6chains/node56_2_0.txt 88"
    "./result_6chains/node56_2_2.txt 88"
    "./result_6chains/node56_3_0.txt 87"
    "./result_6chains/node56_3_2.txt 87"
    "./result_6chains/node56_4_0.txt 86"
    "./result_6chains/node56_4_2.txt 86"
    "./result_6chains/node56_5_0.txt 85"
    "./result_6chains/node56_5_2.txt 85"
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
