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
ros2 run evaluation_3_randomdag uunifast_node -n node45_0_1 -p 39 -st topic45_0_0 -pt topic45_0_1 -u 0.013346098225156422 > ./result_8chains/node45_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_1_1 -p 89 -st topic45_1_0 -pt topic45_1_1 -u 0.1007830652283801 > ./result_8chains/node45_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_2_1 -p 152 -st topic45_2_0 -pt topic45_2_1 -u 0.0014256765840665042 > ./result_8chains/node45_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_3_1 -p 239 -st topic45_3_0 -pt topic45_3_1 -u 0.013409787939746398 > ./result_8chains/node45_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_4_1 -p 667 -st topic45_4_0 -pt topic45_4_1 -u 0.03252883033764381 > ./result_8chains/node45_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_5_1 -p 700 -st topic45_5_0 -pt topic45_5_1 -u 0.004057893653473116 > ./result_8chains/node45_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_6_1 -p 844 -st topic45_6_0 -pt topic45_6_1 -u 0.007236703764125524 > ./result_8chains/node45_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_7_1 -p 846 -st topic45_7_0 -pt topic45_7_1 -u 0.006913992077900332 > ./result_8chains/node45_7_1.txt &
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
    "./result_8chains/node45_0_1.txt 90"
    "./result_8chains/node45_1_1.txt 89"
    "./result_8chains/node45_2_1.txt 88"
    "./result_8chains/node45_3_1.txt 87"
    "./result_8chains/node45_4_1.txt 86"
    "./result_8chains/node45_5_1.txt 85"
    "./result_8chains/node45_6_1.txt 84"
    "./result_8chains/node45_7_1.txt 83"
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
