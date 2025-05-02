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
ros2 run evaluation_3_randomdag uunifast_node -n node276_0_1 -p 83 -st topic276_0_0 -pt topic276_0_1 -u 0.02960904505727152 > ./result_8chains/node276_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_1_1 -p 174 -st topic276_1_0 -pt topic276_1_1 -u 0.0030803854232388517 > ./result_8chains/node276_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_2_1 -p 204 -st topic276_2_0 -pt topic276_2_1 -u 0.004884752101433076 > ./result_8chains/node276_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_3_1 -p 385 -st topic276_3_0 -pt topic276_3_1 -u 0.005206628134549807 > ./result_8chains/node276_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_4_1 -p 554 -st topic276_4_0 -pt topic276_4_1 -u 0.0016191333015992404 > ./result_8chains/node276_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_5_1 -p 741 -st topic276_5_0 -pt topic276_5_1 -u 0.010595724929332195 > ./result_8chains/node276_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_6_1 -p 781 -st topic276_6_0 -pt topic276_6_1 -u 0.007018857852533922 > ./result_8chains/node276_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_7_1 -p 921 -st topic276_7_0 -pt topic276_7_1 -u 0.0018906724300989455 > ./result_8chains/node276_7_1.txt &
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
    "./result_8chains/node276_0_1.txt 90"
    "./result_8chains/node276_1_1.txt 89"
    "./result_8chains/node276_2_1.txt 88"
    "./result_8chains/node276_3_1.txt 87"
    "./result_8chains/node276_4_1.txt 86"
    "./result_8chains/node276_5_1.txt 85"
    "./result_8chains/node276_6_1.txt 84"
    "./result_8chains/node276_7_1.txt 83"
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
