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
ros2 run evaluation_3_randomdag uunifast_node -n node321_0_1 -p 500 -st topic321_0_0 -pt topic321_0_1 -u 0.0017414267317031884 > ./result_8chains/node321_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_1_1 -p 617 -st topic321_1_0 -pt topic321_1_1 -u 0.006820922587116807 > ./result_8chains/node321_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_2_1 -p 704 -st topic321_2_0 -pt topic321_2_1 -u 0.05927738156078621 > ./result_8chains/node321_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_3_1 -p 722 -st topic321_3_0 -pt topic321_3_1 -u 0.07341257939922499 > ./result_8chains/node321_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_4_1 -p 782 -st topic321_4_0 -pt topic321_4_1 -u 0.049224652587470885 > ./result_8chains/node321_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_5_1 -p 895 -st topic321_5_0 -pt topic321_5_1 -u 0.005477815738555436 > ./result_8chains/node321_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_6_1 -p 987 -st topic321_6_0 -pt topic321_6_1 -u 0.02006211572678901 > ./result_8chains/node321_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_7_1 -p 992 -st topic321_7_0 -pt topic321_7_1 -u 0.01389832054127449 > ./result_8chains/node321_7_1.txt &
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
    "./result_8chains/node321_0_1.txt 90"
    "./result_8chains/node321_1_1.txt 89"
    "./result_8chains/node321_2_1.txt 88"
    "./result_8chains/node321_3_1.txt 87"
    "./result_8chains/node321_4_1.txt 86"
    "./result_8chains/node321_5_1.txt 85"
    "./result_8chains/node321_6_1.txt 84"
    "./result_8chains/node321_7_1.txt 83"
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
