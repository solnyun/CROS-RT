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
ros2 run evaluation_3_randomdag uunifast_node -n node304_0_2 -p 16 -st topic304_0_1 -pt None -u 0.0020655550049757387 > ./result_8chains/node304_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_1_2 -p 83 -st topic304_1_1 -pt None -u 0.013784368583154849 > ./result_8chains/node304_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_2_2 -p 162 -st topic304_2_1 -pt None -u 0.008105534895999633 > ./result_8chains/node304_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_3_2 -p 303 -st topic304_3_1 -pt None -u 0.03999682735283455 > ./result_8chains/node304_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_4_2 -p 397 -st topic304_4_1 -pt None -u 0.021706015035654225 > ./result_8chains/node304_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_5_2 -p 514 -st topic304_5_1 -pt None -u 0.004157206984285344 > ./result_8chains/node304_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_6_2 -p 524 -st topic304_6_1 -pt None -u 0.005504582965708146 > ./result_8chains/node304_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_7_2 -p 728 -st topic304_7_1 -pt None -u 0.01977738663356633 > ./result_8chains/node304_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_0_0 -p 16 -st none -pt topic304_0_0 -u 0.06566974052281072 > ./result_8chains/node304_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_1_0 -p 83 -st none -pt topic304_1_0 -u 0.07536662251819526 > ./result_8chains/node304_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_2_0 -p 162 -st none -pt topic304_2_0 -u 0.05326265225603588 > ./result_8chains/node304_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_3_0 -p 303 -st none -pt topic304_3_0 -u 0.012905282330896689 > ./result_8chains/node304_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_4_0 -p 397 -st none -pt topic304_4_0 -u 0.00889496345364249 > ./result_8chains/node304_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_5_0 -p 514 -st none -pt topic304_5_0 -u 0.003858952329805765 > ./result_8chains/node304_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_6_0 -p 524 -st none -pt topic304_6_0 -u 0.023103467777801763 > ./result_8chains/node304_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_7_0 -p 728 -st none -pt topic304_7_0 -u 0.0008523723887949794 > ./result_8chains/node304_7_0.txt &
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
    "./result_8chains/node304_0_0.txt 90"
    "./result_8chains/node304_0_2.txt 90"
    "./result_8chains/node304_1_0.txt 89"
    "./result_8chains/node304_1_2.txt 89"
    "./result_8chains/node304_2_0.txt 88"
    "./result_8chains/node304_2_2.txt 88"
    "./result_8chains/node304_3_0.txt 87"
    "./result_8chains/node304_3_2.txt 87"
    "./result_8chains/node304_4_0.txt 86"
    "./result_8chains/node304_4_2.txt 86"
    "./result_8chains/node304_5_0.txt 85"
    "./result_8chains/node304_5_2.txt 85"
    "./result_8chains/node304_6_0.txt 84"
    "./result_8chains/node304_6_2.txt 84"
    "./result_8chains/node304_7_0.txt 83"
    "./result_8chains/node304_7_2.txt 83"
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
