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
ros2 run evaluation_3_randomdag uunifast_node -n node69_0_1 -p 76 -st topic69_0_0 -pt topic69_0_1 -u 0.06219140933211598 > ./result_8chains/node69_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_1_1 -p 120 -st topic69_1_0 -pt topic69_1_1 -u 0.03238807586534492 > ./result_8chains/node69_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_2_1 -p 303 -st topic69_2_0 -pt topic69_2_1 -u 0.0005764354297813079 > ./result_8chains/node69_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_3_1 -p 384 -st topic69_3_0 -pt topic69_3_1 -u 0.03208590025120031 > ./result_8chains/node69_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_4_1 -p 519 -st topic69_4_0 -pt topic69_4_1 -u 0.010175637574951407 > ./result_8chains/node69_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_5_1 -p 895 -st topic69_5_0 -pt topic69_5_1 -u 0.06375414062124789 > ./result_8chains/node69_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_6_1 -p 932 -st topic69_6_0 -pt topic69_6_1 -u 0.008003428011223432 > ./result_8chains/node69_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_7_1 -p 983 -st topic69_7_0 -pt topic69_7_1 -u 0.006744726745407116 > ./result_8chains/node69_7_1.txt &
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
    "./result_8chains/node69_0_1.txt 90"
    "./result_8chains/node69_1_1.txt 89"
    "./result_8chains/node69_2_1.txt 88"
    "./result_8chains/node69_3_1.txt 87"
    "./result_8chains/node69_4_1.txt 86"
    "./result_8chains/node69_5_1.txt 85"
    "./result_8chains/node69_6_1.txt 84"
    "./result_8chains/node69_7_1.txt 83"
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
