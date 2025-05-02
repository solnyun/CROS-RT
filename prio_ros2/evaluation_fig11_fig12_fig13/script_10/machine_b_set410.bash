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
ros2 run evaluation_3_randomdag uunifast_node -n node410_0_1 -p 39 -st topic410_0_0 -pt topic410_0_1 -u 0.008482227458625813 > ./result_10chains/node410_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_1_1 -p 217 -st topic410_1_0 -pt topic410_1_1 -u 0.042557426551472766 > ./result_10chains/node410_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_2_1 -p 218 -st topic410_2_0 -pt topic410_2_1 -u 0.016389665044634627 > ./result_10chains/node410_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_3_1 -p 446 -st topic410_3_0 -pt topic410_3_1 -u 0.002214307654181902 > ./result_10chains/node410_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_4_1 -p 499 -st topic410_4_0 -pt topic410_4_1 -u 0.003881838282457084 > ./result_10chains/node410_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_5_1 -p 571 -st topic410_5_0 -pt topic410_5_1 -u 0.053074259093429055 > ./result_10chains/node410_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_6_1 -p 574 -st topic410_6_0 -pt topic410_6_1 -u 0.051450580931840226 > ./result_10chains/node410_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_7_1 -p 873 -st topic410_7_0 -pt topic410_7_1 -u 0.003400057770010595 > ./result_10chains/node410_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_8_1 -p 925 -st topic410_8_0 -pt topic410_8_1 -u 0.006614652052527828 > ./result_10chains/node410_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node410_9_1 -p 991 -st topic410_9_0 -pt topic410_9_1 -u 0.002005750785680188 > ./result_10chains/node410_9_1.txt &
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
    "./result_10chains/node410_0_1.txt 90"
    "./result_10chains/node410_1_1.txt 89"
    "./result_10chains/node410_2_1.txt 88"
    "./result_10chains/node410_3_1.txt 87"
    "./result_10chains/node410_4_1.txt 86"
    "./result_10chains/node410_5_1.txt 85"
    "./result_10chains/node410_6_1.txt 84"
    "./result_10chains/node410_7_1.txt 83"
    "./result_10chains/node410_8_1.txt 82"
    "./result_10chains/node410_9_1.txt 81"
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
