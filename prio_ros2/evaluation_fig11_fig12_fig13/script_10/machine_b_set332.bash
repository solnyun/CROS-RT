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
ros2 run evaluation_3_randomdag uunifast_node -n node332_0_1 -p 83 -st topic332_0_0 -pt topic332_0_1 -u 0.021568894184377074 > ./result_10chains/node332_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_1_1 -p 208 -st topic332_1_0 -pt topic332_1_1 -u 0.019632645038497265 > ./result_10chains/node332_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_2_1 -p 322 -st topic332_2_0 -pt topic332_2_1 -u 0.05509730836032267 > ./result_10chains/node332_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_3_1 -p 553 -st topic332_3_0 -pt topic332_3_1 -u 0.0056602424398185525 > ./result_10chains/node332_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_4_1 -p 622 -st topic332_4_0 -pt topic332_4_1 -u 0.018441459909792124 > ./result_10chains/node332_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_5_1 -p 653 -st topic332_5_0 -pt topic332_5_1 -u 0.0020153506019813527 > ./result_10chains/node332_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_6_1 -p 668 -st topic332_6_0 -pt topic332_6_1 -u 0.007912276937529633 > ./result_10chains/node332_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_7_1 -p 698 -st topic332_7_0 -pt topic332_7_1 -u 0.005551254879311407 > ./result_10chains/node332_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_8_1 -p 780 -st topic332_8_0 -pt topic332_8_1 -u 0.0030017610309300558 > ./result_10chains/node332_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node332_9_1 -p 927 -st topic332_9_0 -pt topic332_9_1 -u 0.022753924766156626 > ./result_10chains/node332_9_1.txt &
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
    "./result_10chains/node332_0_1.txt 90"
    "./result_10chains/node332_1_1.txt 89"
    "./result_10chains/node332_2_1.txt 88"
    "./result_10chains/node332_3_1.txt 87"
    "./result_10chains/node332_4_1.txt 86"
    "./result_10chains/node332_5_1.txt 85"
    "./result_10chains/node332_6_1.txt 84"
    "./result_10chains/node332_7_1.txt 83"
    "./result_10chains/node332_8_1.txt 82"
    "./result_10chains/node332_9_1.txt 81"
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
