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
ros2 run evaluation_3_randomdag uunifast_node -n node134_0_1 -p 143 -st topic134_0_0 -pt topic134_0_1 -u 0.008950064256183832 > ./result_10chains/node134_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_1_1 -p 171 -st topic134_1_0 -pt topic134_1_1 -u 0.007580941680998543 > ./result_10chains/node134_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_2_1 -p 490 -st topic134_2_0 -pt topic134_2_1 -u 0.047963166868426055 > ./result_10chains/node134_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_3_1 -p 530 -st topic134_3_0 -pt topic134_3_1 -u 0.0077302852415620515 > ./result_10chains/node134_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_4_1 -p 533 -st topic134_4_0 -pt topic134_4_1 -u 0.013018615465114514 > ./result_10chains/node134_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_5_1 -p 779 -st topic134_5_0 -pt topic134_5_1 -u 0.009886879510703439 > ./result_10chains/node134_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_6_1 -p 793 -st topic134_6_0 -pt topic134_6_1 -u 0.0002887000013971075 > ./result_10chains/node134_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_7_1 -p 838 -st topic134_7_0 -pt topic134_7_1 -u 0.03855621823654229 > ./result_10chains/node134_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_8_1 -p 958 -st topic134_8_0 -pt topic134_8_1 -u 0.008067529155959943 > ./result_10chains/node134_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node134_9_1 -p 985 -st topic134_9_0 -pt topic134_9_1 -u 0.0007858328272958275 > ./result_10chains/node134_9_1.txt &
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
    "./result_10chains/node134_0_1.txt 90"
    "./result_10chains/node134_1_1.txt 89"
    "./result_10chains/node134_2_1.txt 88"
    "./result_10chains/node134_3_1.txt 87"
    "./result_10chains/node134_4_1.txt 86"
    "./result_10chains/node134_5_1.txt 85"
    "./result_10chains/node134_6_1.txt 84"
    "./result_10chains/node134_7_1.txt 83"
    "./result_10chains/node134_8_1.txt 82"
    "./result_10chains/node134_9_1.txt 81"
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
