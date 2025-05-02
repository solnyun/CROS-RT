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
ros2 run evaluation_3_randomdag uunifast_node -n node75_0_1 -p 10 -st topic75_0_0 -pt topic75_0_1 -u 0.01705066984374254 > ./result_10chains/node75_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_1_1 -p 22 -st topic75_1_0 -pt topic75_1_1 -u 0.0403280207681852 > ./result_10chains/node75_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_2_1 -p 44 -st topic75_2_0 -pt topic75_2_1 -u 0.010122765055899374 > ./result_10chains/node75_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_3_1 -p 73 -st topic75_3_0 -pt topic75_3_1 -u 0.0279608320173515 > ./result_10chains/node75_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_4_1 -p 345 -st topic75_4_0 -pt topic75_4_1 -u 0.0006385558301699179 > ./result_10chains/node75_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_5_1 -p 608 -st topic75_5_0 -pt topic75_5_1 -u 0.007421639023808768 > ./result_10chains/node75_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_6_1 -p 761 -st topic75_6_0 -pt topic75_6_1 -u 0.005729890145731137 > ./result_10chains/node75_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_7_1 -p 860 -st topic75_7_0 -pt topic75_7_1 -u 0.00493185072944094 > ./result_10chains/node75_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_8_1 -p 899 -st topic75_8_0 -pt topic75_8_1 -u 0.03734978986644407 > ./result_10chains/node75_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node75_9_1 -p 991 -st topic75_9_0 -pt topic75_9_1 -u 0.02053059382592586 > ./result_10chains/node75_9_1.txt &
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
    "./result_10chains/node75_0_1.txt 90"
    "./result_10chains/node75_1_1.txt 89"
    "./result_10chains/node75_2_1.txt 88"
    "./result_10chains/node75_3_1.txt 87"
    "./result_10chains/node75_4_1.txt 86"
    "./result_10chains/node75_5_1.txt 85"
    "./result_10chains/node75_6_1.txt 84"
    "./result_10chains/node75_7_1.txt 83"
    "./result_10chains/node75_8_1.txt 82"
    "./result_10chains/node75_9_1.txt 81"
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
