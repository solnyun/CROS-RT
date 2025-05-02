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
ros2 run evaluation_3_randomdag uunifast_node -n node475_0_2 -p 84 -st topic475_0_1 -pt None -u 0.002188005824881656 > ./result_8chains/node475_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_1_2 -p 190 -st topic475_1_1 -pt None -u 0.06483032334627303 > ./result_8chains/node475_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_2_2 -p 241 -st topic475_2_1 -pt None -u 0.006856918327352413 > ./result_8chains/node475_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_3_2 -p 485 -st topic475_3_1 -pt None -u 0.03280675782423231 > ./result_8chains/node475_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_4_2 -p 590 -st topic475_4_1 -pt None -u 0.04548217205475144 > ./result_8chains/node475_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_5_2 -p 709 -st topic475_5_1 -pt None -u 0.0486336132554723 > ./result_8chains/node475_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_6_2 -p 737 -st topic475_6_1 -pt None -u 0.0010141766058737317 > ./result_8chains/node475_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_7_2 -p 748 -st topic475_7_1 -pt None -u 0.013780262309045485 > ./result_8chains/node475_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_0_0 -p 84 -st none -pt topic475_0_0 -u 0.002163225530250168 > ./result_8chains/node475_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_1_0 -p 190 -st none -pt topic475_1_0 -u 0.008961888201492851 > ./result_8chains/node475_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_2_0 -p 241 -st none -pt topic475_2_0 -u 0.05800090747775333 > ./result_8chains/node475_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_3_0 -p 485 -st none -pt topic475_3_0 -u 0.02079638213137963 > ./result_8chains/node475_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_4_0 -p 590 -st none -pt topic475_4_0 -u 0.010125501490083982 > ./result_8chains/node475_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_5_0 -p 709 -st none -pt topic475_5_0 -u 0.016062513141344617 > ./result_8chains/node475_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_6_0 -p 737 -st none -pt topic475_6_0 -u 0.01884465607126215 > ./result_8chains/node475_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_7_0 -p 748 -st none -pt topic475_7_0 -u 0.00010378314428381025 > ./result_8chains/node475_7_0.txt &
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
    "./result_8chains/node475_0_0.txt 90"
    "./result_8chains/node475_0_2.txt 90"
    "./result_8chains/node475_1_0.txt 89"
    "./result_8chains/node475_1_2.txt 89"
    "./result_8chains/node475_2_0.txt 88"
    "./result_8chains/node475_2_2.txt 88"
    "./result_8chains/node475_3_0.txt 87"
    "./result_8chains/node475_3_2.txt 87"
    "./result_8chains/node475_4_0.txt 86"
    "./result_8chains/node475_4_2.txt 86"
    "./result_8chains/node475_5_0.txt 85"
    "./result_8chains/node475_5_2.txt 85"
    "./result_8chains/node475_6_0.txt 84"
    "./result_8chains/node475_6_2.txt 84"
    "./result_8chains/node475_7_0.txt 83"
    "./result_8chains/node475_7_2.txt 83"
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
