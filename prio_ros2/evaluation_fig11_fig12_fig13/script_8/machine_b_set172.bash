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
ros2 run evaluation_3_randomdag uunifast_node -n node172_0_1 -p 199 -st topic172_0_0 -pt topic172_0_1 -u 0.01616728268439377 > ./result_8chains/node172_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_1_1 -p 241 -st topic172_1_0 -pt topic172_1_1 -u 0.08271002887631151 > ./result_8chains/node172_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_2_1 -p 265 -st topic172_2_0 -pt topic172_2_1 -u 0.0005346186584397339 > ./result_8chains/node172_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_3_1 -p 398 -st topic172_3_0 -pt topic172_3_1 -u 0.001811790462641405 > ./result_8chains/node172_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_4_1 -p 652 -st topic172_4_0 -pt topic172_4_1 -u 0.00574117415863637 > ./result_8chains/node172_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_5_1 -p 780 -st topic172_5_0 -pt topic172_5_1 -u 0.0437174927080769 > ./result_8chains/node172_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_6_1 -p 910 -st topic172_6_0 -pt topic172_6_1 -u 0.029096786626244042 > ./result_8chains/node172_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node172_7_1 -p 936 -st topic172_7_0 -pt topic172_7_1 -u 0.010138763479493796 > ./result_8chains/node172_7_1.txt &
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
    "./result_8chains/node172_0_1.txt 90"
    "./result_8chains/node172_1_1.txt 89"
    "./result_8chains/node172_2_1.txt 88"
    "./result_8chains/node172_3_1.txt 87"
    "./result_8chains/node172_4_1.txt 86"
    "./result_8chains/node172_5_1.txt 85"
    "./result_8chains/node172_6_1.txt 84"
    "./result_8chains/node172_7_1.txt 83"
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
