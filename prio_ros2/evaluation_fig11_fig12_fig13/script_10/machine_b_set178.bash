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
ros2 run evaluation_3_randomdag uunifast_node -n node178_0_1 -p 101 -st topic178_0_0 -pt topic178_0_1 -u 0.006262266936402139 > ./result_10chains/node178_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_1_1 -p 289 -st topic178_1_0 -pt topic178_1_1 -u 0.06265486221531191 > ./result_10chains/node178_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_2_1 -p 308 -st topic178_2_0 -pt topic178_2_1 -u 0.010157776985229294 > ./result_10chains/node178_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_3_1 -p 377 -st topic178_3_0 -pt topic178_3_1 -u 0.051749803901907754 > ./result_10chains/node178_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_4_1 -p 530 -st topic178_4_0 -pt topic178_4_1 -u 0.005454164753263463 > ./result_10chains/node178_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_5_1 -p 764 -st topic178_5_0 -pt topic178_5_1 -u 0.02836361133033463 > ./result_10chains/node178_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_6_1 -p 841 -st topic178_6_0 -pt topic178_6_1 -u 0.005863842531462618 > ./result_10chains/node178_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_7_1 -p 843 -st topic178_7_0 -pt topic178_7_1 -u 0.001110498755837172 > ./result_10chains/node178_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_8_1 -p 890 -st topic178_8_0 -pt topic178_8_1 -u 0.005574409266626161 > ./result_10chains/node178_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_9_1 -p 906 -st topic178_9_0 -pt topic178_9_1 -u 0.008445669502787276 > ./result_10chains/node178_9_1.txt &
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
    "./result_10chains/node178_0_1.txt 90"
    "./result_10chains/node178_1_1.txt 89"
    "./result_10chains/node178_2_1.txt 88"
    "./result_10chains/node178_3_1.txt 87"
    "./result_10chains/node178_4_1.txt 86"
    "./result_10chains/node178_5_1.txt 85"
    "./result_10chains/node178_6_1.txt 84"
    "./result_10chains/node178_7_1.txt 83"
    "./result_10chains/node178_8_1.txt 82"
    "./result_10chains/node178_9_1.txt 81"
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
