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
ros2 run evaluation_3_randomdag uunifast_node -n node285_0_1 -p 89 -st topic285_0_0 -pt topic285_0_1 -u 0.011304662460030757 > ./result_8chains/node285_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_1_1 -p 97 -st topic285_1_0 -pt topic285_1_1 -u 0.0032610924152732257 > ./result_8chains/node285_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_2_1 -p 102 -st topic285_2_0 -pt topic285_2_1 -u 0.006557921864290495 > ./result_8chains/node285_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_3_1 -p 398 -st topic285_3_0 -pt topic285_3_1 -u 0.06461644230180924 > ./result_8chains/node285_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_4_1 -p 438 -st topic285_4_0 -pt topic285_4_1 -u 0.0024589043856005077 > ./result_8chains/node285_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_5_1 -p 516 -st topic285_5_0 -pt topic285_5_1 -u 0.013039460298050504 > ./result_8chains/node285_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_6_1 -p 620 -st topic285_6_0 -pt topic285_6_1 -u 0.017312659483345927 > ./result_8chains/node285_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_7_1 -p 825 -st topic285_7_0 -pt topic285_7_1 -u 0.0951309870704499 > ./result_8chains/node285_7_1.txt &
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
    "./result_8chains/node285_0_1.txt 90"
    "./result_8chains/node285_1_1.txt 89"
    "./result_8chains/node285_2_1.txt 88"
    "./result_8chains/node285_3_1.txt 87"
    "./result_8chains/node285_4_1.txt 86"
    "./result_8chains/node285_5_1.txt 85"
    "./result_8chains/node285_6_1.txt 84"
    "./result_8chains/node285_7_1.txt 83"
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
