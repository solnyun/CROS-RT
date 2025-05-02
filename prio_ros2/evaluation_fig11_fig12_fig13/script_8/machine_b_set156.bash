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
ros2 run evaluation_3_randomdag uunifast_node -n node156_0_1 -p 172 -st topic156_0_0 -pt topic156_0_1 -u 0.029607797550154802 > ./result_8chains/node156_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_1_1 -p 236 -st topic156_1_0 -pt topic156_1_1 -u 0.009899362049412053 > ./result_8chains/node156_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_2_1 -p 417 -st topic156_2_0 -pt topic156_2_1 -u 6.552709588031336e-05 > ./result_8chains/node156_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_3_1 -p 499 -st topic156_3_0 -pt topic156_3_1 -u 0.026202698566563043 > ./result_8chains/node156_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_4_1 -p 511 -st topic156_4_0 -pt topic156_4_1 -u 0.006224818844186464 > ./result_8chains/node156_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_5_1 -p 524 -st topic156_5_0 -pt topic156_5_1 -u 0.0087384438773139 > ./result_8chains/node156_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_6_1 -p 725 -st topic156_6_0 -pt topic156_6_1 -u 0.0303269123532985 > ./result_8chains/node156_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_7_1 -p 734 -st topic156_7_0 -pt topic156_7_1 -u 0.0007649358282962176 > ./result_8chains/node156_7_1.txt &
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
    "./result_8chains/node156_0_1.txt 90"
    "./result_8chains/node156_1_1.txt 89"
    "./result_8chains/node156_2_1.txt 88"
    "./result_8chains/node156_3_1.txt 87"
    "./result_8chains/node156_4_1.txt 86"
    "./result_8chains/node156_5_1.txt 85"
    "./result_8chains/node156_6_1.txt 84"
    "./result_8chains/node156_7_1.txt 83"
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
