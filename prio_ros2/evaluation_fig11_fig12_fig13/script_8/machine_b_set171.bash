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
ros2 run evaluation_3_randomdag uunifast_node -n node171_0_1 -p 81 -st topic171_0_0 -pt topic171_0_1 -u 0.009621731870304573 > ./result_8chains/node171_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_1_1 -p 199 -st topic171_1_0 -pt topic171_1_1 -u 0.020800747511308726 > ./result_8chains/node171_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_2_1 -p 272 -st topic171_2_0 -pt topic171_2_1 -u 0.012730484752246807 > ./result_8chains/node171_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_3_1 -p 424 -st topic171_3_0 -pt topic171_3_1 -u 0.07487602735234317 > ./result_8chains/node171_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_4_1 -p 479 -st topic171_4_0 -pt topic171_4_1 -u 0.027000464146835587 > ./result_8chains/node171_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_5_1 -p 669 -st topic171_5_0 -pt topic171_5_1 -u 0.004872467319560099 > ./result_8chains/node171_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_6_1 -p 712 -st topic171_6_0 -pt topic171_6_1 -u 0.0003205708589930495 > ./result_8chains/node171_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_7_1 -p 772 -st topic171_7_0 -pt topic171_7_1 -u 0.02171075120478485 > ./result_8chains/node171_7_1.txt &
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
    "./result_8chains/node171_0_1.txt 90"
    "./result_8chains/node171_1_1.txt 89"
    "./result_8chains/node171_2_1.txt 88"
    "./result_8chains/node171_3_1.txt 87"
    "./result_8chains/node171_4_1.txt 86"
    "./result_8chains/node171_5_1.txt 85"
    "./result_8chains/node171_6_1.txt 84"
    "./result_8chains/node171_7_1.txt 83"
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
