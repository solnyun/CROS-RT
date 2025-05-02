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
ros2 run evaluation_3_randomdag uunifast_node -n node441_0_2 -p 238 -st topic441_0_1 -pt None -u 0.015054564738747611 > ./result_6chains/node441_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_1_2 -p 761 -st topic441_1_1 -pt None -u 0.02974960339529864 > ./result_6chains/node441_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_2_2 -p 767 -st topic441_2_1 -pt None -u 0.00408813153754195 > ./result_6chains/node441_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_3_2 -p 823 -st topic441_3_1 -pt None -u 0.0067124690949771915 > ./result_6chains/node441_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_4_2 -p 903 -st topic441_4_1 -pt None -u 0.050253471526321425 > ./result_6chains/node441_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_5_2 -p 914 -st topic441_5_1 -pt None -u 0.010276947998840007 > ./result_6chains/node441_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_0_0 -p 238 -st none -pt topic441_0_0 -u 0.01212019792356267 > ./result_6chains/node441_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_1_0 -p 761 -st none -pt topic441_1_0 -u 0.013323674033374422 > ./result_6chains/node441_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_2_0 -p 767 -st none -pt topic441_2_0 -u 0.004357529616432154 > ./result_6chains/node441_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_3_0 -p 823 -st none -pt topic441_3_0 -u 0.002128097962984271 > ./result_6chains/node441_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_4_0 -p 903 -st none -pt topic441_4_0 -u 0.018610946456616623 > ./result_6chains/node441_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node441_5_0 -p 914 -st none -pt topic441_5_0 -u 0.06442957877807362 > ./result_6chains/node441_5_0.txt &
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
    "./result_6chains/node441_0_0.txt 90"
    "./result_6chains/node441_0_2.txt 90"
    "./result_6chains/node441_1_0.txt 89"
    "./result_6chains/node441_1_2.txt 89"
    "./result_6chains/node441_2_0.txt 88"
    "./result_6chains/node441_2_2.txt 88"
    "./result_6chains/node441_3_0.txt 87"
    "./result_6chains/node441_3_2.txt 87"
    "./result_6chains/node441_4_0.txt 86"
    "./result_6chains/node441_4_2.txt 86"
    "./result_6chains/node441_5_0.txt 85"
    "./result_6chains/node441_5_2.txt 85"
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
