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
ros2 run evaluation_3_randomdag uunifast_node -n node345_0_1 -p 184 -st topic345_0_0 -pt topic345_0_1 -u 0.027702800170450237 > ./result_8chains/node345_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_1_1 -p 191 -st topic345_1_0 -pt topic345_1_1 -u 0.018249370324873504 > ./result_8chains/node345_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_2_1 -p 644 -st topic345_2_0 -pt topic345_2_1 -u 0.021109238714839718 > ./result_8chains/node345_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_3_1 -p 715 -st topic345_3_0 -pt topic345_3_1 -u 0.057367319461584104 > ./result_8chains/node345_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_4_1 -p 785 -st topic345_4_0 -pt topic345_4_1 -u 0.02046237523469424 > ./result_8chains/node345_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_5_1 -p 829 -st topic345_5_0 -pt topic345_5_1 -u 0.007768646836766729 > ./result_8chains/node345_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_6_1 -p 855 -st topic345_6_0 -pt topic345_6_1 -u 0.030992556536996813 > ./result_8chains/node345_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_7_1 -p 936 -st topic345_7_0 -pt topic345_7_1 -u 0.0003122293454124055 > ./result_8chains/node345_7_1.txt &
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
    "./result_8chains/node345_0_1.txt 90"
    "./result_8chains/node345_1_1.txt 89"
    "./result_8chains/node345_2_1.txt 88"
    "./result_8chains/node345_3_1.txt 87"
    "./result_8chains/node345_4_1.txt 86"
    "./result_8chains/node345_5_1.txt 85"
    "./result_8chains/node345_6_1.txt 84"
    "./result_8chains/node345_7_1.txt 83"
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
