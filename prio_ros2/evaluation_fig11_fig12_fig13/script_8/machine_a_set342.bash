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
ros2 run evaluation_3_randomdag uunifast_node -n node342_0_2 -p 28 -st topic342_0_1 -pt None -u 0.018333159833312684 > ./result_8chains/node342_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_1_2 -p 79 -st topic342_1_1 -pt None -u 0.022415467891432617 > ./result_8chains/node342_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_2_2 -p 167 -st topic342_2_1 -pt None -u 0.02398072176907312 > ./result_8chains/node342_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_3_2 -p 218 -st topic342_3_1 -pt None -u 0.004188110354291175 > ./result_8chains/node342_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_4_2 -p 615 -st topic342_4_1 -pt None -u 0.005090226035080886 > ./result_8chains/node342_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_5_2 -p 637 -st topic342_5_1 -pt None -u 0.02092351311031579 > ./result_8chains/node342_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_6_2 -p 660 -st topic342_6_1 -pt None -u 0.013710411081987506 > ./result_8chains/node342_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_7_2 -p 954 -st topic342_7_1 -pt None -u 0.002041404195733252 > ./result_8chains/node342_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_0_0 -p 28 -st none -pt topic342_0_0 -u 0.004177713838581676 > ./result_8chains/node342_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_1_0 -p 79 -st none -pt topic342_1_0 -u 0.04984452409744178 > ./result_8chains/node342_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_2_0 -p 167 -st none -pt topic342_2_0 -u 0.007380305658156838 > ./result_8chains/node342_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_3_0 -p 218 -st none -pt topic342_3_0 -u 0.009819317286859863 > ./result_8chains/node342_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_4_0 -p 615 -st none -pt topic342_4_0 -u 0.04345973329312064 > ./result_8chains/node342_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_5_0 -p 637 -st none -pt topic342_5_0 -u 0.020596925544639183 > ./result_8chains/node342_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_6_0 -p 660 -st none -pt topic342_6_0 -u 0.020180266990641182 > ./result_8chains/node342_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node342_7_0 -p 954 -st none -pt topic342_7_0 -u 0.05046480582903117 > ./result_8chains/node342_7_0.txt &
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
    "./result_8chains/node342_0_0.txt 90"
    "./result_8chains/node342_0_2.txt 90"
    "./result_8chains/node342_1_0.txt 89"
    "./result_8chains/node342_1_2.txt 89"
    "./result_8chains/node342_2_0.txt 88"
    "./result_8chains/node342_2_2.txt 88"
    "./result_8chains/node342_3_0.txt 87"
    "./result_8chains/node342_3_2.txt 87"
    "./result_8chains/node342_4_0.txt 86"
    "./result_8chains/node342_4_2.txt 86"
    "./result_8chains/node342_5_0.txt 85"
    "./result_8chains/node342_5_2.txt 85"
    "./result_8chains/node342_6_0.txt 84"
    "./result_8chains/node342_6_2.txt 84"
    "./result_8chains/node342_7_0.txt 83"
    "./result_8chains/node342_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
