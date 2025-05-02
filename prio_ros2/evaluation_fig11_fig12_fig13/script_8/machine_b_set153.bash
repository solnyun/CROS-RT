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
ros2 run evaluation_3_randomdag uunifast_node -n node153_0_1 -p 80 -st topic153_0_0 -pt topic153_0_1 -u 0.005305510339344399 > ./result_8chains/node153_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_1_1 -p 83 -st topic153_1_0 -pt topic153_1_1 -u 0.010156761649303181 > ./result_8chains/node153_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_2_1 -p 169 -st topic153_2_0 -pt topic153_2_1 -u 0.016239714571506136 > ./result_8chains/node153_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_3_1 -p 366 -st topic153_3_0 -pt topic153_3_1 -u 0.022344581743374503 > ./result_8chains/node153_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_4_1 -p 770 -st topic153_4_0 -pt topic153_4_1 -u 0.03127226128999802 > ./result_8chains/node153_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_5_1 -p 837 -st topic153_5_0 -pt topic153_5_1 -u 0.04358239717360317 > ./result_8chains/node153_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_6_1 -p 960 -st topic153_6_0 -pt topic153_6_1 -u 0.019643733902829308 > ./result_8chains/node153_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_7_1 -p 990 -st topic153_7_0 -pt topic153_7_1 -u 0.0422155247905619 > ./result_8chains/node153_7_1.txt &
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
    "./result_8chains/node153_0_1.txt 90"
    "./result_8chains/node153_1_1.txt 89"
    "./result_8chains/node153_2_1.txt 88"
    "./result_8chains/node153_3_1.txt 87"
    "./result_8chains/node153_4_1.txt 86"
    "./result_8chains/node153_5_1.txt 85"
    "./result_8chains/node153_6_1.txt 84"
    "./result_8chains/node153_7_1.txt 83"
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
