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
ros2 run evaluation_3_randomdag uunifast_node -n node248_0_1 -p 331 -st topic248_0_0 -pt topic248_0_1 -u 0.00791115582694002 > ./result_8chains/node248_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_1_1 -p 525 -st topic248_1_0 -pt topic248_1_1 -u 0.009136653435075137 > ./result_8chains/node248_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_2_1 -p 579 -st topic248_2_0 -pt topic248_2_1 -u 0.018665592693729693 > ./result_8chains/node248_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_3_1 -p 628 -st topic248_3_0 -pt topic248_3_1 -u 0.004096790383992355 > ./result_8chains/node248_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_4_1 -p 906 -st topic248_4_0 -pt topic248_4_1 -u 0.01714080484628039 > ./result_8chains/node248_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_5_1 -p 938 -st topic248_5_0 -pt topic248_5_1 -u 0.07770157336023051 > ./result_8chains/node248_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_6_1 -p 953 -st topic248_6_0 -pt topic248_6_1 -u 0.008271223086894208 > ./result_8chains/node248_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_7_1 -p 961 -st topic248_7_0 -pt topic248_7_1 -u 0.013134881097150386 > ./result_8chains/node248_7_1.txt &
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
    "./result_8chains/node248_0_1.txt 90"
    "./result_8chains/node248_1_1.txt 89"
    "./result_8chains/node248_2_1.txt 88"
    "./result_8chains/node248_3_1.txt 87"
    "./result_8chains/node248_4_1.txt 86"
    "./result_8chains/node248_5_1.txt 85"
    "./result_8chains/node248_6_1.txt 84"
    "./result_8chains/node248_7_1.txt 83"
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
