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
ros2 run evaluation_3_randomdag uunifast_node -n node396_0_2 -p 104 -st topic396_0_1 -pt None -u 0.003519549383542986 > ./result_8chains/node396_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_1_2 -p 107 -st topic396_1_1 -pt None -u 0.08647837264808528 > ./result_8chains/node396_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_2_2 -p 475 -st topic396_2_1 -pt None -u 0.04118207877556762 > ./result_8chains/node396_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_3_2 -p 623 -st topic396_3_1 -pt None -u 0.005663407195657666 > ./result_8chains/node396_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_4_2 -p 715 -st topic396_4_1 -pt None -u 0.013148034126698571 > ./result_8chains/node396_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_5_2 -p 860 -st topic396_5_1 -pt None -u 0.043723475711437296 > ./result_8chains/node396_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_6_2 -p 930 -st topic396_6_1 -pt None -u 0.0006820029312509454 > ./result_8chains/node396_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_7_2 -p 956 -st topic396_7_1 -pt None -u 0.023516956709171873 > ./result_8chains/node396_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_0_0 -p 104 -st none -pt topic396_0_0 -u 0.018600601722069288 > ./result_8chains/node396_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_1_0 -p 107 -st none -pt topic396_1_0 -u 0.0008179265383762568 > ./result_8chains/node396_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_2_0 -p 475 -st none -pt topic396_2_0 -u 0.00792877029405864 > ./result_8chains/node396_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_3_0 -p 623 -st none -pt topic396_3_0 -u 0.0039736985144023795 > ./result_8chains/node396_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_4_0 -p 715 -st none -pt topic396_4_0 -u 0.03333105497942668 > ./result_8chains/node396_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_5_0 -p 860 -st none -pt topic396_5_0 -u 0.012590102385035468 > ./result_8chains/node396_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node396_6_0 -p 930 -st none -pt topic396_6_0 -u 0.02648645819544937 > ./result_8chains/node396_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node396_7_0 -p 956 -st none -pt topic396_7_0 -u 0.008481319068848837 > ./result_8chains/node396_7_0.txt &
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
    "./result_8chains/node396_0_0.txt 90"
    "./result_8chains/node396_0_2.txt 90"
    "./result_8chains/node396_1_0.txt 89"
    "./result_8chains/node396_1_2.txt 89"
    "./result_8chains/node396_2_0.txt 88"
    "./result_8chains/node396_2_2.txt 88"
    "./result_8chains/node396_3_0.txt 87"
    "./result_8chains/node396_3_2.txt 87"
    "./result_8chains/node396_4_0.txt 86"
    "./result_8chains/node396_4_2.txt 86"
    "./result_8chains/node396_5_0.txt 85"
    "./result_8chains/node396_5_2.txt 85"
    "./result_8chains/node396_6_0.txt 84"
    "./result_8chains/node396_6_2.txt 84"
    "./result_8chains/node396_7_0.txt 83"
    "./result_8chains/node396_7_2.txt 83"
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
