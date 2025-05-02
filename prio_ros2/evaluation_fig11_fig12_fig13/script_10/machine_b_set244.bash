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
ros2 run evaluation_3_randomdag uunifast_node -n node244_0_1 -p 22 -st topic244_0_0 -pt topic244_0_1 -u 0.013721857480407107 > ./result_10chains/node244_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_1_1 -p 59 -st topic244_1_0 -pt topic244_1_1 -u 0.0013755576311376694 > ./result_10chains/node244_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_2_1 -p 538 -st topic244_2_0 -pt topic244_2_1 -u 0.012633343458379853 > ./result_10chains/node244_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_3_1 -p 589 -st topic244_3_0 -pt topic244_3_1 -u 0.007586193368894822 > ./result_10chains/node244_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_4_1 -p 599 -st topic244_4_0 -pt topic244_4_1 -u 0.028028540942108326 > ./result_10chains/node244_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_5_1 -p 631 -st topic244_5_0 -pt topic244_5_1 -u 0.027557816719391892 > ./result_10chains/node244_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_6_1 -p 650 -st topic244_6_0 -pt topic244_6_1 -u 0.06272004722836255 > ./result_10chains/node244_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_7_1 -p 830 -st topic244_7_0 -pt topic244_7_1 -u 0.01532436578867849 > ./result_10chains/node244_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_8_1 -p 841 -st topic244_8_0 -pt topic244_8_1 -u 0.03819202622438779 > ./result_10chains/node244_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_9_1 -p 871 -st topic244_9_0 -pt topic244_9_1 -u 0.020317597177495844 > ./result_10chains/node244_9_1.txt &
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
    "./result_10chains/node244_0_1.txt 90"
    "./result_10chains/node244_1_1.txt 89"
    "./result_10chains/node244_2_1.txt 88"
    "./result_10chains/node244_3_1.txt 87"
    "./result_10chains/node244_4_1.txt 86"
    "./result_10chains/node244_5_1.txt 85"
    "./result_10chains/node244_6_1.txt 84"
    "./result_10chains/node244_7_1.txt 83"
    "./result_10chains/node244_8_1.txt 82"
    "./result_10chains/node244_9_1.txt 81"
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
