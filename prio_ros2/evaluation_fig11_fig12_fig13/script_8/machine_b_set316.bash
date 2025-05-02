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
ros2 run evaluation_3_randomdag uunifast_node -n node316_0_1 -p 45 -st topic316_0_0 -pt topic316_0_1 -u 0.025129434015943752 > ./result_8chains/node316_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_1_1 -p 80 -st topic316_1_0 -pt topic316_1_1 -u 0.06270790819687627 > ./result_8chains/node316_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_2_1 -p 360 -st topic316_2_0 -pt topic316_2_1 -u 0.014303064572367186 > ./result_8chains/node316_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_3_1 -p 494 -st topic316_3_0 -pt topic316_3_1 -u 0.0036752223537573347 > ./result_8chains/node316_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_4_1 -p 498 -st topic316_4_0 -pt topic316_4_1 -u 0.031358265311961925 > ./result_8chains/node316_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_5_1 -p 810 -st topic316_5_0 -pt topic316_5_1 -u 0.011857984496763938 > ./result_8chains/node316_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_6_1 -p 831 -st topic316_6_0 -pt topic316_6_1 -u 0.005622762654066513 > ./result_8chains/node316_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_7_1 -p 836 -st topic316_7_0 -pt topic316_7_1 -u 0.004065222643043587 > ./result_8chains/node316_7_1.txt &
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
    "./result_8chains/node316_0_1.txt 90"
    "./result_8chains/node316_1_1.txt 89"
    "./result_8chains/node316_2_1.txt 88"
    "./result_8chains/node316_3_1.txt 87"
    "./result_8chains/node316_4_1.txt 86"
    "./result_8chains/node316_5_1.txt 85"
    "./result_8chains/node316_6_1.txt 84"
    "./result_8chains/node316_7_1.txt 83"
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
