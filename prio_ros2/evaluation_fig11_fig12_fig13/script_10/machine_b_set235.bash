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
ros2 run evaluation_3_randomdag uunifast_node -n node235_0_1 -p 35 -st topic235_0_0 -pt topic235_0_1 -u 0.00027335505657383186 > ./result_10chains/node235_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_1_1 -p 164 -st topic235_1_0 -pt topic235_1_1 -u 0.028035601848920233 > ./result_10chains/node235_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_2_1 -p 335 -st topic235_2_0 -pt topic235_2_1 -u 0.033728627274397516 > ./result_10chains/node235_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_3_1 -p 667 -st topic235_3_0 -pt topic235_3_1 -u 0.006572926428528247 > ./result_10chains/node235_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_4_1 -p 686 -st topic235_4_0 -pt topic235_4_1 -u 0.0021426396042630858 > ./result_10chains/node235_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_5_1 -p 687 -st topic235_5_0 -pt topic235_5_1 -u 0.010243257220838298 > ./result_10chains/node235_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_6_1 -p 766 -st topic235_6_0 -pt topic235_6_1 -u 0.008895546606932841 > ./result_10chains/node235_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_7_1 -p 830 -st topic235_7_0 -pt topic235_7_1 -u 0.02001794586676832 > ./result_10chains/node235_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_8_1 -p 860 -st topic235_8_0 -pt topic235_8_1 -u 0.011605525993589556 > ./result_10chains/node235_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_9_1 -p 929 -st topic235_9_0 -pt topic235_9_1 -u 0.0033644796066375944 > ./result_10chains/node235_9_1.txt &
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
    "./result_10chains/node235_0_1.txt 90"
    "./result_10chains/node235_1_1.txt 89"
    "./result_10chains/node235_2_1.txt 88"
    "./result_10chains/node235_3_1.txt 87"
    "./result_10chains/node235_4_1.txt 86"
    "./result_10chains/node235_5_1.txt 85"
    "./result_10chains/node235_6_1.txt 84"
    "./result_10chains/node235_7_1.txt 83"
    "./result_10chains/node235_8_1.txt 82"
    "./result_10chains/node235_9_1.txt 81"
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
