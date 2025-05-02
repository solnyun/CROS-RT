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
ros2 run evaluation_3_randomdag uunifast_node -n node123_0_2 -p 333 -st topic123_0_1 -pt None -u 0.005543471982528192 > ./result_4chains/node123_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_1_2 -p 442 -st topic123_1_1 -pt None -u 0.0063062068227744406 > ./result_4chains/node123_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_2_2 -p 730 -st topic123_2_1 -pt None -u 0.0227264162612541 > ./result_4chains/node123_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_3_2 -p 980 -st topic123_3_1 -pt None -u 0.05697694102967382 > ./result_4chains/node123_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_0_0 -p 333 -st none -pt topic123_0_0 -u 0.020390742120563077 > ./result_4chains/node123_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_1_0 -p 442 -st none -pt topic123_1_0 -u 0.11996920390077165 > ./result_4chains/node123_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_2_0 -p 730 -st none -pt topic123_2_0 -u 0.07574747373952678 > ./result_4chains/node123_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_3_0 -p 980 -st none -pt topic123_3_0 -u 0.012615644989595276 > ./result_4chains/node123_3_0.txt &
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
    "./result_4chains/node123_0_0.txt 90"
    "./result_4chains/node123_0_2.txt 90"
    "./result_4chains/node123_1_0.txt 89"
    "./result_4chains/node123_1_2.txt 89"
    "./result_4chains/node123_2_0.txt 88"
    "./result_4chains/node123_2_2.txt 88"
    "./result_4chains/node123_3_0.txt 87"
    "./result_4chains/node123_3_2.txt 87"
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
