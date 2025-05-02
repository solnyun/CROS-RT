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
ros2 run evaluation_3_randomdag uunifast_node -n node425_0_1 -p 129 -st topic425_0_0 -pt topic425_0_1 -u 0.06217767290713133 > ./result_8chains/node425_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_1_1 -p 255 -st topic425_1_0 -pt topic425_1_1 -u 0.021217396654409137 > ./result_8chains/node425_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_2_1 -p 383 -st topic425_2_0 -pt topic425_2_1 -u 0.040923417896111425 > ./result_8chains/node425_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_3_1 -p 580 -st topic425_3_0 -pt topic425_3_1 -u 0.006737656312158807 > ./result_8chains/node425_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_4_1 -p 587 -st topic425_4_0 -pt topic425_4_1 -u 0.02084525342837204 > ./result_8chains/node425_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_5_1 -p 739 -st topic425_5_0 -pt topic425_5_1 -u 0.004922442237314306 > ./result_8chains/node425_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_6_1 -p 964 -st topic425_6_0 -pt topic425_6_1 -u 0.008858510629592933 > ./result_8chains/node425_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node425_7_1 -p 986 -st topic425_7_0 -pt topic425_7_1 -u 0.005938781697713481 > ./result_8chains/node425_7_1.txt &
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
    "./result_8chains/node425_0_1.txt 90"
    "./result_8chains/node425_1_1.txt 89"
    "./result_8chains/node425_2_1.txt 88"
    "./result_8chains/node425_3_1.txt 87"
    "./result_8chains/node425_4_1.txt 86"
    "./result_8chains/node425_5_1.txt 85"
    "./result_8chains/node425_6_1.txt 84"
    "./result_8chains/node425_7_1.txt 83"
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
