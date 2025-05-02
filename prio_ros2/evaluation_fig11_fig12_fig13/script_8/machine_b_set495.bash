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
ros2 run evaluation_3_randomdag uunifast_node -n node495_0_1 -p 262 -st topic495_0_0 -pt topic495_0_1 -u 0.010622397092555746 > ./result_8chains/node495_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_1_1 -p 447 -st topic495_1_0 -pt topic495_1_1 -u 0.03172826914045357 > ./result_8chains/node495_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_2_1 -p 492 -st topic495_2_0 -pt topic495_2_1 -u 0.009693462402827202 > ./result_8chains/node495_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_3_1 -p 539 -st topic495_3_0 -pt topic495_3_1 -u 0.001617071411516513 > ./result_8chains/node495_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_4_1 -p 592 -st topic495_4_0 -pt topic495_4_1 -u 0.04074088791847466 > ./result_8chains/node495_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_5_1 -p 727 -st topic495_5_0 -pt topic495_5_1 -u 0.007883526405032412 > ./result_8chains/node495_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_6_1 -p 779 -st topic495_6_0 -pt topic495_6_1 -u 0.003117697058596547 > ./result_8chains/node495_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node495_7_1 -p 791 -st topic495_7_0 -pt topic495_7_1 -u 0.013377818961172547 > ./result_8chains/node495_7_1.txt &
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
    "./result_8chains/node495_0_1.txt 90"
    "./result_8chains/node495_1_1.txt 89"
    "./result_8chains/node495_2_1.txt 88"
    "./result_8chains/node495_3_1.txt 87"
    "./result_8chains/node495_4_1.txt 86"
    "./result_8chains/node495_5_1.txt 85"
    "./result_8chains/node495_6_1.txt 84"
    "./result_8chains/node495_7_1.txt 83"
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
