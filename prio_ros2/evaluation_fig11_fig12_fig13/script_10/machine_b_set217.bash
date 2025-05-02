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
ros2 run evaluation_3_randomdag uunifast_node -n node217_0_1 -p 203 -st topic217_0_0 -pt topic217_0_1 -u 0.010912637934158809 > ./result_10chains/node217_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_1_1 -p 210 -st topic217_1_0 -pt topic217_1_1 -u 0.012069630859276537 > ./result_10chains/node217_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_2_1 -p 304 -st topic217_2_0 -pt topic217_2_1 -u 0.02258209539296191 > ./result_10chains/node217_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_3_1 -p 333 -st topic217_3_0 -pt topic217_3_1 -u 0.0037734625178271197 > ./result_10chains/node217_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_4_1 -p 403 -st topic217_4_0 -pt topic217_4_1 -u 0.0032835370307477962 > ./result_10chains/node217_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_5_1 -p 532 -st topic217_5_0 -pt topic217_5_1 -u 0.0022597940448035314 > ./result_10chains/node217_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_6_1 -p 583 -st topic217_6_0 -pt topic217_6_1 -u 0.0003968413017514383 > ./result_10chains/node217_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_7_1 -p 762 -st topic217_7_0 -pt topic217_7_1 -u 0.04549450364240848 > ./result_10chains/node217_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_8_1 -p 783 -st topic217_8_0 -pt topic217_8_1 -u 0.001319153089506614 > ./result_10chains/node217_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_9_1 -p 907 -st topic217_9_0 -pt topic217_9_1 -u 0.11169086772226218 > ./result_10chains/node217_9_1.txt &
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
    "./result_10chains/node217_0_1.txt 90"
    "./result_10chains/node217_1_1.txt 89"
    "./result_10chains/node217_2_1.txt 88"
    "./result_10chains/node217_3_1.txt 87"
    "./result_10chains/node217_4_1.txt 86"
    "./result_10chains/node217_5_1.txt 85"
    "./result_10chains/node217_6_1.txt 84"
    "./result_10chains/node217_7_1.txt 83"
    "./result_10chains/node217_8_1.txt 82"
    "./result_10chains/node217_9_1.txt 81"
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
