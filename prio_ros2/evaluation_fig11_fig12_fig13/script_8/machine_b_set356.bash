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
ros2 run evaluation_3_randomdag uunifast_node -n node356_0_1 -p 201 -st topic356_0_0 -pt topic356_0_1 -u 0.007753026585791911 > ./result_8chains/node356_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_1_1 -p 467 -st topic356_1_0 -pt topic356_1_1 -u 0.022824391057674753 > ./result_8chains/node356_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_2_1 -p 485 -st topic356_2_0 -pt topic356_2_1 -u 0.04395238909565374 > ./result_8chains/node356_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_3_1 -p 615 -st topic356_3_0 -pt topic356_3_1 -u 0.024956678445716224 > ./result_8chains/node356_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_4_1 -p 703 -st topic356_4_0 -pt topic356_4_1 -u 0.0006219796208168926 > ./result_8chains/node356_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_5_1 -p 721 -st topic356_5_0 -pt topic356_5_1 -u 0.020899878528844937 > ./result_8chains/node356_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_6_1 -p 766 -st topic356_6_0 -pt topic356_6_1 -u 0.009462630290169693 > ./result_8chains/node356_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_7_1 -p 837 -st topic356_7_0 -pt topic356_7_1 -u 0.004868004330788801 > ./result_8chains/node356_7_1.txt &
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
    "./result_8chains/node356_0_1.txt 90"
    "./result_8chains/node356_1_1.txt 89"
    "./result_8chains/node356_2_1.txt 88"
    "./result_8chains/node356_3_1.txt 87"
    "./result_8chains/node356_4_1.txt 86"
    "./result_8chains/node356_5_1.txt 85"
    "./result_8chains/node356_6_1.txt 84"
    "./result_8chains/node356_7_1.txt 83"
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
