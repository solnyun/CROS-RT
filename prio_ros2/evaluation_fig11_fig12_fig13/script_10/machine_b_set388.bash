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
ros2 run evaluation_3_randomdag uunifast_node -n node388_0_1 -p 11 -st topic388_0_0 -pt topic388_0_1 -u 0.012681035280788455 > ./result_10chains/node388_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_1_1 -p 56 -st topic388_1_0 -pt topic388_1_1 -u 0.014525867316946994 > ./result_10chains/node388_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_2_1 -p 156 -st topic388_2_0 -pt topic388_2_1 -u 0.01697911459587842 > ./result_10chains/node388_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_3_1 -p 226 -st topic388_3_0 -pt topic388_3_1 -u 0.016262053957421585 > ./result_10chains/node388_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_4_1 -p 274 -st topic388_4_0 -pt topic388_4_1 -u 0.0041619522792109565 > ./result_10chains/node388_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_5_1 -p 323 -st topic388_5_0 -pt topic388_5_1 -u 0.014388089783099245 > ./result_10chains/node388_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_6_1 -p 624 -st topic388_6_0 -pt topic388_6_1 -u 0.021796374914021532 > ./result_10chains/node388_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_7_1 -p 655 -st topic388_7_0 -pt topic388_7_1 -u 0.005518498484870793 > ./result_10chains/node388_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_8_1 -p 732 -st topic388_8_0 -pt topic388_8_1 -u 0.017448376471471516 > ./result_10chains/node388_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_9_1 -p 927 -st topic388_9_0 -pt topic388_9_1 -u 0.007306506808143119 > ./result_10chains/node388_9_1.txt &
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
    "./result_10chains/node388_0_1.txt 90"
    "./result_10chains/node388_1_1.txt 89"
    "./result_10chains/node388_2_1.txt 88"
    "./result_10chains/node388_3_1.txt 87"
    "./result_10chains/node388_4_1.txt 86"
    "./result_10chains/node388_5_1.txt 85"
    "./result_10chains/node388_6_1.txt 84"
    "./result_10chains/node388_7_1.txt 83"
    "./result_10chains/node388_8_1.txt 82"
    "./result_10chains/node388_9_1.txt 81"
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
