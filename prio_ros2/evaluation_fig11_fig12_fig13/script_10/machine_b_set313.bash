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
ros2 run evaluation_3_randomdag uunifast_node -n node313_0_1 -p 91 -st topic313_0_0 -pt topic313_0_1 -u 0.0057116757799343665 > ./result_10chains/node313_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_1_1 -p 169 -st topic313_1_0 -pt topic313_1_1 -u 0.005088472020283175 > ./result_10chains/node313_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_2_1 -p 246 -st topic313_2_0 -pt topic313_2_1 -u 0.011021006155445268 > ./result_10chains/node313_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_3_1 -p 277 -st topic313_3_0 -pt topic313_3_1 -u 0.019888886693637642 > ./result_10chains/node313_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_4_1 -p 306 -st topic313_4_0 -pt topic313_4_1 -u 0.013811575920348929 > ./result_10chains/node313_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_5_1 -p 323 -st topic313_5_0 -pt topic313_5_1 -u 0.004480455974798708 > ./result_10chains/node313_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_6_1 -p 582 -st topic313_6_0 -pt topic313_6_1 -u 0.04341599022547479 > ./result_10chains/node313_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_7_1 -p 624 -st topic313_7_0 -pt topic313_7_1 -u 0.030310845759123628 > ./result_10chains/node313_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_8_1 -p 721 -st topic313_8_0 -pt topic313_8_1 -u 0.01195669472755019 > ./result_10chains/node313_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node313_9_1 -p 923 -st topic313_9_0 -pt topic313_9_1 -u 0.004126015593035322 > ./result_10chains/node313_9_1.txt &
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
    "./result_10chains/node313_0_1.txt 90"
    "./result_10chains/node313_1_1.txt 89"
    "./result_10chains/node313_2_1.txt 88"
    "./result_10chains/node313_3_1.txt 87"
    "./result_10chains/node313_4_1.txt 86"
    "./result_10chains/node313_5_1.txt 85"
    "./result_10chains/node313_6_1.txt 84"
    "./result_10chains/node313_7_1.txt 83"
    "./result_10chains/node313_8_1.txt 82"
    "./result_10chains/node313_9_1.txt 81"
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
