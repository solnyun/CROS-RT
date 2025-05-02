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
ros2 run evaluation_3_randomdag uunifast_node -n node356_0_1 -p 52 -st topic356_0_0 -pt topic356_0_1 -u 0.049049090789082594 > ./result_10chains/node356_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_1_1 -p 63 -st topic356_1_0 -pt topic356_1_1 -u 0.007637874813254508 > ./result_10chains/node356_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_2_1 -p 138 -st topic356_2_0 -pt topic356_2_1 -u 0.006550519772869412 > ./result_10chains/node356_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_3_1 -p 229 -st topic356_3_0 -pt topic356_3_1 -u 0.0014705211211704095 > ./result_10chains/node356_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_4_1 -p 325 -st topic356_4_0 -pt topic356_4_1 -u 0.03717064061362585 > ./result_10chains/node356_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_5_1 -p 573 -st topic356_5_0 -pt topic356_5_1 -u 0.014443417659216418 > ./result_10chains/node356_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_6_1 -p 636 -st topic356_6_0 -pt topic356_6_1 -u 0.012043232482138372 > ./result_10chains/node356_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_7_1 -p 677 -st topic356_7_0 -pt topic356_7_1 -u 0.007082425689760641 > ./result_10chains/node356_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_8_1 -p 727 -st topic356_8_0 -pt topic356_8_1 -u 0.008548045884050393 > ./result_10chains/node356_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_9_1 -p 782 -st topic356_9_0 -pt topic356_9_1 -u 0.004570533489935413 > ./result_10chains/node356_9_1.txt &
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
    "./result_10chains/node356_0_1.txt 90"
    "./result_10chains/node356_1_1.txt 89"
    "./result_10chains/node356_2_1.txt 88"
    "./result_10chains/node356_3_1.txt 87"
    "./result_10chains/node356_4_1.txt 86"
    "./result_10chains/node356_5_1.txt 85"
    "./result_10chains/node356_6_1.txt 84"
    "./result_10chains/node356_7_1.txt 83"
    "./result_10chains/node356_8_1.txt 82"
    "./result_10chains/node356_9_1.txt 81"
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
