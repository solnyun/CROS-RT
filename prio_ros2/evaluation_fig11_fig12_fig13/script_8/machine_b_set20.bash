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
ros2 run evaluation_3_randomdag uunifast_node -n node20_0_1 -p 178 -st topic20_0_0 -pt topic20_0_1 -u 0.03433330207785462 > ./result_8chains/node20_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_1_1 -p 217 -st topic20_1_0 -pt topic20_1_1 -u 0.041540862498696984 > ./result_8chains/node20_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_2_1 -p 227 -st topic20_2_0 -pt topic20_2_1 -u 0.039446095159121175 > ./result_8chains/node20_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_3_1 -p 246 -st topic20_3_0 -pt topic20_3_1 -u 0.00536160710241676 > ./result_8chains/node20_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_4_1 -p 488 -st topic20_4_0 -pt topic20_4_1 -u 0.0080617589623323 > ./result_8chains/node20_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_5_1 -p 499 -st topic20_5_0 -pt topic20_5_1 -u 0.006573042157857367 > ./result_8chains/node20_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_6_1 -p 884 -st topic20_6_0 -pt topic20_6_1 -u 0.004879285216333795 > ./result_8chains/node20_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node20_7_1 -p 917 -st topic20_7_0 -pt topic20_7_1 -u 0.0013982106728045035 > ./result_8chains/node20_7_1.txt &
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
    "./result_8chains/node20_0_1.txt 90"
    "./result_8chains/node20_1_1.txt 89"
    "./result_8chains/node20_2_1.txt 88"
    "./result_8chains/node20_3_1.txt 87"
    "./result_8chains/node20_4_1.txt 86"
    "./result_8chains/node20_5_1.txt 85"
    "./result_8chains/node20_6_1.txt 84"
    "./result_8chains/node20_7_1.txt 83"
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
