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
ros2 run evaluation_3_randomdag uunifast_node -n node339_0_1 -p 46 -st topic339_0_0 -pt topic339_0_1 -u 0.00019639059416903804 > ./result_8chains/node339_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_1_1 -p 74 -st topic339_1_0 -pt topic339_1_1 -u 0.006528231460415146 > ./result_8chains/node339_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_2_1 -p 113 -st topic339_2_0 -pt topic339_2_1 -u 0.0017128761039726936 > ./result_8chains/node339_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_3_1 -p 121 -st topic339_3_0 -pt topic339_3_1 -u 0.0007827094327073625 > ./result_8chains/node339_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_4_1 -p 167 -st topic339_4_0 -pt topic339_4_1 -u 0.00989669452712244 > ./result_8chains/node339_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_5_1 -p 403 -st topic339_5_0 -pt topic339_5_1 -u 0.02278050865781947 > ./result_8chains/node339_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_6_1 -p 778 -st topic339_6_0 -pt topic339_6_1 -u 0.04910868975818469 > ./result_8chains/node339_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_7_1 -p 944 -st topic339_7_0 -pt topic339_7_1 -u 0.002168542058427196 > ./result_8chains/node339_7_1.txt &
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
    "./result_8chains/node339_0_1.txt 90"
    "./result_8chains/node339_1_1.txt 89"
    "./result_8chains/node339_2_1.txt 88"
    "./result_8chains/node339_3_1.txt 87"
    "./result_8chains/node339_4_1.txt 86"
    "./result_8chains/node339_5_1.txt 85"
    "./result_8chains/node339_6_1.txt 84"
    "./result_8chains/node339_7_1.txt 83"
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
