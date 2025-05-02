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
ros2 run evaluation_3_randomdag uunifast_node -n node283_0_1 -p 195 -st topic283_0_0 -pt topic283_0_1 -u 0.0005721035432711963 > ./result_10chains/node283_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_1_1 -p 265 -st topic283_1_0 -pt topic283_1_1 -u 0.015334646930595497 > ./result_10chains/node283_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_2_1 -p 395 -st topic283_2_0 -pt topic283_2_1 -u 0.0017898429986932252 > ./result_10chains/node283_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_3_1 -p 425 -st topic283_3_0 -pt topic283_3_1 -u 0.019259572942968928 > ./result_10chains/node283_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_4_1 -p 435 -st topic283_4_0 -pt topic283_4_1 -u 0.04133395118205441 > ./result_10chains/node283_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_5_1 -p 448 -st topic283_5_0 -pt topic283_5_1 -u 0.008416703608008641 > ./result_10chains/node283_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_6_1 -p 663 -st topic283_6_0 -pt topic283_6_1 -u 0.003110071022909111 > ./result_10chains/node283_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_7_1 -p 749 -st topic283_7_0 -pt topic283_7_1 -u 0.0054917143977734895 > ./result_10chains/node283_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_8_1 -p 774 -st topic283_8_0 -pt topic283_8_1 -u 0.03679712485966195 > ./result_10chains/node283_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node283_9_1 -p 962 -st topic283_9_0 -pt topic283_9_1 -u 0.02011878938431577 > ./result_10chains/node283_9_1.txt &
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
    "./result_10chains/node283_0_1.txt 90"
    "./result_10chains/node283_1_1.txt 89"
    "./result_10chains/node283_2_1.txt 88"
    "./result_10chains/node283_3_1.txt 87"
    "./result_10chains/node283_4_1.txt 86"
    "./result_10chains/node283_5_1.txt 85"
    "./result_10chains/node283_6_1.txt 84"
    "./result_10chains/node283_7_1.txt 83"
    "./result_10chains/node283_8_1.txt 82"
    "./result_10chains/node283_9_1.txt 81"
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
