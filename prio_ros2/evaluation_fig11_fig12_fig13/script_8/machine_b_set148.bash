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
ros2 run evaluation_3_randomdag uunifast_node -n node148_0_1 -p 100 -st topic148_0_0 -pt topic148_0_1 -u 0.018416642336003763 > ./result_8chains/node148_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_1_1 -p 218 -st topic148_1_0 -pt topic148_1_1 -u 0.024019099889755258 > ./result_8chains/node148_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_2_1 -p 423 -st topic148_2_0 -pt topic148_2_1 -u 0.007954863128796508 > ./result_8chains/node148_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_3_1 -p 589 -st topic148_3_0 -pt topic148_3_1 -u 0.0711248156468231 > ./result_8chains/node148_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_4_1 -p 647 -st topic148_4_0 -pt topic148_4_1 -u 0.009334321053399874 > ./result_8chains/node148_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_5_1 -p 707 -st topic148_5_0 -pt topic148_5_1 -u 0.007393610793806071 > ./result_8chains/node148_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_6_1 -p 714 -st topic148_6_0 -pt topic148_6_1 -u 0.025463416667639502 > ./result_8chains/node148_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_7_1 -p 974 -st topic148_7_0 -pt topic148_7_1 -u 0.057921061795158595 > ./result_8chains/node148_7_1.txt &
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
    "./result_8chains/node148_0_1.txt 90"
    "./result_8chains/node148_1_1.txt 89"
    "./result_8chains/node148_2_1.txt 88"
    "./result_8chains/node148_3_1.txt 87"
    "./result_8chains/node148_4_1.txt 86"
    "./result_8chains/node148_5_1.txt 85"
    "./result_8chains/node148_6_1.txt 84"
    "./result_8chains/node148_7_1.txt 83"
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
