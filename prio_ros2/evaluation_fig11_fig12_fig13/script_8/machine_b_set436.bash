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
ros2 run evaluation_3_randomdag uunifast_node -n node436_0_1 -p 62 -st topic436_0_0 -pt topic436_0_1 -u 0.020075917460438852 > ./result_8chains/node436_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_1_1 -p 173 -st topic436_1_0 -pt topic436_1_1 -u 0.021634893069541528 > ./result_8chains/node436_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_2_1 -p 238 -st topic436_2_0 -pt topic436_2_1 -u 0.08015096258469279 > ./result_8chains/node436_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_3_1 -p 488 -st topic436_3_0 -pt topic436_3_1 -u 0.007556668787883053 > ./result_8chains/node436_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_4_1 -p 562 -st topic436_4_0 -pt topic436_4_1 -u 0.03308451676942817 > ./result_8chains/node436_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_5_1 -p 874 -st topic436_5_0 -pt topic436_5_1 -u 0.003594291089687965 > ./result_8chains/node436_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_6_1 -p 931 -st topic436_6_0 -pt topic436_6_1 -u 0.010158309237397939 > ./result_8chains/node436_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node436_7_1 -p 972 -st topic436_7_0 -pt topic436_7_1 -u 0.01735871961649789 > ./result_8chains/node436_7_1.txt &
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
    "./result_8chains/node436_0_1.txt 90"
    "./result_8chains/node436_1_1.txt 89"
    "./result_8chains/node436_2_1.txt 88"
    "./result_8chains/node436_3_1.txt 87"
    "./result_8chains/node436_4_1.txt 86"
    "./result_8chains/node436_5_1.txt 85"
    "./result_8chains/node436_6_1.txt 84"
    "./result_8chains/node436_7_1.txt 83"
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
