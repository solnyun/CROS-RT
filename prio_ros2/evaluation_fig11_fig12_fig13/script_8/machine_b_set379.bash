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
ros2 run evaluation_3_randomdag uunifast_node -n node379_0_1 -p 32 -st topic379_0_0 -pt topic379_0_1 -u 0.0252766163642979 > ./result_8chains/node379_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_1_1 -p 52 -st topic379_1_0 -pt topic379_1_1 -u 0.05075704743164716 > ./result_8chains/node379_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_2_1 -p 68 -st topic379_2_0 -pt topic379_2_1 -u 0.01830397047107124 > ./result_8chains/node379_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_3_1 -p 487 -st topic379_3_0 -pt topic379_3_1 -u 0.012486302134967042 > ./result_8chains/node379_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_4_1 -p 681 -st topic379_4_0 -pt topic379_4_1 -u 0.0858491386477962 > ./result_8chains/node379_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_5_1 -p 828 -st topic379_5_0 -pt topic379_5_1 -u 0.04263305477443291 > ./result_8chains/node379_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_6_1 -p 942 -st topic379_6_0 -pt topic379_6_1 -u 0.0070858665737249735 > ./result_8chains/node379_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_7_1 -p 954 -st topic379_7_0 -pt topic379_7_1 -u 0.0015750249537120585 > ./result_8chains/node379_7_1.txt &
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
    "./result_8chains/node379_0_1.txt 90"
    "./result_8chains/node379_1_1.txt 89"
    "./result_8chains/node379_2_1.txt 88"
    "./result_8chains/node379_3_1.txt 87"
    "./result_8chains/node379_4_1.txt 86"
    "./result_8chains/node379_5_1.txt 85"
    "./result_8chains/node379_6_1.txt 84"
    "./result_8chains/node379_7_1.txt 83"
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
