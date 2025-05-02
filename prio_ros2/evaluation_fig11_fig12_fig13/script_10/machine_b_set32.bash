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
ros2 run evaluation_3_randomdag uunifast_node -n node32_0_1 -p 36 -st topic32_0_0 -pt topic32_0_1 -u 0.0207727060587356 > ./result_10chains/node32_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_1_1 -p 149 -st topic32_1_0 -pt topic32_1_1 -u 0.005658998132383408 > ./result_10chains/node32_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_2_1 -p 330 -st topic32_2_0 -pt topic32_2_1 -u 0.001120339468344056 > ./result_10chains/node32_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_3_1 -p 483 -st topic32_3_0 -pt topic32_3_1 -u 0.01911025310235076 > ./result_10chains/node32_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_4_1 -p 510 -st topic32_4_0 -pt topic32_4_1 -u 0.0027263105952311517 > ./result_10chains/node32_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_5_1 -p 574 -st topic32_5_0 -pt topic32_5_1 -u 0.03422379717090418 > ./result_10chains/node32_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_6_1 -p 643 -st topic32_6_0 -pt topic32_6_1 -u 0.004413100230130029 > ./result_10chains/node32_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_7_1 -p 681 -st topic32_7_0 -pt topic32_7_1 -u 0.007043032790885417 > ./result_10chains/node32_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_8_1 -p 808 -st topic32_8_0 -pt topic32_8_1 -u 0.013346063826689597 > ./result_10chains/node32_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_9_1 -p 991 -st topic32_9_0 -pt topic32_9_1 -u 0.0040099549375591514 > ./result_10chains/node32_9_1.txt &
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
    "./result_10chains/node32_0_1.txt 90"
    "./result_10chains/node32_1_1.txt 89"
    "./result_10chains/node32_2_1.txt 88"
    "./result_10chains/node32_3_1.txt 87"
    "./result_10chains/node32_4_1.txt 86"
    "./result_10chains/node32_5_1.txt 85"
    "./result_10chains/node32_6_1.txt 84"
    "./result_10chains/node32_7_1.txt 83"
    "./result_10chains/node32_8_1.txt 82"
    "./result_10chains/node32_9_1.txt 81"
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
