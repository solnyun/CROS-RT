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
ros2 run evaluation_3_randomdag uunifast_node -n node50_0_1 -p 34 -st topic50_0_0 -pt topic50_0_1 -u 0.04168724863328205 > ./result_8chains/node50_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node50_1_1 -p 155 -st topic50_1_0 -pt topic50_1_1 -u 0.01611334621179128 > ./result_8chains/node50_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node50_2_1 -p 193 -st topic50_2_0 -pt topic50_2_1 -u 0.008098559259412219 > ./result_8chains/node50_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node50_3_1 -p 240 -st topic50_3_0 -pt topic50_3_1 -u 0.029146977778761685 > ./result_8chains/node50_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node50_4_1 -p 289 -st topic50_4_0 -pt topic50_4_1 -u 0.0029571919774459277 > ./result_8chains/node50_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node50_5_1 -p 381 -st topic50_5_0 -pt topic50_5_1 -u 0.019225762520242745 > ./result_8chains/node50_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node50_6_1 -p 555 -st topic50_6_0 -pt topic50_6_1 -u 0.007824908305005762 > ./result_8chains/node50_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node50_7_1 -p 795 -st topic50_7_0 -pt topic50_7_1 -u 0.013021581482362092 > ./result_8chains/node50_7_1.txt &
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
    "./result_8chains/node50_0_1.txt 90"
    "./result_8chains/node50_1_1.txt 89"
    "./result_8chains/node50_2_1.txt 88"
    "./result_8chains/node50_3_1.txt 87"
    "./result_8chains/node50_4_1.txt 86"
    "./result_8chains/node50_5_1.txt 85"
    "./result_8chains/node50_6_1.txt 84"
    "./result_8chains/node50_7_1.txt 83"
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
