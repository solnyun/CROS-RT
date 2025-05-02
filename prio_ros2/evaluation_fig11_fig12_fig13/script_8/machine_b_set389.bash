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
ros2 run evaluation_3_randomdag uunifast_node -n node389_0_1 -p 245 -st topic389_0_0 -pt topic389_0_1 -u 0.02108496436271423 > ./result_8chains/node389_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_1_1 -p 284 -st topic389_1_0 -pt topic389_1_1 -u 0.061229364748693005 > ./result_8chains/node389_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_2_1 -p 316 -st topic389_2_0 -pt topic389_2_1 -u 0.0036997292844733742 > ./result_8chains/node389_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_3_1 -p 347 -st topic389_3_0 -pt topic389_3_1 -u 0.048127051892703276 > ./result_8chains/node389_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_4_1 -p 380 -st topic389_4_0 -pt topic389_4_1 -u 0.0082061258046629 > ./result_8chains/node389_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_5_1 -p 683 -st topic389_5_0 -pt topic389_5_1 -u 0.008588869039870162 > ./result_8chains/node389_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_6_1 -p 772 -st topic389_6_0 -pt topic389_6_1 -u 0.030063132826555344 > ./result_8chains/node389_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node389_7_1 -p 831 -st topic389_7_0 -pt topic389_7_1 -u 0.030802655037333825 > ./result_8chains/node389_7_1.txt &
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
    "./result_8chains/node389_0_1.txt 90"
    "./result_8chains/node389_1_1.txt 89"
    "./result_8chains/node389_2_1.txt 88"
    "./result_8chains/node389_3_1.txt 87"
    "./result_8chains/node389_4_1.txt 86"
    "./result_8chains/node389_5_1.txt 85"
    "./result_8chains/node389_6_1.txt 84"
    "./result_8chains/node389_7_1.txt 83"
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
