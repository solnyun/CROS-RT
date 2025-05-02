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
ros2 run evaluation_3_randomdag uunifast_node -n node25_0_1 -p 21 -st topic25_0_0 -pt topic25_0_1 -u 0.004676489326412181 > ./result_10chains/node25_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node25_1_1 -p 104 -st topic25_1_0 -pt topic25_1_1 -u 0.017515024744722996 > ./result_10chains/node25_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node25_2_1 -p 246 -st topic25_2_0 -pt topic25_2_1 -u 0.008587486352179097 > ./result_10chains/node25_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node25_3_1 -p 275 -st topic25_3_0 -pt topic25_3_1 -u 0.032443760005213707 > ./result_10chains/node25_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node25_4_1 -p 474 -st topic25_4_0 -pt topic25_4_1 -u 0.08208427598221082 > ./result_10chains/node25_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node25_5_1 -p 558 -st topic25_5_0 -pt topic25_5_1 -u 0.0008059782394474191 > ./result_10chains/node25_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node25_6_1 -p 724 -st topic25_6_0 -pt topic25_6_1 -u 0.006251048429627648 > ./result_10chains/node25_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node25_7_1 -p 769 -st topic25_7_0 -pt topic25_7_1 -u 0.001817084123533666 > ./result_10chains/node25_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node25_8_1 -p 935 -st topic25_8_0 -pt topic25_8_1 -u 0.022885997084835977 > ./result_10chains/node25_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node25_9_1 -p 963 -st topic25_9_0 -pt topic25_9_1 -u 0.002727629105692268 > ./result_10chains/node25_9_1.txt &
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
    "./result_10chains/node25_0_1.txt 90"
    "./result_10chains/node25_1_1.txt 89"
    "./result_10chains/node25_2_1.txt 88"
    "./result_10chains/node25_3_1.txt 87"
    "./result_10chains/node25_4_1.txt 86"
    "./result_10chains/node25_5_1.txt 85"
    "./result_10chains/node25_6_1.txt 84"
    "./result_10chains/node25_7_1.txt 83"
    "./result_10chains/node25_8_1.txt 82"
    "./result_10chains/node25_9_1.txt 81"
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
