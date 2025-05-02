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
ros2 run evaluation_3_randomdag uunifast_node -n node158_0_2 -p 49 -st topic158_0_1 -pt None -u 0.030934856315338766 > ./result_4chains/node158_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_1_2 -p 232 -st topic158_1_1 -pt None -u 0.04982371818882875 > ./result_4chains/node158_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_2_2 -p 259 -st topic158_2_1 -pt None -u 0.0355075172938631 > ./result_4chains/node158_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_3_2 -p 635 -st topic158_3_1 -pt None -u 0.010712692785963438 > ./result_4chains/node158_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_0_0 -p 49 -st none -pt topic158_0_0 -u 0.08945295800475872 > ./result_4chains/node158_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_1_0 -p 232 -st none -pt topic158_1_0 -u 0.049607903671384845 > ./result_4chains/node158_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_2_0 -p 259 -st none -pt topic158_2_0 -u 0.01179789586772978 > ./result_4chains/node158_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_3_0 -p 635 -st none -pt topic158_3_0 -u 0.03951870102691244 > ./result_4chains/node158_3_0.txt &
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
    "./result_4chains/node158_0_0.txt 90"
    "./result_4chains/node158_0_2.txt 90"
    "./result_4chains/node158_1_0.txt 89"
    "./result_4chains/node158_1_2.txt 89"
    "./result_4chains/node158_2_0.txt 88"
    "./result_4chains/node158_2_2.txt 88"
    "./result_4chains/node158_3_0.txt 87"
    "./result_4chains/node158_3_2.txt 87"
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
