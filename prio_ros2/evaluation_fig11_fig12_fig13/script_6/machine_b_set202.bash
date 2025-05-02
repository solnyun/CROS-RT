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
ros2 run evaluation_3_randomdag uunifast_node -n node202_0_1 -p 282 -st topic202_0_0 -pt topic202_0_1 -u 0.03782673825745292 > ./result_6chains/node202_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_1_1 -p 351 -st topic202_1_0 -pt topic202_1_1 -u 0.007125900781314531 > ./result_6chains/node202_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_2_1 -p 518 -st topic202_2_0 -pt topic202_2_1 -u 0.013206655022524438 > ./result_6chains/node202_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_3_1 -p 654 -st topic202_3_0 -pt topic202_3_1 -u 0.059322634657724055 > ./result_6chains/node202_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_4_1 -p 816 -st topic202_4_0 -pt topic202_4_1 -u 0.045345029384417285 > ./result_6chains/node202_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_5_1 -p 878 -st topic202_5_0 -pt topic202_5_1 -u 0.052995968180025096 > ./result_6chains/node202_5_1.txt &
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
    "./result_6chains/node202_0_1.txt 90"
    "./result_6chains/node202_1_1.txt 89"
    "./result_6chains/node202_2_1.txt 88"
    "./result_6chains/node202_3_1.txt 87"
    "./result_6chains/node202_4_1.txt 86"
    "./result_6chains/node202_5_1.txt 85"
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
