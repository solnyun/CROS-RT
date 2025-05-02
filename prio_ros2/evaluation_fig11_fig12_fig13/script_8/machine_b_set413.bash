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
ros2 run evaluation_3_randomdag uunifast_node -n node413_0_1 -p 108 -st topic413_0_0 -pt topic413_0_1 -u 0.03885395673268599 > ./result_8chains/node413_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_1_1 -p 192 -st topic413_1_0 -pt topic413_1_1 -u 0.035670828762374984 > ./result_8chains/node413_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_2_1 -p 561 -st topic413_2_0 -pt topic413_2_1 -u 0.026134062675155056 > ./result_8chains/node413_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_3_1 -p 702 -st topic413_3_0 -pt topic413_3_1 -u 0.003996985507689954 > ./result_8chains/node413_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_4_1 -p 784 -st topic413_4_0 -pt topic413_4_1 -u 0.0029453652790391027 > ./result_8chains/node413_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_5_1 -p 866 -st topic413_5_0 -pt topic413_5_1 -u 0.0020383267852611964 > ./result_8chains/node413_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_6_1 -p 919 -st topic413_6_0 -pt topic413_6_1 -u 0.011308187758878374 > ./result_8chains/node413_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_7_1 -p 925 -st topic413_7_0 -pt topic413_7_1 -u 0.015969827549557572 > ./result_8chains/node413_7_1.txt &
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
    "./result_8chains/node413_0_1.txt 90"
    "./result_8chains/node413_1_1.txt 89"
    "./result_8chains/node413_2_1.txt 88"
    "./result_8chains/node413_3_1.txt 87"
    "./result_8chains/node413_4_1.txt 86"
    "./result_8chains/node413_5_1.txt 85"
    "./result_8chains/node413_6_1.txt 84"
    "./result_8chains/node413_7_1.txt 83"
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
