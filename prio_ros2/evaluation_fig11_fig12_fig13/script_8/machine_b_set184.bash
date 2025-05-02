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
ros2 run evaluation_3_randomdag uunifast_node -n node184_0_1 -p 128 -st topic184_0_0 -pt topic184_0_1 -u 0.0019026875417140765 > ./result_8chains/node184_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_1_1 -p 355 -st topic184_1_0 -pt topic184_1_1 -u 0.0037081094726211794 > ./result_8chains/node184_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_2_1 -p 439 -st topic184_2_0 -pt topic184_2_1 -u 0.005548441483762434 > ./result_8chains/node184_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_3_1 -p 711 -st topic184_3_0 -pt topic184_3_1 -u 0.07992009216380225 > ./result_8chains/node184_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_4_1 -p 739 -st topic184_4_0 -pt topic184_4_1 -u 0.0036735513198436764 > ./result_8chains/node184_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_5_1 -p 741 -st topic184_5_0 -pt topic184_5_1 -u 0.008064625278792467 > ./result_8chains/node184_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_6_1 -p 786 -st topic184_6_0 -pt topic184_6_1 -u 0.015083059126281773 > ./result_8chains/node184_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_7_1 -p 910 -st topic184_7_0 -pt topic184_7_1 -u 0.01648024142543873 > ./result_8chains/node184_7_1.txt &
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
    "./result_8chains/node184_0_1.txt 90"
    "./result_8chains/node184_1_1.txt 89"
    "./result_8chains/node184_2_1.txt 88"
    "./result_8chains/node184_3_1.txt 87"
    "./result_8chains/node184_4_1.txt 86"
    "./result_8chains/node184_5_1.txt 85"
    "./result_8chains/node184_6_1.txt 84"
    "./result_8chains/node184_7_1.txt 83"
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
