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
ros2 run evaluation_3_randomdag uunifast_node -n node412_0_1 -p 150 -st topic412_0_0 -pt topic412_0_1 -u 0.013241936454462866 > ./result_10chains/node412_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_1_1 -p 177 -st topic412_1_0 -pt topic412_1_1 -u 0.0040533709208701585 > ./result_10chains/node412_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_2_1 -p 261 -st topic412_2_0 -pt topic412_2_1 -u 0.039851996382017696 > ./result_10chains/node412_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_3_1 -p 276 -st topic412_3_0 -pt topic412_3_1 -u 0.01703138545211591 > ./result_10chains/node412_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_4_1 -p 594 -st topic412_4_0 -pt topic412_4_1 -u 0.022019992180947412 > ./result_10chains/node412_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_5_1 -p 731 -st topic412_5_0 -pt topic412_5_1 -u 0.030175563999348953 > ./result_10chains/node412_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_6_1 -p 838 -st topic412_6_0 -pt topic412_6_1 -u 0.018224855927646916 > ./result_10chains/node412_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_7_1 -p 850 -st topic412_7_0 -pt topic412_7_1 -u 0.030102160062658645 > ./result_10chains/node412_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_8_1 -p 915 -st topic412_8_0 -pt topic412_8_1 -u 0.013497990828819882 > ./result_10chains/node412_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node412_9_1 -p 932 -st topic412_9_0 -pt topic412_9_1 -u 0.013949519690324916 > ./result_10chains/node412_9_1.txt &
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
    "./result_10chains/node412_0_1.txt 90"
    "./result_10chains/node412_1_1.txt 89"
    "./result_10chains/node412_2_1.txt 88"
    "./result_10chains/node412_3_1.txt 87"
    "./result_10chains/node412_4_1.txt 86"
    "./result_10chains/node412_5_1.txt 85"
    "./result_10chains/node412_6_1.txt 84"
    "./result_10chains/node412_7_1.txt 83"
    "./result_10chains/node412_8_1.txt 82"
    "./result_10chains/node412_9_1.txt 81"
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
