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
ros2 run evaluation_3_randomdag uunifast_node -n node473_0_2 -p 168 -st topic473_0_1 -pt None -u 0.03397853968050413 > ./result_6chains/node473_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_1_2 -p 174 -st topic473_1_1 -pt None -u 0.0332803299990691 > ./result_6chains/node473_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_2_2 -p 336 -st topic473_2_1 -pt None -u 0.015015104589371497 > ./result_6chains/node473_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_3_2 -p 368 -st topic473_3_1 -pt None -u 0.018392757369062512 > ./result_6chains/node473_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_4_2 -p 575 -st topic473_4_1 -pt None -u 0.014081262125274357 > ./result_6chains/node473_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_5_2 -p 684 -st topic473_5_1 -pt None -u 0.05333843485409356 > ./result_6chains/node473_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_0_0 -p 168 -st none -pt topic473_0_0 -u 0.010484666987193247 > ./result_6chains/node473_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_1_0 -p 174 -st none -pt topic473_1_0 -u 0.035304722355372964 > ./result_6chains/node473_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_2_0 -p 336 -st none -pt topic473_2_0 -u 0.0328439401992055 > ./result_6chains/node473_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_3_0 -p 368 -st none -pt topic473_3_0 -u 0.00284094636510418 > ./result_6chains/node473_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node473_4_0 -p 575 -st none -pt topic473_4_0 -u 0.00022910425507630117 > ./result_6chains/node473_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node473_5_0 -p 684 -st none -pt topic473_5_0 -u 0.07039619860103769 > ./result_6chains/node473_5_0.txt &
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
    "./result_6chains/node473_0_0.txt 90"
    "./result_6chains/node473_0_2.txt 90"
    "./result_6chains/node473_1_0.txt 89"
    "./result_6chains/node473_1_2.txt 89"
    "./result_6chains/node473_2_0.txt 88"
    "./result_6chains/node473_2_2.txt 88"
    "./result_6chains/node473_3_0.txt 87"
    "./result_6chains/node473_3_2.txt 87"
    "./result_6chains/node473_4_0.txt 86"
    "./result_6chains/node473_4_2.txt 86"
    "./result_6chains/node473_5_0.txt 85"
    "./result_6chains/node473_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
