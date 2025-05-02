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
ros2 run evaluation_3_randomdag uunifast_node -n node265_0_1 -p 140 -st topic265_0_0 -pt topic265_0_1 -u 0.02833643502774924 > ./result_10chains/node265_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_1_1 -p 158 -st topic265_1_0 -pt topic265_1_1 -u 0.028005049187631637 > ./result_10chains/node265_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_2_1 -p 171 -st topic265_2_0 -pt topic265_2_1 -u 0.005767250270369839 > ./result_10chains/node265_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_3_1 -p 483 -st topic265_3_0 -pt topic265_3_1 -u 0.010455020331766096 > ./result_10chains/node265_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_4_1 -p 484 -st topic265_4_0 -pt topic265_4_1 -u 0.007257075919546607 > ./result_10chains/node265_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_5_1 -p 610 -st topic265_5_0 -pt topic265_5_1 -u 0.015339512518199871 > ./result_10chains/node265_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_6_1 -p 642 -st topic265_6_0 -pt topic265_6_1 -u 0.017679224608343647 > ./result_10chains/node265_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_7_1 -p 767 -st topic265_7_0 -pt topic265_7_1 -u 0.03332797068605983 > ./result_10chains/node265_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_8_1 -p 867 -st topic265_8_0 -pt topic265_8_1 -u 0.0189895009231386 > ./result_10chains/node265_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_9_1 -p 983 -st topic265_9_0 -pt topic265_9_1 -u 0.021716679824650212 > ./result_10chains/node265_9_1.txt &
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
    "./result_10chains/node265_0_1.txt 90"
    "./result_10chains/node265_1_1.txt 89"
    "./result_10chains/node265_2_1.txt 88"
    "./result_10chains/node265_3_1.txt 87"
    "./result_10chains/node265_4_1.txt 86"
    "./result_10chains/node265_5_1.txt 85"
    "./result_10chains/node265_6_1.txt 84"
    "./result_10chains/node265_7_1.txt 83"
    "./result_10chains/node265_8_1.txt 82"
    "./result_10chains/node265_9_1.txt 81"
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
