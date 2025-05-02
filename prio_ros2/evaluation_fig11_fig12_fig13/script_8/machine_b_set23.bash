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
ros2 run evaluation_3_randomdag uunifast_node -n node23_0_1 -p 47 -st topic23_0_0 -pt topic23_0_1 -u 0.018920234070762876 > ./result_8chains/node23_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_1_1 -p 53 -st topic23_1_0 -pt topic23_1_1 -u 0.0022272418816230988 > ./result_8chains/node23_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_2_1 -p 69 -st topic23_2_0 -pt topic23_2_1 -u 0.010557882113732098 > ./result_8chains/node23_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_3_1 -p 140 -st topic23_3_0 -pt topic23_3_1 -u 0.060026852468420516 > ./result_8chains/node23_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_4_1 -p 238 -st topic23_4_0 -pt topic23_4_1 -u 0.02825906919969992 > ./result_8chains/node23_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_5_1 -p 255 -st topic23_5_0 -pt topic23_5_1 -u 0.02036655028820361 > ./result_8chains/node23_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_6_1 -p 541 -st topic23_6_0 -pt topic23_6_1 -u 0.003886525371431984 > ./result_8chains/node23_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node23_7_1 -p 568 -st topic23_7_0 -pt topic23_7_1 -u 0.002120743551507001 > ./result_8chains/node23_7_1.txt &
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
    "./result_8chains/node23_0_1.txt 90"
    "./result_8chains/node23_1_1.txt 89"
    "./result_8chains/node23_2_1.txt 88"
    "./result_8chains/node23_3_1.txt 87"
    "./result_8chains/node23_4_1.txt 86"
    "./result_8chains/node23_5_1.txt 85"
    "./result_8chains/node23_6_1.txt 84"
    "./result_8chains/node23_7_1.txt 83"
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
