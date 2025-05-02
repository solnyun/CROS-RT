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
ros2 run evaluation_3_randomdag uunifast_node -n node407_0_2 -p 51 -st topic407_0_1 -pt None -u 0.01286172177563527 > ./result_8chains/node407_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_1_2 -p 438 -st topic407_1_1 -pt None -u 0.011586142520672804 > ./result_8chains/node407_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_2_2 -p 460 -st topic407_2_1 -pt None -u 0.002171024852103076 > ./result_8chains/node407_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_3_2 -p 578 -st topic407_3_1 -pt None -u 0.061779751371592806 > ./result_8chains/node407_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_4_2 -p 703 -st topic407_4_1 -pt None -u 0.0139201575461734 > ./result_8chains/node407_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_5_2 -p 767 -st topic407_5_1 -pt None -u 0.032919488165979935 > ./result_8chains/node407_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_6_2 -p 781 -st topic407_6_1 -pt None -u 0.0224261110040265 > ./result_8chains/node407_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_7_2 -p 974 -st topic407_7_1 -pt None -u 1.4644367479184827e-05 > ./result_8chains/node407_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_0_0 -p 51 -st none -pt topic407_0_0 -u 0.027993267239730224 > ./result_8chains/node407_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_1_0 -p 438 -st none -pt topic407_1_0 -u 0.06422954594141522 > ./result_8chains/node407_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_2_0 -p 460 -st none -pt topic407_2_0 -u 0.005367138946832106 > ./result_8chains/node407_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_3_0 -p 578 -st none -pt topic407_3_0 -u 0.01671199389912864 > ./result_8chains/node407_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_4_0 -p 703 -st none -pt topic407_4_0 -u 0.04091243286754573 > ./result_8chains/node407_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_5_0 -p 767 -st none -pt topic407_5_0 -u 0.019677893516480582 > ./result_8chains/node407_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_6_0 -p 781 -st none -pt topic407_6_0 -u 0.00368724370609147 > ./result_8chains/node407_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node407_7_0 -p 974 -st none -pt topic407_7_0 -u 0.020439149029809468 > ./result_8chains/node407_7_0.txt &
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
    "./result_8chains/node407_0_0.txt 90"
    "./result_8chains/node407_0_2.txt 90"
    "./result_8chains/node407_1_0.txt 89"
    "./result_8chains/node407_1_2.txt 89"
    "./result_8chains/node407_2_0.txt 88"
    "./result_8chains/node407_2_2.txt 88"
    "./result_8chains/node407_3_0.txt 87"
    "./result_8chains/node407_3_2.txt 87"
    "./result_8chains/node407_4_0.txt 86"
    "./result_8chains/node407_4_2.txt 86"
    "./result_8chains/node407_5_0.txt 85"
    "./result_8chains/node407_5_2.txt 85"
    "./result_8chains/node407_6_0.txt 84"
    "./result_8chains/node407_6_2.txt 84"
    "./result_8chains/node407_7_0.txt 83"
    "./result_8chains/node407_7_2.txt 83"
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
