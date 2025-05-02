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
ros2 run evaluation_3_randomdag uunifast_node -n node86_0_1 -p 92 -st topic86_0_0 -pt topic86_0_1 -u 0.011729169284470486 > ./result_8chains/node86_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_1_1 -p 239 -st topic86_1_0 -pt topic86_1_1 -u 0.0018546845713580673 > ./result_8chains/node86_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_2_1 -p 310 -st topic86_2_0 -pt topic86_2_1 -u 0.007823165663121245 > ./result_8chains/node86_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_3_1 -p 480 -st topic86_3_0 -pt topic86_3_1 -u 0.03421845859892175 > ./result_8chains/node86_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_4_1 -p 538 -st topic86_4_0 -pt topic86_4_1 -u 0.01868737521926578 > ./result_8chains/node86_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_5_1 -p 789 -st topic86_5_0 -pt topic86_5_1 -u 0.05428358119357338 > ./result_8chains/node86_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_6_1 -p 940 -st topic86_6_0 -pt topic86_6_1 -u 0.05198471117456663 > ./result_8chains/node86_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_7_1 -p 961 -st topic86_7_0 -pt topic86_7_1 -u 0.0015436166790345866 > ./result_8chains/node86_7_1.txt &
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
    "./result_8chains/node86_0_1.txt 90"
    "./result_8chains/node86_1_1.txt 89"
    "./result_8chains/node86_2_1.txt 88"
    "./result_8chains/node86_3_1.txt 87"
    "./result_8chains/node86_4_1.txt 86"
    "./result_8chains/node86_5_1.txt 85"
    "./result_8chains/node86_6_1.txt 84"
    "./result_8chains/node86_7_1.txt 83"
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
