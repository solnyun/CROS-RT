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
ros2 run evaluation_3_randomdag uunifast_node -n node12_0_1 -p 35 -st topic12_0_0 -pt topic12_0_1 -u 0.004984061214145852 > ./result_10chains/node12_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_1_1 -p 43 -st topic12_1_0 -pt topic12_1_1 -u 0.0025961862779797507 > ./result_10chains/node12_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_2_1 -p 190 -st topic12_2_0 -pt topic12_2_1 -u 0.04924302723790103 > ./result_10chains/node12_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_3_1 -p 277 -st topic12_3_0 -pt topic12_3_1 -u 0.01590189847774648 > ./result_10chains/node12_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_4_1 -p 444 -st topic12_4_0 -pt topic12_4_1 -u 0.017533553260403067 > ./result_10chains/node12_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_5_1 -p 469 -st topic12_5_0 -pt topic12_5_1 -u 0.00415865494280504 > ./result_10chains/node12_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_6_1 -p 483 -st topic12_6_0 -pt topic12_6_1 -u 0.018304979661938475 > ./result_10chains/node12_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_7_1 -p 497 -st topic12_7_0 -pt topic12_7_1 -u 0.006233998173867633 > ./result_10chains/node12_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_8_1 -p 604 -st topic12_8_0 -pt topic12_8_1 -u 0.0036980353652071585 > ./result_10chains/node12_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node12_9_1 -p 888 -st topic12_9_0 -pt topic12_9_1 -u 0.01230912649129038 > ./result_10chains/node12_9_1.txt &
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
    "./result_10chains/node12_0_1.txt 90"
    "./result_10chains/node12_1_1.txt 89"
    "./result_10chains/node12_2_1.txt 88"
    "./result_10chains/node12_3_1.txt 87"
    "./result_10chains/node12_4_1.txt 86"
    "./result_10chains/node12_5_1.txt 85"
    "./result_10chains/node12_6_1.txt 84"
    "./result_10chains/node12_7_1.txt 83"
    "./result_10chains/node12_8_1.txt 82"
    "./result_10chains/node12_9_1.txt 81"
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
