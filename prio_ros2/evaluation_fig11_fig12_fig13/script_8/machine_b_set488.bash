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
ros2 run evaluation_3_randomdag uunifast_node -n node488_0_1 -p 363 -st topic488_0_0 -pt topic488_0_1 -u 0.026455115660011352 > ./result_8chains/node488_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_1_1 -p 480 -st topic488_1_0 -pt topic488_1_1 -u 0.024596193802928268 > ./result_8chains/node488_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_2_1 -p 552 -st topic488_2_0 -pt topic488_2_1 -u 0.0007680875892028816 > ./result_8chains/node488_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_3_1 -p 554 -st topic488_3_0 -pt topic488_3_1 -u 0.0797404149539992 > ./result_8chains/node488_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_4_1 -p 798 -st topic488_4_0 -pt topic488_4_1 -u 0.009576357994579537 > ./result_8chains/node488_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_5_1 -p 857 -st topic488_5_0 -pt topic488_5_1 -u 0.0018120241175076657 > ./result_8chains/node488_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_6_1 -p 919 -st topic488_6_0 -pt topic488_6_1 -u 0.03755910952393254 > ./result_8chains/node488_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_7_1 -p 946 -st topic488_7_0 -pt topic488_7_1 -u 0.007923101905787303 > ./result_8chains/node488_7_1.txt &
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
    "./result_8chains/node488_0_1.txt 90"
    "./result_8chains/node488_1_1.txt 89"
    "./result_8chains/node488_2_1.txt 88"
    "./result_8chains/node488_3_1.txt 87"
    "./result_8chains/node488_4_1.txt 86"
    "./result_8chains/node488_5_1.txt 85"
    "./result_8chains/node488_6_1.txt 84"
    "./result_8chains/node488_7_1.txt 83"
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
