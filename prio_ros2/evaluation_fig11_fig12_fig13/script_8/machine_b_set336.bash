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
ros2 run evaluation_3_randomdag uunifast_node -n node336_0_1 -p 296 -st topic336_0_0 -pt topic336_0_1 -u 0.006095669672463 > ./result_8chains/node336_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_1_1 -p 345 -st topic336_1_0 -pt topic336_1_1 -u 0.008070641269592116 > ./result_8chains/node336_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_2_1 -p 552 -st topic336_2_0 -pt topic336_2_1 -u 0.005986570987542905 > ./result_8chains/node336_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_3_1 -p 708 -st topic336_3_0 -pt topic336_3_1 -u 0.014455097345305146 > ./result_8chains/node336_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_4_1 -p 750 -st topic336_4_0 -pt topic336_4_1 -u 0.010731144017282201 > ./result_8chains/node336_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_5_1 -p 838 -st topic336_5_0 -pt topic336_5_1 -u 0.04335270693617227 > ./result_8chains/node336_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_6_1 -p 848 -st topic336_6_0 -pt topic336_6_1 -u 0.013309640269160095 > ./result_8chains/node336_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node336_7_1 -p 934 -st topic336_7_0 -pt topic336_7_1 -u 0.04457100126739212 > ./result_8chains/node336_7_1.txt &
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
    "./result_8chains/node336_0_1.txt 90"
    "./result_8chains/node336_1_1.txt 89"
    "./result_8chains/node336_2_1.txt 88"
    "./result_8chains/node336_3_1.txt 87"
    "./result_8chains/node336_4_1.txt 86"
    "./result_8chains/node336_5_1.txt 85"
    "./result_8chains/node336_6_1.txt 84"
    "./result_8chains/node336_7_1.txt 83"
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
