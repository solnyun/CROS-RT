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
ros2 run evaluation_3_randomdag uunifast_node -n node272_0_1 -p 98 -st topic272_0_0 -pt topic272_0_1 -u 0.007550311002796961 > ./result_8chains/node272_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_1_1 -p 463 -st topic272_1_0 -pt topic272_1_1 -u 0.028177751416590124 > ./result_8chains/node272_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_2_1 -p 595 -st topic272_2_0 -pt topic272_2_1 -u 0.006676681938612372 > ./result_8chains/node272_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_3_1 -p 675 -st topic272_3_0 -pt topic272_3_1 -u 0.023058523441793544 > ./result_8chains/node272_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_4_1 -p 703 -st topic272_4_0 -pt topic272_4_1 -u 0.00717990941898039 > ./result_8chains/node272_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_5_1 -p 719 -st topic272_5_0 -pt topic272_5_1 -u 0.008260516563850268 > ./result_8chains/node272_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_6_1 -p 784 -st topic272_6_0 -pt topic272_6_1 -u 0.008853887923992498 > ./result_8chains/node272_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_7_1 -p 950 -st topic272_7_0 -pt topic272_7_1 -u 0.004197120689846297 > ./result_8chains/node272_7_1.txt &
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
    "./result_8chains/node272_0_1.txt 90"
    "./result_8chains/node272_1_1.txt 89"
    "./result_8chains/node272_2_1.txt 88"
    "./result_8chains/node272_3_1.txt 87"
    "./result_8chains/node272_4_1.txt 86"
    "./result_8chains/node272_5_1.txt 85"
    "./result_8chains/node272_6_1.txt 84"
    "./result_8chains/node272_7_1.txt 83"
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
