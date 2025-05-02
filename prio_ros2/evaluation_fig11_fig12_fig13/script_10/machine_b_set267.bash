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
ros2 run evaluation_3_randomdag uunifast_node -n node267_0_1 -p 331 -st topic267_0_0 -pt topic267_0_1 -u 0.01749949534504991 > ./result_10chains/node267_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_1_1 -p 383 -st topic267_1_0 -pt topic267_1_1 -u 0.006788421285630175 > ./result_10chains/node267_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_2_1 -p 525 -st topic267_2_0 -pt topic267_2_1 -u 0.037825143071748224 > ./result_10chains/node267_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_3_1 -p 534 -st topic267_3_0 -pt topic267_3_1 -u 0.025710438358705345 > ./result_10chains/node267_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_4_1 -p 535 -st topic267_4_0 -pt topic267_4_1 -u 0.010172772468494407 > ./result_10chains/node267_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_5_1 -p 580 -st topic267_5_0 -pt topic267_5_1 -u 0.07744563074557409 > ./result_10chains/node267_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_6_1 -p 591 -st topic267_6_0 -pt topic267_6_1 -u 0.008419447117784779 > ./result_10chains/node267_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_7_1 -p 823 -st topic267_7_0 -pt topic267_7_1 -u 0.0004437508033068027 > ./result_10chains/node267_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_8_1 -p 922 -st topic267_8_0 -pt topic267_8_1 -u 0.009433829582339452 > ./result_10chains/node267_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_9_1 -p 981 -st topic267_9_0 -pt topic267_9_1 -u 0.001058999752776263 > ./result_10chains/node267_9_1.txt &
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
    "./result_10chains/node267_0_1.txt 90"
    "./result_10chains/node267_1_1.txt 89"
    "./result_10chains/node267_2_1.txt 88"
    "./result_10chains/node267_3_1.txt 87"
    "./result_10chains/node267_4_1.txt 86"
    "./result_10chains/node267_5_1.txt 85"
    "./result_10chains/node267_6_1.txt 84"
    "./result_10chains/node267_7_1.txt 83"
    "./result_10chains/node267_8_1.txt 82"
    "./result_10chains/node267_9_1.txt 81"
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
