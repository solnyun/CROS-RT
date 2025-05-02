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
ros2 run evaluation_3_randomdag uunifast_node -n node332_0_2 -p 137 -st topic332_0_1 -pt None -u 0.10410957197477194 > ./result_4chains/node332_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_1_2 -p 486 -st topic332_1_1 -pt None -u 0.010775836559179242 > ./result_4chains/node332_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_2_2 -p 686 -st topic332_2_1 -pt None -u 0.05614743472362935 > ./result_4chains/node332_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_3_2 -p 718 -st topic332_3_1 -pt None -u 0.09545578764506919 > ./result_4chains/node332_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_0_0 -p 137 -st none -pt topic332_0_0 -u 0.000165459149891245 > ./result_4chains/node332_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_1_0 -p 486 -st none -pt topic332_1_0 -u 0.04085425950790228 > ./result_4chains/node332_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_2_0 -p 686 -st none -pt topic332_2_0 -u 0.0005436992357845116 > ./result_4chains/node332_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node332_3_0 -p 718 -st none -pt topic332_3_0 -u 0.05722737440454846 > ./result_4chains/node332_3_0.txt &
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
    "./result_4chains/node332_0_0.txt 90"
    "./result_4chains/node332_0_2.txt 90"
    "./result_4chains/node332_1_0.txt 89"
    "./result_4chains/node332_1_2.txt 89"
    "./result_4chains/node332_2_0.txt 88"
    "./result_4chains/node332_2_2.txt 88"
    "./result_4chains/node332_3_0.txt 87"
    "./result_4chains/node332_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
