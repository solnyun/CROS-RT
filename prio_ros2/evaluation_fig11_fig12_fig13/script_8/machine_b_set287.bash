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
ros2 run evaluation_3_randomdag uunifast_node -n node287_0_1 -p 87 -st topic287_0_0 -pt topic287_0_1 -u 0.010745594862158647 > ./result_8chains/node287_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_1_1 -p 194 -st topic287_1_0 -pt topic287_1_1 -u 0.01860030920760819 > ./result_8chains/node287_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_2_1 -p 241 -st topic287_2_0 -pt topic287_2_1 -u 0.015503560977111142 > ./result_8chains/node287_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_3_1 -p 484 -st topic287_3_0 -pt topic287_3_1 -u 0.023704378251679814 > ./result_8chains/node287_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_4_1 -p 596 -st topic287_4_0 -pt topic287_4_1 -u 0.0162861067408116 > ./result_8chains/node287_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_5_1 -p 676 -st topic287_5_0 -pt topic287_5_1 -u 0.03738091438527186 > ./result_8chains/node287_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_6_1 -p 724 -st topic287_6_0 -pt topic287_6_1 -u 0.031218284633835275 > ./result_8chains/node287_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_7_1 -p 786 -st topic287_7_0 -pt topic287_7_1 -u 0.006389483403254445 > ./result_8chains/node287_7_1.txt &
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
    "./result_8chains/node287_0_1.txt 90"
    "./result_8chains/node287_1_1.txt 89"
    "./result_8chains/node287_2_1.txt 88"
    "./result_8chains/node287_3_1.txt 87"
    "./result_8chains/node287_4_1.txt 86"
    "./result_8chains/node287_5_1.txt 85"
    "./result_8chains/node287_6_1.txt 84"
    "./result_8chains/node287_7_1.txt 83"
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
