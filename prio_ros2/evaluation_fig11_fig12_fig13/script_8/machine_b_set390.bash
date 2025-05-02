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
ros2 run evaluation_3_randomdag uunifast_node -n node390_0_1 -p 37 -st topic390_0_0 -pt topic390_0_1 -u 0.019089314691645876 > ./result_8chains/node390_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_1_1 -p 440 -st topic390_1_0 -pt topic390_1_1 -u 0.009780273322973765 > ./result_8chains/node390_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_2_1 -p 480 -st topic390_2_0 -pt topic390_2_1 -u 0.005667429583082584 > ./result_8chains/node390_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_3_1 -p 640 -st topic390_3_0 -pt topic390_3_1 -u 0.018282809350307044 > ./result_8chains/node390_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_4_1 -p 675 -st topic390_4_0 -pt topic390_4_1 -u 0.02425435061790429 > ./result_8chains/node390_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_5_1 -p 733 -st topic390_5_0 -pt topic390_5_1 -u 0.0021986243106996844 > ./result_8chains/node390_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_6_1 -p 759 -st topic390_6_0 -pt topic390_6_1 -u 0.004758781604645525 > ./result_8chains/node390_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_7_1 -p 926 -st topic390_7_0 -pt topic390_7_1 -u 0.01657649509602417 > ./result_8chains/node390_7_1.txt &
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
    "./result_8chains/node390_0_1.txt 90"
    "./result_8chains/node390_1_1.txt 89"
    "./result_8chains/node390_2_1.txt 88"
    "./result_8chains/node390_3_1.txt 87"
    "./result_8chains/node390_4_1.txt 86"
    "./result_8chains/node390_5_1.txt 85"
    "./result_8chains/node390_6_1.txt 84"
    "./result_8chains/node390_7_1.txt 83"
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
