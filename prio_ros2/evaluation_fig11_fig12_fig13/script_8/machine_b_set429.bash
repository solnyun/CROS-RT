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
ros2 run evaluation_3_randomdag uunifast_node -n node429_0_1 -p 188 -st topic429_0_0 -pt topic429_0_1 -u 0.011552435018701401 > ./result_8chains/node429_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_1_1 -p 372 -st topic429_1_0 -pt topic429_1_1 -u 0.04171302402007099 > ./result_8chains/node429_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_2_1 -p 620 -st topic429_2_0 -pt topic429_2_1 -u 0.011588828079995284 > ./result_8chains/node429_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_3_1 -p 803 -st topic429_3_0 -pt topic429_3_1 -u 0.007952774646804633 > ./result_8chains/node429_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_4_1 -p 853 -st topic429_4_0 -pt topic429_4_1 -u 0.006661274654779337 > ./result_8chains/node429_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_5_1 -p 888 -st topic429_5_0 -pt topic429_5_1 -u 0.0169588998455861 > ./result_8chains/node429_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_6_1 -p 897 -st topic429_6_0 -pt topic429_6_1 -u 0.0006246665793711165 > ./result_8chains/node429_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node429_7_1 -p 985 -st topic429_7_0 -pt topic429_7_1 -u 1.6664678146531553e-05 > ./result_8chains/node429_7_1.txt &
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
    "./result_8chains/node429_0_1.txt 90"
    "./result_8chains/node429_1_1.txt 89"
    "./result_8chains/node429_2_1.txt 88"
    "./result_8chains/node429_3_1.txt 87"
    "./result_8chains/node429_4_1.txt 86"
    "./result_8chains/node429_5_1.txt 85"
    "./result_8chains/node429_6_1.txt 84"
    "./result_8chains/node429_7_1.txt 83"
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
