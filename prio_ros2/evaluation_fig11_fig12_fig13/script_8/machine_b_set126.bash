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
ros2 run evaluation_3_randomdag uunifast_node -n node126_0_1 -p 24 -st topic126_0_0 -pt topic126_0_1 -u 0.036572293252476684 > ./result_8chains/node126_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_1_1 -p 154 -st topic126_1_0 -pt topic126_1_1 -u 0.010374056666143161 > ./result_8chains/node126_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_2_1 -p 167 -st topic126_2_0 -pt topic126_2_1 -u 0.05137282165261431 > ./result_8chains/node126_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_3_1 -p 220 -st topic126_3_0 -pt topic126_3_1 -u 0.004444470442354798 > ./result_8chains/node126_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_4_1 -p 362 -st topic126_4_0 -pt topic126_4_1 -u 0.010998161283627905 > ./result_8chains/node126_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_5_1 -p 479 -st topic126_5_0 -pt topic126_5_1 -u 0.007556618766166895 > ./result_8chains/node126_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_6_1 -p 883 -st topic126_6_0 -pt topic126_6_1 -u 0.011377648122980394 > ./result_8chains/node126_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node126_7_1 -p 921 -st topic126_7_0 -pt topic126_7_1 -u 0.030664827903539662 > ./result_8chains/node126_7_1.txt &
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
    "./result_8chains/node126_0_1.txt 90"
    "./result_8chains/node126_1_1.txt 89"
    "./result_8chains/node126_2_1.txt 88"
    "./result_8chains/node126_3_1.txt 87"
    "./result_8chains/node126_4_1.txt 86"
    "./result_8chains/node126_5_1.txt 85"
    "./result_8chains/node126_6_1.txt 84"
    "./result_8chains/node126_7_1.txt 83"
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
