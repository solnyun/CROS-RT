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
ros2 run evaluation_3_randomdag uunifast_node -n node474_0_1 -p 79 -st topic474_0_0 -pt topic474_0_1 -u 0.008189076092816605 > ./result_8chains/node474_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_1_1 -p 409 -st topic474_1_0 -pt topic474_1_1 -u 0.003923944879170194 > ./result_8chains/node474_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_2_1 -p 598 -st topic474_2_0 -pt topic474_2_1 -u 0.007792461696597031 > ./result_8chains/node474_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_3_1 -p 772 -st topic474_3_0 -pt topic474_3_1 -u 0.012016570053654196 > ./result_8chains/node474_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_4_1 -p 866 -st topic474_4_0 -pt topic474_4_1 -u 0.03754988072971896 > ./result_8chains/node474_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_5_1 -p 896 -st topic474_5_0 -pt topic474_5_1 -u 0.023705829619962565 > ./result_8chains/node474_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_6_1 -p 930 -st topic474_6_0 -pt topic474_6_1 -u 0.004192850997198808 > ./result_8chains/node474_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node474_7_1 -p 996 -st topic474_7_0 -pt topic474_7_1 -u 0.023991954976546007 > ./result_8chains/node474_7_1.txt &
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
    "./result_8chains/node474_0_1.txt 90"
    "./result_8chains/node474_1_1.txt 89"
    "./result_8chains/node474_2_1.txt 88"
    "./result_8chains/node474_3_1.txt 87"
    "./result_8chains/node474_4_1.txt 86"
    "./result_8chains/node474_5_1.txt 85"
    "./result_8chains/node474_6_1.txt 84"
    "./result_8chains/node474_7_1.txt 83"
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
