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
ros2 run evaluation_3_randomdag uunifast_node -n node404_0_1 -p 29 -st topic404_0_0 -pt topic404_0_1 -u 0.007408243294075301 > ./result_10chains/node404_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_1_1 -p 313 -st topic404_1_0 -pt topic404_1_1 -u 0.0047493387926699215 > ./result_10chains/node404_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_2_1 -p 436 -st topic404_2_0 -pt topic404_2_1 -u 0.006139312454424173 > ./result_10chains/node404_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_3_1 -p 564 -st topic404_3_0 -pt topic404_3_1 -u 0.1039687555659018 > ./result_10chains/node404_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_4_1 -p 639 -st topic404_4_0 -pt topic404_4_1 -u 0.0026609919918513802 > ./result_10chains/node404_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_5_1 -p 658 -st topic404_5_0 -pt topic404_5_1 -u 0.0003837193092482427 > ./result_10chains/node404_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_6_1 -p 771 -st topic404_6_0 -pt topic404_6_1 -u 0.0019309678203441871 > ./result_10chains/node404_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_7_1 -p 794 -st topic404_7_0 -pt topic404_7_1 -u 0.0009722845407822978 > ./result_10chains/node404_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_8_1 -p 820 -st topic404_8_0 -pt topic404_8_1 -u 0.005386697421220596 > ./result_10chains/node404_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node404_9_1 -p 919 -st topic404_9_0 -pt topic404_9_1 -u 0.006688079251940449 > ./result_10chains/node404_9_1.txt &
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
    "./result_10chains/node404_0_1.txt 90"
    "./result_10chains/node404_1_1.txt 89"
    "./result_10chains/node404_2_1.txt 88"
    "./result_10chains/node404_3_1.txt 87"
    "./result_10chains/node404_4_1.txt 86"
    "./result_10chains/node404_5_1.txt 85"
    "./result_10chains/node404_6_1.txt 84"
    "./result_10chains/node404_7_1.txt 83"
    "./result_10chains/node404_8_1.txt 82"
    "./result_10chains/node404_9_1.txt 81"
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
