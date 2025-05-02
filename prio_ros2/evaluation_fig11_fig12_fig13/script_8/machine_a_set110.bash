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
ros2 run evaluation_3_randomdag uunifast_node -n node110_0_2 -p 215 -st topic110_0_1 -pt None -u 0.012631290725494682 > ./result_8chains/node110_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_1_2 -p 260 -st topic110_1_1 -pt None -u 0.015062754702305226 > ./result_8chains/node110_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_2_2 -p 342 -st topic110_2_1 -pt None -u 0.008184208902289658 > ./result_8chains/node110_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_3_2 -p 507 -st topic110_3_1 -pt None -u 0.018097759013965875 > ./result_8chains/node110_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_4_2 -p 711 -st topic110_4_1 -pt None -u 0.01850046245039838 > ./result_8chains/node110_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_5_2 -p 836 -st topic110_5_1 -pt None -u 0.08166735878706205 > ./result_8chains/node110_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_6_2 -p 847 -st topic110_6_1 -pt None -u 0.025942225098251018 > ./result_8chains/node110_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_7_2 -p 867 -st topic110_7_1 -pt None -u 0.05846731699201967 > ./result_8chains/node110_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_0_0 -p 215 -st none -pt topic110_0_0 -u 0.024387173755629876 > ./result_8chains/node110_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_1_0 -p 260 -st none -pt topic110_1_0 -u 0.002038399079156983 > ./result_8chains/node110_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_2_0 -p 342 -st none -pt topic110_2_0 -u 0.020536060049294813 > ./result_8chains/node110_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_3_0 -p 507 -st none -pt topic110_3_0 -u 0.031051435274591976 > ./result_8chains/node110_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_4_0 -p 711 -st none -pt topic110_4_0 -u 0.0013879616120263116 > ./result_8chains/node110_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_5_0 -p 836 -st none -pt topic110_5_0 -u 0.003195602977313472 > ./result_8chains/node110_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_6_0 -p 847 -st none -pt topic110_6_0 -u 0.00788740781118133 > ./result_8chains/node110_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node110_7_0 -p 867 -st none -pt topic110_7_0 -u 0.03873799021665468 > ./result_8chains/node110_7_0.txt &
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
    "./result_8chains/node110_0_0.txt 90"
    "./result_8chains/node110_0_2.txt 90"
    "./result_8chains/node110_1_0.txt 89"
    "./result_8chains/node110_1_2.txt 89"
    "./result_8chains/node110_2_0.txt 88"
    "./result_8chains/node110_2_2.txt 88"
    "./result_8chains/node110_3_0.txt 87"
    "./result_8chains/node110_3_2.txt 87"
    "./result_8chains/node110_4_0.txt 86"
    "./result_8chains/node110_4_2.txt 86"
    "./result_8chains/node110_5_0.txt 85"
    "./result_8chains/node110_5_2.txt 85"
    "./result_8chains/node110_6_0.txt 84"
    "./result_8chains/node110_6_2.txt 84"
    "./result_8chains/node110_7_0.txt 83"
    "./result_8chains/node110_7_2.txt 83"
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
