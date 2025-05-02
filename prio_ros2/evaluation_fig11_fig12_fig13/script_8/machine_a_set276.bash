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
ros2 run evaluation_3_randomdag uunifast_node -n node276_0_2 -p 83 -st topic276_0_1 -pt None -u 0.04270104925623608 > ./result_8chains/node276_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_1_2 -p 174 -st topic276_1_1 -pt None -u 0.02857234234150502 > ./result_8chains/node276_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_2_2 -p 204 -st topic276_2_1 -pt None -u 0.024896486760382197 > ./result_8chains/node276_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_3_2 -p 385 -st topic276_3_1 -pt None -u 0.004496170439867386 > ./result_8chains/node276_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_4_2 -p 554 -st topic276_4_1 -pt None -u 0.04516356754365711 > ./result_8chains/node276_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_5_2 -p 741 -st topic276_5_1 -pt None -u 0.03771668856871846 > ./result_8chains/node276_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_6_2 -p 781 -st topic276_6_1 -pt None -u 0.015998165806714634 > ./result_8chains/node276_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_7_2 -p 921 -st topic276_7_1 -pt None -u 0.036875011012947115 > ./result_8chains/node276_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_0_0 -p 83 -st none -pt topic276_0_0 -u 0.012145687043791764 > ./result_8chains/node276_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_1_0 -p 174 -st none -pt topic276_1_0 -u 0.0025156299249640135 > ./result_8chains/node276_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_2_0 -p 204 -st none -pt topic276_2_0 -u 0.014963633665923015 > ./result_8chains/node276_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_3_0 -p 385 -st none -pt topic276_3_0 -u 0.026951627550976798 > ./result_8chains/node276_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_4_0 -p 554 -st none -pt topic276_4_0 -u 0.010884791062694299 > ./result_8chains/node276_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_5_0 -p 741 -st none -pt topic276_5_0 -u 0.04535186505604211 > ./result_8chains/node276_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_6_0 -p 781 -st none -pt topic276_6_0 -u 0.012929405769424335 > ./result_8chains/node276_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_7_0 -p 921 -st none -pt topic276_7_0 -u 0.07393267896609812 > ./result_8chains/node276_7_0.txt &
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
    "./result_8chains/node276_0_0.txt 90"
    "./result_8chains/node276_0_2.txt 90"
    "./result_8chains/node276_1_0.txt 89"
    "./result_8chains/node276_1_2.txt 89"
    "./result_8chains/node276_2_0.txt 88"
    "./result_8chains/node276_2_2.txt 88"
    "./result_8chains/node276_3_0.txt 87"
    "./result_8chains/node276_3_2.txt 87"
    "./result_8chains/node276_4_0.txt 86"
    "./result_8chains/node276_4_2.txt 86"
    "./result_8chains/node276_5_0.txt 85"
    "./result_8chains/node276_5_2.txt 85"
    "./result_8chains/node276_6_0.txt 84"
    "./result_8chains/node276_6_2.txt 84"
    "./result_8chains/node276_7_0.txt 83"
    "./result_8chains/node276_7_2.txt 83"
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
