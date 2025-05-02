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
ros2 run evaluation_3_randomdag uunifast_node -n node320_0_1 -p 67 -st topic320_0_0 -pt topic320_0_1 -u 0.023133196787042898 > ./result_10chains/node320_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_1_1 -p 289 -st topic320_1_0 -pt topic320_1_1 -u 0.004965741385029143 > ./result_10chains/node320_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_2_1 -p 303 -st topic320_2_0 -pt topic320_2_1 -u 0.02206517244354117 > ./result_10chains/node320_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_3_1 -p 362 -st topic320_3_0 -pt topic320_3_1 -u 0.014334235487596547 > ./result_10chains/node320_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_4_1 -p 640 -st topic320_4_0 -pt topic320_4_1 -u 0.0351277129656678 > ./result_10chains/node320_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_5_1 -p 721 -st topic320_5_0 -pt topic320_5_1 -u 0.020322971436227577 > ./result_10chains/node320_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_6_1 -p 737 -st topic320_6_0 -pt topic320_6_1 -u 0.0042569740413887225 > ./result_10chains/node320_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_7_1 -p 923 -st topic320_7_0 -pt topic320_7_1 -u 0.034856442467796 > ./result_10chains/node320_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_8_1 -p 943 -st topic320_8_0 -pt topic320_8_1 -u 0.012625206701750165 > ./result_10chains/node320_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_9_1 -p 960 -st topic320_9_0 -pt topic320_9_1 -u 0.0044205223207844525 > ./result_10chains/node320_9_1.txt &
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
    "./result_10chains/node320_0_1.txt 90"
    "./result_10chains/node320_1_1.txt 89"
    "./result_10chains/node320_2_1.txt 88"
    "./result_10chains/node320_3_1.txt 87"
    "./result_10chains/node320_4_1.txt 86"
    "./result_10chains/node320_5_1.txt 85"
    "./result_10chains/node320_6_1.txt 84"
    "./result_10chains/node320_7_1.txt 83"
    "./result_10chains/node320_8_1.txt 82"
    "./result_10chains/node320_9_1.txt 81"
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
