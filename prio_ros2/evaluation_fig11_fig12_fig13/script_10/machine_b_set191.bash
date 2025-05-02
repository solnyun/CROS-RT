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
ros2 run evaluation_3_randomdag uunifast_node -n node191_0_1 -p 17 -st topic191_0_0 -pt topic191_0_1 -u 0.004468823894659579 > ./result_10chains/node191_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_1_1 -p 18 -st topic191_1_0 -pt topic191_1_1 -u 0.007074806014127966 > ./result_10chains/node191_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_2_1 -p 68 -st topic191_2_0 -pt topic191_2_1 -u 0.006273017520331325 > ./result_10chains/node191_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_3_1 -p 136 -st topic191_3_0 -pt topic191_3_1 -u 0.008217370827569626 > ./result_10chains/node191_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_4_1 -p 257 -st topic191_4_0 -pt topic191_4_1 -u 0.0001336260402523548 > ./result_10chains/node191_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_5_1 -p 318 -st topic191_5_0 -pt topic191_5_1 -u 0.006586931627992565 > ./result_10chains/node191_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_6_1 -p 387 -st topic191_6_0 -pt topic191_6_1 -u 0.006531172161561183 > ./result_10chains/node191_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_7_1 -p 498 -st topic191_7_0 -pt topic191_7_1 -u 0.03110579396433895 > ./result_10chains/node191_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_8_1 -p 844 -st topic191_8_0 -pt topic191_8_1 -u 0.01308788920500012 > ./result_10chains/node191_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_9_1 -p 871 -st topic191_9_0 -pt topic191_9_1 -u 0.0182508716645522 > ./result_10chains/node191_9_1.txt &
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
    "./result_10chains/node191_0_1.txt 90"
    "./result_10chains/node191_1_1.txt 89"
    "./result_10chains/node191_2_1.txt 88"
    "./result_10chains/node191_3_1.txt 87"
    "./result_10chains/node191_4_1.txt 86"
    "./result_10chains/node191_5_1.txt 85"
    "./result_10chains/node191_6_1.txt 84"
    "./result_10chains/node191_7_1.txt 83"
    "./result_10chains/node191_8_1.txt 82"
    "./result_10chains/node191_9_1.txt 81"
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
