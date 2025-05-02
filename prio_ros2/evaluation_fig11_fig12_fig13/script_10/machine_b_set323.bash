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
ros2 run evaluation_3_randomdag uunifast_node -n node323_0_1 -p 152 -st topic323_0_0 -pt topic323_0_1 -u 0.00625307868037922 > ./result_10chains/node323_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_1_1 -p 177 -st topic323_1_0 -pt topic323_1_1 -u 0.01639938870269475 > ./result_10chains/node323_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_2_1 -p 199 -st topic323_2_0 -pt topic323_2_1 -u 0.0012142727410967558 > ./result_10chains/node323_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_3_1 -p 278 -st topic323_3_0 -pt topic323_3_1 -u 0.026814152141286296 > ./result_10chains/node323_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_4_1 -p 356 -st topic323_4_0 -pt topic323_4_1 -u 0.00809265537651932 > ./result_10chains/node323_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_5_1 -p 498 -st topic323_5_0 -pt topic323_5_1 -u 0.010390858217422583 > ./result_10chains/node323_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_6_1 -p 504 -st topic323_6_0 -pt topic323_6_1 -u 0.004588013027659654 > ./result_10chains/node323_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_7_1 -p 599 -st topic323_7_0 -pt topic323_7_1 -u 0.012682465651259633 > ./result_10chains/node323_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_8_1 -p 773 -st topic323_8_0 -pt topic323_8_1 -u 0.0005265979484189928 > ./result_10chains/node323_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node323_9_1 -p 877 -st topic323_9_0 -pt topic323_9_1 -u 0.002021956572285835 > ./result_10chains/node323_9_1.txt &
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
    "./result_10chains/node323_0_1.txt 90"
    "./result_10chains/node323_1_1.txt 89"
    "./result_10chains/node323_2_1.txt 88"
    "./result_10chains/node323_3_1.txt 87"
    "./result_10chains/node323_4_1.txt 86"
    "./result_10chains/node323_5_1.txt 85"
    "./result_10chains/node323_6_1.txt 84"
    "./result_10chains/node323_7_1.txt 83"
    "./result_10chains/node323_8_1.txt 82"
    "./result_10chains/node323_9_1.txt 81"
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
