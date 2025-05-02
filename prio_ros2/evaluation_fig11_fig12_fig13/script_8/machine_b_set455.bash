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
ros2 run evaluation_3_randomdag uunifast_node -n node455_0_1 -p 19 -st topic455_0_0 -pt topic455_0_1 -u 0.010796396034589706 > ./result_8chains/node455_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_1_1 -p 373 -st topic455_1_0 -pt topic455_1_1 -u 0.04445112303196952 > ./result_8chains/node455_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_2_1 -p 481 -st topic455_2_0 -pt topic455_2_1 -u 0.0031415990754946055 > ./result_8chains/node455_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_3_1 -p 585 -st topic455_3_0 -pt topic455_3_1 -u 0.0194801896859636 > ./result_8chains/node455_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_4_1 -p 641 -st topic455_4_0 -pt topic455_4_1 -u 0.03534424549932058 > ./result_8chains/node455_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_5_1 -p 819 -st topic455_5_0 -pt topic455_5_1 -u 0.019230541695214293 > ./result_8chains/node455_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_6_1 -p 952 -st topic455_6_0 -pt topic455_6_1 -u 0.005370021781572129 > ./result_8chains/node455_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_7_1 -p 993 -st topic455_7_0 -pt topic455_7_1 -u 0.03619634882703915 > ./result_8chains/node455_7_1.txt &
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
    "./result_8chains/node455_0_1.txt 90"
    "./result_8chains/node455_1_1.txt 89"
    "./result_8chains/node455_2_1.txt 88"
    "./result_8chains/node455_3_1.txt 87"
    "./result_8chains/node455_4_1.txt 86"
    "./result_8chains/node455_5_1.txt 85"
    "./result_8chains/node455_6_1.txt 84"
    "./result_8chains/node455_7_1.txt 83"
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
