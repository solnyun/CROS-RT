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
ros2 run evaluation_3_randomdag uunifast_node -n node163_0_1 -p 144 -st topic163_0_0 -pt topic163_0_1 -u 0.00672085968962699 > ./result_8chains/node163_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_1_1 -p 236 -st topic163_1_0 -pt topic163_1_1 -u 0.049761811537227085 > ./result_8chains/node163_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_2_1 -p 649 -st topic163_2_0 -pt topic163_2_1 -u 0.03459536938759489 > ./result_8chains/node163_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_3_1 -p 742 -st topic163_3_0 -pt topic163_3_1 -u 0.021938026614124695 > ./result_8chains/node163_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_4_1 -p 749 -st topic163_4_0 -pt topic163_4_1 -u 0.03473755391332836 > ./result_8chains/node163_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_5_1 -p 812 -st topic163_5_0 -pt topic163_5_1 -u 0.011038077860121981 > ./result_8chains/node163_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_6_1 -p 907 -st topic163_6_0 -pt topic163_6_1 -u 0.008122083210200796 > ./result_8chains/node163_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node163_7_1 -p 992 -st topic163_7_0 -pt topic163_7_1 -u 0.026435803780262116 > ./result_8chains/node163_7_1.txt &
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
    "./result_8chains/node163_0_1.txt 90"
    "./result_8chains/node163_1_1.txt 89"
    "./result_8chains/node163_2_1.txt 88"
    "./result_8chains/node163_3_1.txt 87"
    "./result_8chains/node163_4_1.txt 86"
    "./result_8chains/node163_5_1.txt 85"
    "./result_8chains/node163_6_1.txt 84"
    "./result_8chains/node163_7_1.txt 83"
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
