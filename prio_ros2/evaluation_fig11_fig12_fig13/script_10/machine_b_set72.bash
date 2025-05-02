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
ros2 run evaluation_3_randomdag uunifast_node -n node72_0_1 -p 17 -st topic72_0_0 -pt topic72_0_1 -u 0.002042159371575758 > ./result_10chains/node72_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_1_1 -p 150 -st topic72_1_0 -pt topic72_1_1 -u 0.004308586737585773 > ./result_10chains/node72_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_2_1 -p 294 -st topic72_2_0 -pt topic72_2_1 -u 0.03522077056536127 > ./result_10chains/node72_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_3_1 -p 333 -st topic72_3_0 -pt topic72_3_1 -u 0.01163425063116752 > ./result_10chains/node72_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_4_1 -p 383 -st topic72_4_0 -pt topic72_4_1 -u 0.00855597801653224 > ./result_10chains/node72_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_5_1 -p 499 -st topic72_5_0 -pt topic72_5_1 -u 0.009457768975218744 > ./result_10chains/node72_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_6_1 -p 526 -st topic72_6_0 -pt topic72_6_1 -u 0.021485835618140187 > ./result_10chains/node72_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_7_1 -p 669 -st topic72_7_0 -pt topic72_7_1 -u 0.003139877749411407 > ./result_10chains/node72_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_8_1 -p 845 -st topic72_8_0 -pt topic72_8_1 -u 0.019255425902426473 > ./result_10chains/node72_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_9_1 -p 911 -st topic72_9_0 -pt topic72_9_1 -u 0.01363433706039768 > ./result_10chains/node72_9_1.txt &
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
    "./result_10chains/node72_0_1.txt 90"
    "./result_10chains/node72_1_1.txt 89"
    "./result_10chains/node72_2_1.txt 88"
    "./result_10chains/node72_3_1.txt 87"
    "./result_10chains/node72_4_1.txt 86"
    "./result_10chains/node72_5_1.txt 85"
    "./result_10chains/node72_6_1.txt 84"
    "./result_10chains/node72_7_1.txt 83"
    "./result_10chains/node72_8_1.txt 82"
    "./result_10chains/node72_9_1.txt 81"
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
