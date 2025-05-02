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
ros2 run evaluation_3_randomdag uunifast_node -n node101_0_1 -p 23 -st topic101_0_0 -pt topic101_0_1 -u 0.008717493256026443 > ./result_10chains/node101_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_1_1 -p 130 -st topic101_1_0 -pt topic101_1_1 -u 0.0172878890763542 > ./result_10chains/node101_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_2_1 -p 298 -st topic101_2_0 -pt topic101_2_1 -u 0.01671999685282244 > ./result_10chains/node101_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_3_1 -p 323 -st topic101_3_0 -pt topic101_3_1 -u 0.006507816632539298 > ./result_10chains/node101_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_4_1 -p 350 -st topic101_4_0 -pt topic101_4_1 -u 0.01771181574591174 > ./result_10chains/node101_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_5_1 -p 591 -st topic101_5_0 -pt topic101_5_1 -u 0.01459895158660024 > ./result_10chains/node101_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_6_1 -p 743 -st topic101_6_0 -pt topic101_6_1 -u 0.005908706594191876 > ./result_10chains/node101_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_7_1 -p 751 -st topic101_7_0 -pt topic101_7_1 -u 0.007627185688120819 > ./result_10chains/node101_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_8_1 -p 820 -st topic101_8_0 -pt topic101_8_1 -u 0.056409520665938725 > ./result_10chains/node101_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_9_1 -p 940 -st topic101_9_0 -pt topic101_9_1 -u 0.0021599854972122155 > ./result_10chains/node101_9_1.txt &
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
    "./result_10chains/node101_0_1.txt 90"
    "./result_10chains/node101_1_1.txt 89"
    "./result_10chains/node101_2_1.txt 88"
    "./result_10chains/node101_3_1.txt 87"
    "./result_10chains/node101_4_1.txt 86"
    "./result_10chains/node101_5_1.txt 85"
    "./result_10chains/node101_6_1.txt 84"
    "./result_10chains/node101_7_1.txt 83"
    "./result_10chains/node101_8_1.txt 82"
    "./result_10chains/node101_9_1.txt 81"
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
