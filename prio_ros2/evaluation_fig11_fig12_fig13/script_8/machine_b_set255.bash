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
ros2 run evaluation_3_randomdag uunifast_node -n node255_0_1 -p 19 -st topic255_0_0 -pt topic255_0_1 -u 0.008738489760099333 > ./result_8chains/node255_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_1_1 -p 329 -st topic255_1_0 -pt topic255_1_1 -u 0.01459858222974919 > ./result_8chains/node255_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_2_1 -p 350 -st topic255_2_0 -pt topic255_2_1 -u 0.027764339896882484 > ./result_8chains/node255_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_3_1 -p 871 -st topic255_3_0 -pt topic255_3_1 -u 0.00824393376550997 > ./result_8chains/node255_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_4_1 -p 880 -st topic255_4_0 -pt topic255_4_1 -u 0.007063240719058311 > ./result_8chains/node255_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_5_1 -p 887 -st topic255_5_0 -pt topic255_5_1 -u 0.02671860858304037 > ./result_8chains/node255_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_6_1 -p 939 -st topic255_6_0 -pt topic255_6_1 -u 0.014093013408759 > ./result_8chains/node255_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node255_7_1 -p 952 -st topic255_7_0 -pt topic255_7_1 -u 0.016987857356949215 > ./result_8chains/node255_7_1.txt &
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
    "./result_8chains/node255_0_1.txt 90"
    "./result_8chains/node255_1_1.txt 89"
    "./result_8chains/node255_2_1.txt 88"
    "./result_8chains/node255_3_1.txt 87"
    "./result_8chains/node255_4_1.txt 86"
    "./result_8chains/node255_5_1.txt 85"
    "./result_8chains/node255_6_1.txt 84"
    "./result_8chains/node255_7_1.txt 83"
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
