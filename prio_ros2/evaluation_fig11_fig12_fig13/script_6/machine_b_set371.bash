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
ros2 run evaluation_3_randomdag uunifast_node -n node371_0_1 -p 201 -st topic371_0_0 -pt topic371_0_1 -u 0.0330458711882049 > ./result_6chains/node371_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_1_1 -p 223 -st topic371_1_0 -pt topic371_1_1 -u 0.015076294573000082 > ./result_6chains/node371_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_2_1 -p 401 -st topic371_2_0 -pt topic371_2_1 -u 0.030285444229083386 > ./result_6chains/node371_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_3_1 -p 533 -st topic371_3_0 -pt topic371_3_1 -u 0.022316044747444475 > ./result_6chains/node371_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_4_1 -p 581 -st topic371_4_0 -pt topic371_4_1 -u 0.011057470274322495 > ./result_6chains/node371_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_5_1 -p 818 -st topic371_5_0 -pt topic371_5_1 -u 0.057799561353335305 > ./result_6chains/node371_5_1.txt &
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
    "./result_6chains/node371_0_1.txt 90"
    "./result_6chains/node371_1_1.txt 89"
    "./result_6chains/node371_2_1.txt 88"
    "./result_6chains/node371_3_1.txt 87"
    "./result_6chains/node371_4_1.txt 86"
    "./result_6chains/node371_5_1.txt 85"
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
