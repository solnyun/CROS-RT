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
ros2 run evaluation_3_randomdag uunifast_node -n node226_0_1 -p 191 -st topic226_0_0 -pt topic226_0_1 -u 0.045009833159228796 > ./result_10chains/node226_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_1_1 -p 270 -st topic226_1_0 -pt topic226_1_1 -u 0.014139131825938678 > ./result_10chains/node226_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_2_1 -p 343 -st topic226_2_0 -pt topic226_2_1 -u 0.014718723323482397 > ./result_10chains/node226_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_3_1 -p 416 -st topic226_3_0 -pt topic226_3_1 -u 1.9907533594432092e-05 > ./result_10chains/node226_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_4_1 -p 523 -st topic226_4_0 -pt topic226_4_1 -u 0.002987508846465814 > ./result_10chains/node226_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_5_1 -p 555 -st topic226_5_0 -pt topic226_5_1 -u 0.020903838018846488 > ./result_10chains/node226_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_6_1 -p 567 -st topic226_6_0 -pt topic226_6_1 -u 0.020629737781223095 > ./result_10chains/node226_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_7_1 -p 775 -st topic226_7_0 -pt topic226_7_1 -u 0.014141754663541187 > ./result_10chains/node226_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_8_1 -p 811 -st topic226_8_0 -pt topic226_8_1 -u 0.005795819768356886 > ./result_10chains/node226_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node226_9_1 -p 960 -st topic226_9_0 -pt topic226_9_1 -u 0.0073191981632626454 > ./result_10chains/node226_9_1.txt &
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
    "./result_10chains/node226_0_1.txt 90"
    "./result_10chains/node226_1_1.txt 89"
    "./result_10chains/node226_2_1.txt 88"
    "./result_10chains/node226_3_1.txt 87"
    "./result_10chains/node226_4_1.txt 86"
    "./result_10chains/node226_5_1.txt 85"
    "./result_10chains/node226_6_1.txt 84"
    "./result_10chains/node226_7_1.txt 83"
    "./result_10chains/node226_8_1.txt 82"
    "./result_10chains/node226_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
