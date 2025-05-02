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
ros2 run evaluation_3_randomdag uunifast_node -n node19_0_1 -p 45 -st topic19_0_0 -pt topic19_0_1 -u 0.009644018560434175 > ./result_8chains/node19_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_1_1 -p 90 -st topic19_1_0 -pt topic19_1_1 -u 0.052025950788405495 > ./result_8chains/node19_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_2_1 -p 322 -st topic19_2_0 -pt topic19_2_1 -u 0.05905678170751799 > ./result_8chains/node19_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_3_1 -p 406 -st topic19_3_0 -pt topic19_3_1 -u 0.006824979035754963 > ./result_8chains/node19_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_4_1 -p 862 -st topic19_4_0 -pt topic19_4_1 -u 0.04625629568574263 > ./result_8chains/node19_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_5_1 -p 953 -st topic19_5_0 -pt topic19_5_1 -u 0.002035885414708949 > ./result_8chains/node19_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_6_1 -p 959 -st topic19_6_0 -pt topic19_6_1 -u 0.010068613077121542 > ./result_8chains/node19_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node19_7_1 -p 989 -st topic19_7_0 -pt topic19_7_1 -u 0.01837330538878631 > ./result_8chains/node19_7_1.txt &
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
    "./result_8chains/node19_0_1.txt 90"
    "./result_8chains/node19_1_1.txt 89"
    "./result_8chains/node19_2_1.txt 88"
    "./result_8chains/node19_3_1.txt 87"
    "./result_8chains/node19_4_1.txt 86"
    "./result_8chains/node19_5_1.txt 85"
    "./result_8chains/node19_6_1.txt 84"
    "./result_8chains/node19_7_1.txt 83"
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
