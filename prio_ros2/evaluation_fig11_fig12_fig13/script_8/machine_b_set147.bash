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
ros2 run evaluation_3_randomdag uunifast_node -n node147_0_1 -p 124 -st topic147_0_0 -pt topic147_0_1 -u 0.003619474959839941 > ./result_8chains/node147_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_1_1 -p 131 -st topic147_1_0 -pt topic147_1_1 -u 0.005213766972778311 > ./result_8chains/node147_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_2_1 -p 244 -st topic147_2_0 -pt topic147_2_1 -u 0.003321652551235732 > ./result_8chains/node147_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_3_1 -p 301 -st topic147_3_0 -pt topic147_3_1 -u 0.00540279882155692 > ./result_8chains/node147_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_4_1 -p 324 -st topic147_4_0 -pt topic147_4_1 -u 0.028915493534859782 > ./result_8chains/node147_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_5_1 -p 438 -st topic147_5_0 -pt topic147_5_1 -u 7.121127001907812e-06 > ./result_8chains/node147_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_6_1 -p 527 -st topic147_6_0 -pt topic147_6_1 -u 0.034327680644301126 > ./result_8chains/node147_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_7_1 -p 830 -st topic147_7_0 -pt topic147_7_1 -u 0.053718903198487274 > ./result_8chains/node147_7_1.txt &
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
    "./result_8chains/node147_0_1.txt 90"
    "./result_8chains/node147_1_1.txt 89"
    "./result_8chains/node147_2_1.txt 88"
    "./result_8chains/node147_3_1.txt 87"
    "./result_8chains/node147_4_1.txt 86"
    "./result_8chains/node147_5_1.txt 85"
    "./result_8chains/node147_6_1.txt 84"
    "./result_8chains/node147_7_1.txt 83"
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
