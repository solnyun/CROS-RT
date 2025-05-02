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
ros2 run evaluation_3_randomdag uunifast_node -n node215_0_1 -p 377 -st topic215_0_0 -pt topic215_0_1 -u 0.0014156074984517653 > ./result_8chains/node215_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_1_1 -p 447 -st topic215_1_0 -pt topic215_1_1 -u 0.022911012860911906 > ./result_8chains/node215_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_2_1 -p 551 -st topic215_2_0 -pt topic215_2_1 -u 0.013757615954117286 > ./result_8chains/node215_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_3_1 -p 635 -st topic215_3_0 -pt topic215_3_1 -u 0.003978636750724046 > ./result_8chains/node215_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_4_1 -p 730 -st topic215_4_0 -pt topic215_4_1 -u 0.03225650407431188 > ./result_8chains/node215_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_5_1 -p 808 -st topic215_5_0 -pt topic215_5_1 -u 0.005385042275294877 > ./result_8chains/node215_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_6_1 -p 852 -st topic215_6_0 -pt topic215_6_1 -u 0.0034050238002202166 > ./result_8chains/node215_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_7_1 -p 986 -st topic215_7_0 -pt topic215_7_1 -u 0.02529094628569059 > ./result_8chains/node215_7_1.txt &
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
    "./result_8chains/node215_0_1.txt 90"
    "./result_8chains/node215_1_1.txt 89"
    "./result_8chains/node215_2_1.txt 88"
    "./result_8chains/node215_3_1.txt 87"
    "./result_8chains/node215_4_1.txt 86"
    "./result_8chains/node215_5_1.txt 85"
    "./result_8chains/node215_6_1.txt 84"
    "./result_8chains/node215_7_1.txt 83"
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
