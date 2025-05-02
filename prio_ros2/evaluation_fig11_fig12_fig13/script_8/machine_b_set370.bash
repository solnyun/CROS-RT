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
ros2 run evaluation_3_randomdag uunifast_node -n node370_0_1 -p 54 -st topic370_0_0 -pt topic370_0_1 -u 0.008623325816403793 > ./result_8chains/node370_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_1_1 -p 163 -st topic370_1_0 -pt topic370_1_1 -u 0.023575059617591432 > ./result_8chains/node370_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_2_1 -p 234 -st topic370_2_0 -pt topic370_2_1 -u 0.009198662547371478 > ./result_8chains/node370_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_3_1 -p 493 -st topic370_3_0 -pt topic370_3_1 -u 0.02021422052073768 > ./result_8chains/node370_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_4_1 -p 641 -st topic370_4_0 -pt topic370_4_1 -u 0.004678695643357128 > ./result_8chains/node370_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_5_1 -p 726 -st topic370_5_0 -pt topic370_5_1 -u 0.04165683977188328 > ./result_8chains/node370_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_6_1 -p 839 -st topic370_6_0 -pt topic370_6_1 -u 0.003726533475425002 > ./result_8chains/node370_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node370_7_1 -p 997 -st topic370_7_0 -pt topic370_7_1 -u 0.019912669508173452 > ./result_8chains/node370_7_1.txt &
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
    "./result_8chains/node370_0_1.txt 90"
    "./result_8chains/node370_1_1.txt 89"
    "./result_8chains/node370_2_1.txt 88"
    "./result_8chains/node370_3_1.txt 87"
    "./result_8chains/node370_4_1.txt 86"
    "./result_8chains/node370_5_1.txt 85"
    "./result_8chains/node370_6_1.txt 84"
    "./result_8chains/node370_7_1.txt 83"
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
