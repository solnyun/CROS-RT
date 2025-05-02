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
ros2 run evaluation_3_randomdag uunifast_node -n node334_0_1 -p 83 -st topic334_0_0 -pt topic334_0_1 -u 0.016509128434428477 > ./result_10chains/node334_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_1_1 -p 140 -st topic334_1_0 -pt topic334_1_1 -u 0.03959194884236522 > ./result_10chains/node334_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_2_1 -p 312 -st topic334_2_0 -pt topic334_2_1 -u 0.0073685524295334925 > ./result_10chains/node334_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_3_1 -p 511 -st topic334_3_0 -pt topic334_3_1 -u 0.011863464375518051 > ./result_10chains/node334_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_4_1 -p 564 -st topic334_4_0 -pt topic334_4_1 -u 0.0008201174889817253 > ./result_10chains/node334_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_5_1 -p 722 -st topic334_5_0 -pt topic334_5_1 -u 0.020922568136633762 > ./result_10chains/node334_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_6_1 -p 773 -st topic334_6_0 -pt topic334_6_1 -u 0.01309100630901569 > ./result_10chains/node334_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_7_1 -p 797 -st topic334_7_0 -pt topic334_7_1 -u 0.017593502626656543 > ./result_10chains/node334_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_8_1 -p 923 -st topic334_8_0 -pt topic334_8_1 -u 0.024795960390455174 > ./result_10chains/node334_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_9_1 -p 980 -st topic334_9_0 -pt topic334_9_1 -u 0.010611254553699408 > ./result_10chains/node334_9_1.txt &
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
    "./result_10chains/node334_0_1.txt 90"
    "./result_10chains/node334_1_1.txt 89"
    "./result_10chains/node334_2_1.txt 88"
    "./result_10chains/node334_3_1.txt 87"
    "./result_10chains/node334_4_1.txt 86"
    "./result_10chains/node334_5_1.txt 85"
    "./result_10chains/node334_6_1.txt 84"
    "./result_10chains/node334_7_1.txt 83"
    "./result_10chains/node334_8_1.txt 82"
    "./result_10chains/node334_9_1.txt 81"
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
