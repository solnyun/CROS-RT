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
ros2 run evaluation_3_randomdag uunifast_node -n node49_0_2 -p 184 -st topic49_0_1 -pt None -u 0.020385514163178464 > ./result_6chains/node49_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_1_2 -p 244 -st topic49_1_1 -pt None -u 0.006161683592920908 > ./result_6chains/node49_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_2_2 -p 295 -st topic49_2_1 -pt None -u 0.0019150842259959555 > ./result_6chains/node49_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_3_2 -p 738 -st topic49_3_1 -pt None -u 0.04570674145462092 > ./result_6chains/node49_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_4_2 -p 782 -st topic49_4_1 -pt None -u 0.02112418189731083 > ./result_6chains/node49_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_5_2 -p 884 -st topic49_5_1 -pt None -u 0.04018738239590263 > ./result_6chains/node49_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_0_0 -p 184 -st none -pt topic49_0_0 -u 0.011521929804156061 > ./result_6chains/node49_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_1_0 -p 244 -st none -pt topic49_1_0 -u 0.016089007137075617 > ./result_6chains/node49_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_2_0 -p 295 -st none -pt topic49_2_0 -u 0.13468641975043727 > ./result_6chains/node49_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_3_0 -p 738 -st none -pt topic49_3_0 -u 0.07418628227829172 > ./result_6chains/node49_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_4_0 -p 782 -st none -pt topic49_4_0 -u 0.0038867987367961765 > ./result_6chains/node49_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_5_0 -p 884 -st none -pt topic49_5_0 -u 0.05909830124894596 > ./result_6chains/node49_5_0.txt &
sleep 10
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
    "./result_6chains/node49_0_0.txt 90"
    "./result_6chains/node49_0_2.txt 90"
    "./result_6chains/node49_1_0.txt 89"
    "./result_6chains/node49_1_2.txt 89"
    "./result_6chains/node49_2_0.txt 88"
    "./result_6chains/node49_2_2.txt 88"
    "./result_6chains/node49_3_0.txt 87"
    "./result_6chains/node49_3_2.txt 87"
    "./result_6chains/node49_4_0.txt 86"
    "./result_6chains/node49_4_2.txt 86"
    "./result_6chains/node49_5_0.txt 85"
    "./result_6chains/node49_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
