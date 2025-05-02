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
ros2 run evaluation_3_randomdag uunifast_node -n node81_0_2 -p 130 -st topic81_0_1 -pt None -u 0.050891337846822204 > ./result_6chains/node81_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_1_2 -p 235 -st topic81_1_1 -pt None -u 0.013783650982877538 > ./result_6chains/node81_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_2_2 -p 330 -st topic81_2_1 -pt None -u 0.05139929664580409 > ./result_6chains/node81_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_3_2 -p 556 -st topic81_3_1 -pt None -u 0.011214913967480367 > ./result_6chains/node81_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_4_2 -p 721 -st topic81_4_1 -pt None -u 0.009580429997475548 > ./result_6chains/node81_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_5_2 -p 878 -st topic81_5_1 -pt None -u 0.022701847767737968 > ./result_6chains/node81_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_0_0 -p 130 -st none -pt topic81_0_0 -u 0.011157638142240967 > ./result_6chains/node81_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_1_0 -p 235 -st none -pt topic81_1_0 -u 0.0072225085364602815 > ./result_6chains/node81_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_2_0 -p 330 -st none -pt topic81_2_0 -u 0.03353429637771477 > ./result_6chains/node81_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_3_0 -p 556 -st none -pt topic81_3_0 -u 0.0016497248764842098 > ./result_6chains/node81_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_4_0 -p 721 -st none -pt topic81_4_0 -u 0.09698067429255786 > ./result_6chains/node81_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_5_0 -p 878 -st none -pt topic81_5_0 -u 0.026975638530884066 > ./result_6chains/node81_5_0.txt &
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
    "./result_6chains/node81_0_0.txt 90"
    "./result_6chains/node81_0_2.txt 90"
    "./result_6chains/node81_1_0.txt 89"
    "./result_6chains/node81_1_2.txt 89"
    "./result_6chains/node81_2_0.txt 88"
    "./result_6chains/node81_2_2.txt 88"
    "./result_6chains/node81_3_0.txt 87"
    "./result_6chains/node81_3_2.txt 87"
    "./result_6chains/node81_4_0.txt 86"
    "./result_6chains/node81_4_2.txt 86"
    "./result_6chains/node81_5_0.txt 85"
    "./result_6chains/node81_5_2.txt 85"
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
