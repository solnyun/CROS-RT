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
ros2 run evaluation_3_randomdag uunifast_node -n node281_0_1 -p 155 -st topic281_0_0 -pt topic281_0_1 -u 0.013746070450109338 > ./result_8chains/node281_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_1_1 -p 168 -st topic281_1_0 -pt topic281_1_1 -u 0.016697532875794008 > ./result_8chains/node281_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_2_1 -p 358 -st topic281_2_0 -pt topic281_2_1 -u 0.003081368094013326 > ./result_8chains/node281_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_3_1 -p 502 -st topic281_3_0 -pt topic281_3_1 -u 0.004106091770432974 > ./result_8chains/node281_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_4_1 -p 729 -st topic281_4_0 -pt topic281_4_1 -u 0.03177779454473004 > ./result_8chains/node281_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_5_1 -p 798 -st topic281_5_0 -pt topic281_5_1 -u 0.018599326901675914 > ./result_8chains/node281_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_6_1 -p 962 -st topic281_6_0 -pt topic281_6_1 -u 0.019701083759127505 > ./result_8chains/node281_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_7_1 -p 987 -st topic281_7_0 -pt topic281_7_1 -u 0.006720945761848299 > ./result_8chains/node281_7_1.txt &
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
    "./result_8chains/node281_0_1.txt 90"
    "./result_8chains/node281_1_1.txt 89"
    "./result_8chains/node281_2_1.txt 88"
    "./result_8chains/node281_3_1.txt 87"
    "./result_8chains/node281_4_1.txt 86"
    "./result_8chains/node281_5_1.txt 85"
    "./result_8chains/node281_6_1.txt 84"
    "./result_8chains/node281_7_1.txt 83"
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
