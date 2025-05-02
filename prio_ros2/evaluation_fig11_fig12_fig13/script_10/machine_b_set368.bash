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
ros2 run evaluation_3_randomdag uunifast_node -n node368_0_1 -p 41 -st topic368_0_0 -pt topic368_0_1 -u 0.013900194308199776 > ./result_10chains/node368_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_1_1 -p 246 -st topic368_1_0 -pt topic368_1_1 -u 0.02224166162228014 > ./result_10chains/node368_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_2_1 -p 425 -st topic368_2_0 -pt topic368_2_1 -u 0.008843645823086277 > ./result_10chains/node368_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_3_1 -p 436 -st topic368_3_0 -pt topic368_3_1 -u 0.015496391677680965 > ./result_10chains/node368_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_4_1 -p 506 -st topic368_4_0 -pt topic368_4_1 -u 0.0268001495250918 > ./result_10chains/node368_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_5_1 -p 523 -st topic368_5_0 -pt topic368_5_1 -u 0.03075805085947128 > ./result_10chains/node368_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_6_1 -p 613 -st topic368_6_0 -pt topic368_6_1 -u 0.0008118482884362788 > ./result_10chains/node368_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_7_1 -p 616 -st topic368_7_0 -pt topic368_7_1 -u 0.019687369788981807 > ./result_10chains/node368_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_8_1 -p 710 -st topic368_8_0 -pt topic368_8_1 -u 0.005592958601765258 > ./result_10chains/node368_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node368_9_1 -p 897 -st topic368_9_0 -pt topic368_9_1 -u 0.009585628948817093 > ./result_10chains/node368_9_1.txt &
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
    "./result_10chains/node368_0_1.txt 90"
    "./result_10chains/node368_1_1.txt 89"
    "./result_10chains/node368_2_1.txt 88"
    "./result_10chains/node368_3_1.txt 87"
    "./result_10chains/node368_4_1.txt 86"
    "./result_10chains/node368_5_1.txt 85"
    "./result_10chains/node368_6_1.txt 84"
    "./result_10chains/node368_7_1.txt 83"
    "./result_10chains/node368_8_1.txt 82"
    "./result_10chains/node368_9_1.txt 81"
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
