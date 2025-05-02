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
ros2 run evaluation_3_randomdag uunifast_node -n node256_0_1 -p 47 -st topic256_0_0 -pt topic256_0_1 -u 0.008984154534561473 > ./result_8chains/node256_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_1_1 -p 271 -st topic256_1_0 -pt topic256_1_1 -u 0.012850100546712706 > ./result_8chains/node256_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_2_1 -p 273 -st topic256_2_0 -pt topic256_2_1 -u 0.010633985309328131 > ./result_8chains/node256_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_3_1 -p 741 -st topic256_3_0 -pt topic256_3_1 -u 0.008715816179906022 > ./result_8chains/node256_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_4_1 -p 760 -st topic256_4_0 -pt topic256_4_1 -u 0.013360624044186309 > ./result_8chains/node256_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_5_1 -p 768 -st topic256_5_0 -pt topic256_5_1 -u 0.11171193638477694 > ./result_8chains/node256_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_6_1 -p 911 -st topic256_6_0 -pt topic256_6_1 -u 0.025750983703911393 > ./result_8chains/node256_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node256_7_1 -p 935 -st topic256_7_0 -pt topic256_7_1 -u 0.0020951128612394267 > ./result_8chains/node256_7_1.txt &
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
    "./result_8chains/node256_0_1.txt 90"
    "./result_8chains/node256_1_1.txt 89"
    "./result_8chains/node256_2_1.txt 88"
    "./result_8chains/node256_3_1.txt 87"
    "./result_8chains/node256_4_1.txt 86"
    "./result_8chains/node256_5_1.txt 85"
    "./result_8chains/node256_6_1.txt 84"
    "./result_8chains/node256_7_1.txt 83"
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
