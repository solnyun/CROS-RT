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
ros2 run evaluation_3_randomdag uunifast_node -n node40_0_1 -p 218 -st topic40_0_0 -pt topic40_0_1 -u 0.002496198384076165 > ./result_10chains/node40_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_1_1 -p 251 -st topic40_1_0 -pt topic40_1_1 -u 0.026244156592025336 > ./result_10chains/node40_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_2_1 -p 281 -st topic40_2_0 -pt topic40_2_1 -u 0.014911341079439977 > ./result_10chains/node40_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_3_1 -p 286 -st topic40_3_0 -pt topic40_3_1 -u 0.004004084851242262 > ./result_10chains/node40_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_4_1 -p 610 -st topic40_4_0 -pt topic40_4_1 -u 0.031581636361443344 > ./result_10chains/node40_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_5_1 -p 687 -st topic40_5_0 -pt topic40_5_1 -u 0.007726525978456855 > ./result_10chains/node40_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_6_1 -p 781 -st topic40_6_0 -pt topic40_6_1 -u 0.007194339516686604 > ./result_10chains/node40_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_7_1 -p 833 -st topic40_7_0 -pt topic40_7_1 -u 0.05091861760238814 > ./result_10chains/node40_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_8_1 -p 883 -st topic40_8_0 -pt topic40_8_1 -u 0.007413000531035191 > ./result_10chains/node40_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node40_9_1 -p 908 -st topic40_9_0 -pt topic40_9_1 -u 0.018377200752648835 > ./result_10chains/node40_9_1.txt &
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
    "./result_10chains/node40_0_1.txt 90"
    "./result_10chains/node40_1_1.txt 89"
    "./result_10chains/node40_2_1.txt 88"
    "./result_10chains/node40_3_1.txt 87"
    "./result_10chains/node40_4_1.txt 86"
    "./result_10chains/node40_5_1.txt 85"
    "./result_10chains/node40_6_1.txt 84"
    "./result_10chains/node40_7_1.txt 83"
    "./result_10chains/node40_8_1.txt 82"
    "./result_10chains/node40_9_1.txt 81"
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
