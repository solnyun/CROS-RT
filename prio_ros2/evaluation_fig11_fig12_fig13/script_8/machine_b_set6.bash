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
ros2 run evaluation_3_randomdag uunifast_node -n node6_0_1 -p 21 -st topic6_0_0 -pt topic6_0_1 -u 0.030007543864358555 > ./result_8chains/node6_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_1_1 -p 59 -st topic6_1_0 -pt topic6_1_1 -u 0.010934831586784488 > ./result_8chains/node6_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_2_1 -p 260 -st topic6_2_0 -pt topic6_2_1 -u 0.031781005813176166 > ./result_8chains/node6_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_3_1 -p 273 -st topic6_3_0 -pt topic6_3_1 -u 0.027426625033134255 > ./result_8chains/node6_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_4_1 -p 322 -st topic6_4_0 -pt topic6_4_1 -u 0.02807245541009934 > ./result_8chains/node6_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_5_1 -p 506 -st topic6_5_0 -pt topic6_5_1 -u 0.09520088218934174 > ./result_8chains/node6_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_6_1 -p 587 -st topic6_6_0 -pt topic6_6_1 -u 0.03507567153561762 > ./result_8chains/node6_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_7_1 -p 884 -st topic6_7_0 -pt topic6_7_1 -u 0.018666804988252704 > ./result_8chains/node6_7_1.txt &
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
    "./result_8chains/node6_0_1.txt 90"
    "./result_8chains/node6_1_1.txt 89"
    "./result_8chains/node6_2_1.txt 88"
    "./result_8chains/node6_3_1.txt 87"
    "./result_8chains/node6_4_1.txt 86"
    "./result_8chains/node6_5_1.txt 85"
    "./result_8chains/node6_6_1.txt 84"
    "./result_8chains/node6_7_1.txt 83"
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
