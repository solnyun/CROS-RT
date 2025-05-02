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
ros2 run evaluation_3_randomdag uunifast_node -n node487_0_2 -p 310 -st topic487_0_1 -pt None -u 0.013835739562985172 > ./result_6chains/node487_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_1_2 -p 341 -st topic487_1_1 -pt None -u 0.002207761108647288 > ./result_6chains/node487_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_2_2 -p 362 -st topic487_2_1 -pt None -u 0.04064620479387385 > ./result_6chains/node487_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_3_2 -p 540 -st topic487_3_1 -pt None -u 0.011793490829580283 > ./result_6chains/node487_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_4_2 -p 887 -st topic487_4_1 -pt None -u 0.003671488858410246 > ./result_6chains/node487_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_5_2 -p 955 -st topic487_5_1 -pt None -u 0.024149663600712398 > ./result_6chains/node487_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_0_0 -p 310 -st none -pt topic487_0_0 -u 0.017554760595714425 > ./result_6chains/node487_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_1_0 -p 341 -st none -pt topic487_1_0 -u 0.03842945667314068 > ./result_6chains/node487_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_2_0 -p 362 -st none -pt topic487_2_0 -u 0.1294749698047123 > ./result_6chains/node487_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_3_0 -p 540 -st none -pt topic487_3_0 -u 0.014657431944839594 > ./result_6chains/node487_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_4_0 -p 887 -st none -pt topic487_4_0 -u 0.048730412252484076 > ./result_6chains/node487_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_5_0 -p 955 -st none -pt topic487_5_0 -u 0.03933072098572171 > ./result_6chains/node487_5_0.txt &
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
    "./result_6chains/node487_0_0.txt 90"
    "./result_6chains/node487_0_2.txt 90"
    "./result_6chains/node487_1_0.txt 89"
    "./result_6chains/node487_1_2.txt 89"
    "./result_6chains/node487_2_0.txt 88"
    "./result_6chains/node487_2_2.txt 88"
    "./result_6chains/node487_3_0.txt 87"
    "./result_6chains/node487_3_2.txt 87"
    "./result_6chains/node487_4_0.txt 86"
    "./result_6chains/node487_4_2.txt 86"
    "./result_6chains/node487_5_0.txt 85"
    "./result_6chains/node487_5_2.txt 85"
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
