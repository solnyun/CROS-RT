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
ros2 run evaluation_3_randomdag uunifast_node -n node479_0_1 -p 224 -st topic479_0_0 -pt topic479_0_1 -u 0.0023160943893787422 > ./result_8chains/node479_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_1_1 -p 290 -st topic479_1_0 -pt topic479_1_1 -u 0.046291109593369184 > ./result_8chains/node479_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_2_1 -p 456 -st topic479_2_0 -pt topic479_2_1 -u 0.012187790950892452 > ./result_8chains/node479_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_3_1 -p 578 -st topic479_3_0 -pt topic479_3_1 -u 0.0017395760126439064 > ./result_8chains/node479_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_4_1 -p 658 -st topic479_4_0 -pt topic479_4_1 -u 0.02521375640577858 > ./result_8chains/node479_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_5_1 -p 675 -st topic479_5_0 -pt topic479_5_1 -u 0.06859558388333575 > ./result_8chains/node479_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_6_1 -p 830 -st topic479_6_0 -pt topic479_6_1 -u 0.04808822656470148 > ./result_8chains/node479_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_7_1 -p 890 -st topic479_7_0 -pt topic479_7_1 -u 0.06307826334710612 > ./result_8chains/node479_7_1.txt &
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
    "./result_8chains/node479_0_1.txt 90"
    "./result_8chains/node479_1_1.txt 89"
    "./result_8chains/node479_2_1.txt 88"
    "./result_8chains/node479_3_1.txt 87"
    "./result_8chains/node479_4_1.txt 86"
    "./result_8chains/node479_5_1.txt 85"
    "./result_8chains/node479_6_1.txt 84"
    "./result_8chains/node479_7_1.txt 83"
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
