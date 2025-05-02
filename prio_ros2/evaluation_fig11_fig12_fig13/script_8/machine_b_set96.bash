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
ros2 run evaluation_3_randomdag uunifast_node -n node96_0_1 -p 241 -st topic96_0_0 -pt topic96_0_1 -u 0.00879017366229512 > ./result_8chains/node96_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_1_1 -p 361 -st topic96_1_0 -pt topic96_1_1 -u 0.005035836717184328 > ./result_8chains/node96_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_2_1 -p 463 -st topic96_2_0 -pt topic96_2_1 -u 0.031457106898589327 > ./result_8chains/node96_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_3_1 -p 491 -st topic96_3_0 -pt topic96_3_1 -u 0.011319993815115004 > ./result_8chains/node96_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_4_1 -p 632 -st topic96_4_0 -pt topic96_4_1 -u 0.008405277319785187 > ./result_8chains/node96_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_5_1 -p 830 -st topic96_5_0 -pt topic96_5_1 -u 0.007397542691716358 > ./result_8chains/node96_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_6_1 -p 955 -st topic96_6_0 -pt topic96_6_1 -u 0.006347424456650513 > ./result_8chains/node96_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_7_1 -p 983 -st topic96_7_0 -pt topic96_7_1 -u 0.04622636450199699 > ./result_8chains/node96_7_1.txt &
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
    "./result_8chains/node96_0_1.txt 90"
    "./result_8chains/node96_1_1.txt 89"
    "./result_8chains/node96_2_1.txt 88"
    "./result_8chains/node96_3_1.txt 87"
    "./result_8chains/node96_4_1.txt 86"
    "./result_8chains/node96_5_1.txt 85"
    "./result_8chains/node96_6_1.txt 84"
    "./result_8chains/node96_7_1.txt 83"
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
