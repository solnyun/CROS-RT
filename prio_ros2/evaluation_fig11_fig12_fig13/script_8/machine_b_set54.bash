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
ros2 run evaluation_3_randomdag uunifast_node -n node54_0_1 -p 52 -st topic54_0_0 -pt topic54_0_1 -u 0.022109852708865618 > ./result_8chains/node54_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_1_1 -p 465 -st topic54_1_0 -pt topic54_1_1 -u 0.04326598974489271 > ./result_8chains/node54_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_2_1 -p 660 -st topic54_2_0 -pt topic54_2_1 -u 0.001657460382912923 > ./result_8chains/node54_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_3_1 -p 661 -st topic54_3_0 -pt topic54_3_1 -u 0.002797316193875965 > ./result_8chains/node54_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_4_1 -p 775 -st topic54_4_0 -pt topic54_4_1 -u 0.005733645228367945 > ./result_8chains/node54_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_5_1 -p 819 -st topic54_5_0 -pt topic54_5_1 -u 0.03244765560739543 > ./result_8chains/node54_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_6_1 -p 875 -st topic54_6_0 -pt topic54_6_1 -u 0.012531439575342515 > ./result_8chains/node54_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_7_1 -p 950 -st topic54_7_0 -pt topic54_7_1 -u 0.029096560696013175 > ./result_8chains/node54_7_1.txt &
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
    "./result_8chains/node54_0_1.txt 90"
    "./result_8chains/node54_1_1.txt 89"
    "./result_8chains/node54_2_1.txt 88"
    "./result_8chains/node54_3_1.txt 87"
    "./result_8chains/node54_4_1.txt 86"
    "./result_8chains/node54_5_1.txt 85"
    "./result_8chains/node54_6_1.txt 84"
    "./result_8chains/node54_7_1.txt 83"
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
