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
ros2 run evaluation_3_randomdag uunifast_node -n node289_0_1 -p 164 -st topic289_0_0 -pt topic289_0_1 -u 0.04375427487513267 > ./result_8chains/node289_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_1_1 -p 266 -st topic289_1_0 -pt topic289_1_1 -u 0.0036322827054589557 > ./result_8chains/node289_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_2_1 -p 376 -st topic289_2_0 -pt topic289_2_1 -u 0.000670182703382316 > ./result_8chains/node289_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_3_1 -p 512 -st topic289_3_0 -pt topic289_3_1 -u 0.010630618815055837 > ./result_8chains/node289_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_4_1 -p 659 -st topic289_4_0 -pt topic289_4_1 -u 0.032887770987058945 > ./result_8chains/node289_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_5_1 -p 805 -st topic289_5_0 -pt topic289_5_1 -u 0.001201923845459113 > ./result_8chains/node289_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_6_1 -p 919 -st topic289_6_0 -pt topic289_6_1 -u 0.03333347564637952 > ./result_8chains/node289_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node289_7_1 -p 927 -st topic289_7_0 -pt topic289_7_1 -u 0.005867194415107477 > ./result_8chains/node289_7_1.txt &
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
    "./result_8chains/node289_0_1.txt 90"
    "./result_8chains/node289_1_1.txt 89"
    "./result_8chains/node289_2_1.txt 88"
    "./result_8chains/node289_3_1.txt 87"
    "./result_8chains/node289_4_1.txt 86"
    "./result_8chains/node289_5_1.txt 85"
    "./result_8chains/node289_6_1.txt 84"
    "./result_8chains/node289_7_1.txt 83"
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
