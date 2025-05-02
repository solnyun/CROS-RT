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
ros2 run evaluation_3_randomdag uunifast_node -n node419_0_1 -p 39 -st topic419_0_0 -pt topic419_0_1 -u 0.013432140166869166 > ./result_8chains/node419_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_1_1 -p 193 -st topic419_1_0 -pt topic419_1_1 -u 0.024799590588489184 > ./result_8chains/node419_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_2_1 -p 205 -st topic419_2_0 -pt topic419_2_1 -u 0.00030262952482379424 > ./result_8chains/node419_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_3_1 -p 574 -st topic419_3_0 -pt topic419_3_1 -u 0.04125527021265818 > ./result_8chains/node419_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_4_1 -p 649 -st topic419_4_0 -pt topic419_4_1 -u 0.00034831860651268753 > ./result_8chains/node419_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_5_1 -p 748 -st topic419_5_0 -pt topic419_5_1 -u 0.06313195925437273 > ./result_8chains/node419_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_6_1 -p 798 -st topic419_6_0 -pt topic419_6_1 -u 0.0036077165716950493 > ./result_8chains/node419_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_7_1 -p 916 -st topic419_7_0 -pt topic419_7_1 -u 0.0171139352193888 > ./result_8chains/node419_7_1.txt &
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
    "./result_8chains/node419_0_1.txt 90"
    "./result_8chains/node419_1_1.txt 89"
    "./result_8chains/node419_2_1.txt 88"
    "./result_8chains/node419_3_1.txt 87"
    "./result_8chains/node419_4_1.txt 86"
    "./result_8chains/node419_5_1.txt 85"
    "./result_8chains/node419_6_1.txt 84"
    "./result_8chains/node419_7_1.txt 83"
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
