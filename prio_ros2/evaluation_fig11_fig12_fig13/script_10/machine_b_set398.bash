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
ros2 run evaluation_3_randomdag uunifast_node -n node398_0_1 -p 14 -st topic398_0_0 -pt topic398_0_1 -u 0.008692302730909818 > ./result_10chains/node398_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_1_1 -p 36 -st topic398_1_0 -pt topic398_1_1 -u 0.0018247868263577827 > ./result_10chains/node398_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_2_1 -p 83 -st topic398_2_0 -pt topic398_2_1 -u 0.016179305256631027 > ./result_10chains/node398_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_3_1 -p 101 -st topic398_3_0 -pt topic398_3_1 -u 0.035698326895098054 > ./result_10chains/node398_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_4_1 -p 193 -st topic398_4_0 -pt topic398_4_1 -u 0.014848154802684421 > ./result_10chains/node398_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_5_1 -p 206 -st topic398_5_0 -pt topic398_5_1 -u 0.010808888248708987 > ./result_10chains/node398_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_6_1 -p 369 -st topic398_6_0 -pt topic398_6_1 -u 0.00015877333893030143 > ./result_10chains/node398_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_7_1 -p 673 -st topic398_7_0 -pt topic398_7_1 -u 0.056100050376908364 > ./result_10chains/node398_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_8_1 -p 900 -st topic398_8_0 -pt topic398_8_1 -u 0.05388532528021933 > ./result_10chains/node398_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_9_1 -p 983 -st topic398_9_0 -pt topic398_9_1 -u 0.02182412370433631 > ./result_10chains/node398_9_1.txt &
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
    "./result_10chains/node398_0_1.txt 90"
    "./result_10chains/node398_1_1.txt 89"
    "./result_10chains/node398_2_1.txt 88"
    "./result_10chains/node398_3_1.txt 87"
    "./result_10chains/node398_4_1.txt 86"
    "./result_10chains/node398_5_1.txt 85"
    "./result_10chains/node398_6_1.txt 84"
    "./result_10chains/node398_7_1.txt 83"
    "./result_10chains/node398_8_1.txt 82"
    "./result_10chains/node398_9_1.txt 81"
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
