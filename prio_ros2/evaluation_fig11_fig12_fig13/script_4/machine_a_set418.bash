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
ros2 run evaluation_3_randomdag uunifast_node -n node418_0_2 -p 99 -st topic418_0_1 -pt None -u 0.0005350955260244872 > ./result_4chains/node418_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_1_2 -p 104 -st topic418_1_1 -pt None -u 0.026856010839725275 > ./result_4chains/node418_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_2_2 -p 343 -st topic418_2_1 -pt None -u 0.07146623071811599 > ./result_4chains/node418_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_3_2 -p 940 -st topic418_3_1 -pt None -u 0.01240145678478306 > ./result_4chains/node418_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_0_0 -p 99 -st none -pt topic418_0_0 -u 0.12442190103455025 > ./result_4chains/node418_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_1_0 -p 104 -st none -pt topic418_1_0 -u 0.10436824881034523 > ./result_4chains/node418_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_2_0 -p 343 -st none -pt topic418_2_0 -u 0.022874610196577327 > ./result_4chains/node418_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node418_3_0 -p 940 -st none -pt topic418_3_0 -u 0.028161477935671392 > ./result_4chains/node418_3_0.txt &
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
    "./result_4chains/node418_0_0.txt 90"
    "./result_4chains/node418_0_2.txt 90"
    "./result_4chains/node418_1_0.txt 89"
    "./result_4chains/node418_1_2.txt 89"
    "./result_4chains/node418_2_0.txt 88"
    "./result_4chains/node418_2_2.txt 88"
    "./result_4chains/node418_3_0.txt 87"
    "./result_4chains/node418_3_2.txt 87"
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
