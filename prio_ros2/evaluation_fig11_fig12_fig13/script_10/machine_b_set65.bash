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
ros2 run evaluation_3_randomdag uunifast_node -n node65_0_1 -p 323 -st topic65_0_0 -pt topic65_0_1 -u 0.05082147605304865 > ./result_10chains/node65_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_1_1 -p 357 -st topic65_1_0 -pt topic65_1_1 -u 0.006202582693749625 > ./result_10chains/node65_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_2_1 -p 520 -st topic65_2_0 -pt topic65_2_1 -u 0.010255061210820426 > ./result_10chains/node65_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_3_1 -p 636 -st topic65_3_0 -pt topic65_3_1 -u 0.006835454155999954 > ./result_10chains/node65_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_4_1 -p 664 -st topic65_4_0 -pt topic65_4_1 -u 0.012040043286763114 > ./result_10chains/node65_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_5_1 -p 670 -st topic65_5_0 -pt topic65_5_1 -u 0.005065091631316354 > ./result_10chains/node65_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_6_1 -p 682 -st topic65_6_0 -pt topic65_6_1 -u 0.01712611764708158 > ./result_10chains/node65_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_7_1 -p 701 -st topic65_7_0 -pt topic65_7_1 -u 0.0019766154489983534 > ./result_10chains/node65_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_8_1 -p 814 -st topic65_8_0 -pt topic65_8_1 -u 0.04879726609500226 > ./result_10chains/node65_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node65_9_1 -p 922 -st topic65_9_0 -pt topic65_9_1 -u 0.0007349362408656177 > ./result_10chains/node65_9_1.txt &
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
    "./result_10chains/node65_0_1.txt 90"
    "./result_10chains/node65_1_1.txt 89"
    "./result_10chains/node65_2_1.txt 88"
    "./result_10chains/node65_3_1.txt 87"
    "./result_10chains/node65_4_1.txt 86"
    "./result_10chains/node65_5_1.txt 85"
    "./result_10chains/node65_6_1.txt 84"
    "./result_10chains/node65_7_1.txt 83"
    "./result_10chains/node65_8_1.txt 82"
    "./result_10chains/node65_9_1.txt 81"
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
