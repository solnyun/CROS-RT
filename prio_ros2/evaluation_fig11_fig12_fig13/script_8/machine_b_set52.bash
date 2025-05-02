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
ros2 run evaluation_3_randomdag uunifast_node -n node52_0_1 -p 76 -st topic52_0_0 -pt topic52_0_1 -u 0.07160642099475362 > ./result_8chains/node52_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_1_1 -p 243 -st topic52_1_0 -pt topic52_1_1 -u 0.008436806976805045 > ./result_8chains/node52_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_2_1 -p 367 -st topic52_2_0 -pt topic52_2_1 -u 0.0020480762957599263 > ./result_8chains/node52_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_3_1 -p 496 -st topic52_3_0 -pt topic52_3_1 -u 0.04552531514447167 > ./result_8chains/node52_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_4_1 -p 545 -st topic52_4_0 -pt topic52_4_1 -u 0.038391960361916444 > ./result_8chains/node52_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_5_1 -p 732 -st topic52_5_0 -pt topic52_5_1 -u 0.007174205461758648 > ./result_8chains/node52_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_6_1 -p 751 -st topic52_6_0 -pt topic52_6_1 -u 0.0017696641346059555 > ./result_8chains/node52_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_7_1 -p 892 -st topic52_7_0 -pt topic52_7_1 -u 0.0065611715781208856 > ./result_8chains/node52_7_1.txt &
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
    "./result_8chains/node52_0_1.txt 90"
    "./result_8chains/node52_1_1.txt 89"
    "./result_8chains/node52_2_1.txt 88"
    "./result_8chains/node52_3_1.txt 87"
    "./result_8chains/node52_4_1.txt 86"
    "./result_8chains/node52_5_1.txt 85"
    "./result_8chains/node52_6_1.txt 84"
    "./result_8chains/node52_7_1.txt 83"
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
