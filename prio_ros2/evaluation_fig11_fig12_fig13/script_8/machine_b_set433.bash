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
ros2 run evaluation_3_randomdag uunifast_node -n node433_0_1 -p 15 -st topic433_0_0 -pt topic433_0_1 -u 0.05142327744910963 > ./result_8chains/node433_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_1_1 -p 146 -st topic433_1_0 -pt topic433_1_1 -u 0.030771070185898586 > ./result_8chains/node433_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_2_1 -p 206 -st topic433_2_0 -pt topic433_2_1 -u 0.018509253893209898 > ./result_8chains/node433_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_3_1 -p 561 -st topic433_3_0 -pt topic433_3_1 -u 0.013091375284945472 > ./result_8chains/node433_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_4_1 -p 687 -st topic433_4_0 -pt topic433_4_1 -u 0.027031668557635335 > ./result_8chains/node433_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_5_1 -p 848 -st topic433_5_0 -pt topic433_5_1 -u 0.017658828103468138 > ./result_8chains/node433_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_6_1 -p 952 -st topic433_6_0 -pt topic433_6_1 -u 0.07732768780988994 > ./result_8chains/node433_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_7_1 -p 991 -st topic433_7_0 -pt topic433_7_1 -u 0.00955556446010535 > ./result_8chains/node433_7_1.txt &
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
    "./result_8chains/node433_0_1.txt 90"
    "./result_8chains/node433_1_1.txt 89"
    "./result_8chains/node433_2_1.txt 88"
    "./result_8chains/node433_3_1.txt 87"
    "./result_8chains/node433_4_1.txt 86"
    "./result_8chains/node433_5_1.txt 85"
    "./result_8chains/node433_6_1.txt 84"
    "./result_8chains/node433_7_1.txt 83"
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
