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
ros2 run evaluation_3_randomdag uunifast_node -n node269_0_1 -p 113 -st topic269_0_0 -pt topic269_0_1 -u 0.021305752562392755 > ./result_10chains/node269_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_1_1 -p 134 -st topic269_1_0 -pt topic269_1_1 -u 0.07050520836869872 > ./result_10chains/node269_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_2_1 -p 171 -st topic269_2_0 -pt topic269_2_1 -u 0.0017767739337336552 > ./result_10chains/node269_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_3_1 -p 187 -st topic269_3_0 -pt topic269_3_1 -u 0.004540989037799759 > ./result_10chains/node269_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_4_1 -p 346 -st topic269_4_0 -pt topic269_4_1 -u 0.010494423059098618 > ./result_10chains/node269_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_5_1 -p 686 -st topic269_5_0 -pt topic269_5_1 -u 0.023023276274132337 > ./result_10chains/node269_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_6_1 -p 726 -st topic269_6_0 -pt topic269_6_1 -u 0.0007998504074811508 > ./result_10chains/node269_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_7_1 -p 846 -st topic269_7_0 -pt topic269_7_1 -u 0.009419426968842418 > ./result_10chains/node269_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_8_1 -p 913 -st topic269_8_0 -pt topic269_8_1 -u 0.008854920928068583 > ./result_10chains/node269_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_9_1 -p 927 -st topic269_9_0 -pt topic269_9_1 -u 0.004409785307951802 > ./result_10chains/node269_9_1.txt &
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
    "./result_10chains/node269_0_1.txt 90"
    "./result_10chains/node269_1_1.txt 89"
    "./result_10chains/node269_2_1.txt 88"
    "./result_10chains/node269_3_1.txt 87"
    "./result_10chains/node269_4_1.txt 86"
    "./result_10chains/node269_5_1.txt 85"
    "./result_10chains/node269_6_1.txt 84"
    "./result_10chains/node269_7_1.txt 83"
    "./result_10chains/node269_8_1.txt 82"
    "./result_10chains/node269_9_1.txt 81"
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
