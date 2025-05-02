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
ros2 run evaluation_3_randomdag uunifast_node -n node142_0_1 -p 243 -st topic142_0_0 -pt topic142_0_1 -u 0.004949758434323326 > ./result_10chains/node142_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_1_1 -p 293 -st topic142_1_0 -pt topic142_1_1 -u 0.005095372507184781 > ./result_10chains/node142_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_2_1 -p 588 -st topic142_2_0 -pt topic142_2_1 -u 0.05674820590187751 > ./result_10chains/node142_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_3_1 -p 686 -st topic142_3_0 -pt topic142_3_1 -u 0.06032067049075984 > ./result_10chains/node142_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_4_1 -p 713 -st topic142_4_0 -pt topic142_4_1 -u 0.0033851404391574413 > ./result_10chains/node142_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_5_1 -p 739 -st topic142_5_0 -pt topic142_5_1 -u 0.0024051545480573977 > ./result_10chains/node142_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_6_1 -p 836 -st topic142_6_0 -pt topic142_6_1 -u 0.05182915454623446 > ./result_10chains/node142_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_7_1 -p 856 -st topic142_7_0 -pt topic142_7_1 -u 0.02652897788865144 > ./result_10chains/node142_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_8_1 -p 873 -st topic142_8_0 -pt topic142_8_1 -u 0.0323366090991702 > ./result_10chains/node142_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node142_9_1 -p 905 -st topic142_9_0 -pt topic142_9_1 -u 0.011238535564881212 > ./result_10chains/node142_9_1.txt &
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
    "./result_10chains/node142_0_1.txt 90"
    "./result_10chains/node142_1_1.txt 89"
    "./result_10chains/node142_2_1.txt 88"
    "./result_10chains/node142_3_1.txt 87"
    "./result_10chains/node142_4_1.txt 86"
    "./result_10chains/node142_5_1.txt 85"
    "./result_10chains/node142_6_1.txt 84"
    "./result_10chains/node142_7_1.txt 83"
    "./result_10chains/node142_8_1.txt 82"
    "./result_10chains/node142_9_1.txt 81"
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
