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
ros2 run evaluation_3_randomdag uunifast_node -n node479_0_2 -p 317 -st topic479_0_1 -pt None -u 0.008028381530176765 > ./result_6chains/node479_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_1_2 -p 427 -st topic479_1_1 -pt None -u 0.01370154432041032 > ./result_6chains/node479_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_2_2 -p 556 -st topic479_2_1 -pt None -u 0.00961868749269884 > ./result_6chains/node479_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_3_2 -p 763 -st topic479_3_1 -pt None -u 0.10618079507930515 > ./result_6chains/node479_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_4_2 -p 885 -st topic479_4_1 -pt None -u 0.04449393280967099 > ./result_6chains/node479_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_5_2 -p 953 -st topic479_5_1 -pt None -u 0.0022819127123309335 > ./result_6chains/node479_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_0_0 -p 317 -st none -pt topic479_0_0 -u 0.00810246802658432 > ./result_6chains/node479_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_1_0 -p 427 -st none -pt topic479_1_0 -u 0.05742259620731338 > ./result_6chains/node479_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_2_0 -p 556 -st none -pt topic479_2_0 -u 0.011701300757097854 > ./result_6chains/node479_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_3_0 -p 763 -st none -pt topic479_3_0 -u 0.04682672820956141 > ./result_6chains/node479_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_4_0 -p 885 -st none -pt topic479_4_0 -u 0.004021249834406632 > ./result_6chains/node479_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node479_5_0 -p 953 -st none -pt topic479_5_0 -u 0.022354152031252784 > ./result_6chains/node479_5_0.txt &
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
    "./result_6chains/node479_0_0.txt 90"
    "./result_6chains/node479_0_2.txt 90"
    "./result_6chains/node479_1_0.txt 89"
    "./result_6chains/node479_1_2.txt 89"
    "./result_6chains/node479_2_0.txt 88"
    "./result_6chains/node479_2_2.txt 88"
    "./result_6chains/node479_3_0.txt 87"
    "./result_6chains/node479_3_2.txt 87"
    "./result_6chains/node479_4_0.txt 86"
    "./result_6chains/node479_4_2.txt 86"
    "./result_6chains/node479_5_0.txt 85"
    "./result_6chains/node479_5_2.txt 85"
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
