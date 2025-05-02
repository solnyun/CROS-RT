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
ros2 run evaluation_3_randomdag uunifast_node -n node361_0_1 -p 173 -st topic361_0_0 -pt topic361_0_1 -u 0.00010290567654730465 > ./result_6chains/node361_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_1_1 -p 331 -st topic361_1_0 -pt topic361_1_1 -u 0.06233987727299006 > ./result_6chains/node361_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_2_1 -p 610 -st topic361_2_0 -pt topic361_2_1 -u 0.0020204331478633764 > ./result_6chains/node361_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_3_1 -p 681 -st topic361_3_0 -pt topic361_3_1 -u 0.0351538115489517 > ./result_6chains/node361_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_4_1 -p 754 -st topic361_4_0 -pt topic361_4_1 -u 0.05117870940516789 > ./result_6chains/node361_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node361_5_1 -p 895 -st topic361_5_0 -pt topic361_5_1 -u 0.0024426746532537763 > ./result_6chains/node361_5_1.txt &
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
    "./result_6chains/node361_0_1.txt 90"
    "./result_6chains/node361_1_1.txt 89"
    "./result_6chains/node361_2_1.txt 88"
    "./result_6chains/node361_3_1.txt 87"
    "./result_6chains/node361_4_1.txt 86"
    "./result_6chains/node361_5_1.txt 85"
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
