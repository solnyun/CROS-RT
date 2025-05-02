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
ros2 run evaluation_3_randomdag uunifast_node -n node251_0_1 -p 191 -st topic251_0_0 -pt topic251_0_1 -u 0.009260583442626424 > ./result_10chains/node251_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_1_1 -p 243 -st topic251_1_0 -pt topic251_1_1 -u 0.00322829286620796 > ./result_10chains/node251_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_2_1 -p 296 -st topic251_2_0 -pt topic251_2_1 -u 0.004537227011204903 > ./result_10chains/node251_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_3_1 -p 372 -st topic251_3_0 -pt topic251_3_1 -u 0.06868174320115378 > ./result_10chains/node251_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_4_1 -p 475 -st topic251_4_0 -pt topic251_4_1 -u 0.0034980763306134977 > ./result_10chains/node251_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_5_1 -p 678 -st topic251_5_0 -pt topic251_5_1 -u 0.01877369211731378 > ./result_10chains/node251_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_6_1 -p 941 -st topic251_6_0 -pt topic251_6_1 -u 0.0459860621881481 > ./result_10chains/node251_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_7_1 -p 948 -st topic251_7_0 -pt topic251_7_1 -u 0.010296075470058869 > ./result_10chains/node251_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_8_1 -p 950 -st topic251_8_0 -pt topic251_8_1 -u 0.003411815994225284 > ./result_10chains/node251_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_9_1 -p 953 -st topic251_9_0 -pt topic251_9_1 -u 0.011213642169332766 > ./result_10chains/node251_9_1.txt &
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
    "./result_10chains/node251_0_1.txt 90"
    "./result_10chains/node251_1_1.txt 89"
    "./result_10chains/node251_2_1.txt 88"
    "./result_10chains/node251_3_1.txt 87"
    "./result_10chains/node251_4_1.txt 86"
    "./result_10chains/node251_5_1.txt 85"
    "./result_10chains/node251_6_1.txt 84"
    "./result_10chains/node251_7_1.txt 83"
    "./result_10chains/node251_8_1.txt 82"
    "./result_10chains/node251_9_1.txt 81"
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
