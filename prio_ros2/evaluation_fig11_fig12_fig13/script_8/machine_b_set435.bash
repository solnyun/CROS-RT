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
ros2 run evaluation_3_randomdag uunifast_node -n node435_0_1 -p 11 -st topic435_0_0 -pt topic435_0_1 -u 0.010946371511072472 > ./result_8chains/node435_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_1_1 -p 155 -st topic435_1_0 -pt topic435_1_1 -u 0.01505453817435265 > ./result_8chains/node435_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_2_1 -p 182 -st topic435_2_0 -pt topic435_2_1 -u 0.007644473706965915 > ./result_8chains/node435_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_3_1 -p 305 -st topic435_3_0 -pt topic435_3_1 -u 0.010918912214654408 > ./result_8chains/node435_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_4_1 -p 754 -st topic435_4_0 -pt topic435_4_1 -u 0.05905083125965027 > ./result_8chains/node435_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_5_1 -p 861 -st topic435_5_0 -pt topic435_5_1 -u 0.03372650146970102 > ./result_8chains/node435_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_6_1 -p 931 -st topic435_6_0 -pt topic435_6_1 -u 0.0022320121784924207 > ./result_8chains/node435_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_7_1 -p 959 -st topic435_7_0 -pt topic435_7_1 -u 0.035473805849710875 > ./result_8chains/node435_7_1.txt &
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
    "./result_8chains/node435_0_1.txt 90"
    "./result_8chains/node435_1_1.txt 89"
    "./result_8chains/node435_2_1.txt 88"
    "./result_8chains/node435_3_1.txt 87"
    "./result_8chains/node435_4_1.txt 86"
    "./result_8chains/node435_5_1.txt 85"
    "./result_8chains/node435_6_1.txt 84"
    "./result_8chains/node435_7_1.txt 83"
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
