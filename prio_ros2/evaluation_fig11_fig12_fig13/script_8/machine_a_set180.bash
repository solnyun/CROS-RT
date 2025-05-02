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
ros2 run evaluation_3_randomdag uunifast_node -n node180_0_2 -p 108 -st topic180_0_1 -pt None -u 0.057313783466237 > ./result_8chains/node180_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_1_2 -p 290 -st topic180_1_1 -pt None -u 0.008435787476167078 > ./result_8chains/node180_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_2_2 -p 451 -st topic180_2_1 -pt None -u 0.012099173618629833 > ./result_8chains/node180_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_3_2 -p 623 -st topic180_3_1 -pt None -u 0.04454577610730592 > ./result_8chains/node180_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_4_2 -p 830 -st topic180_4_1 -pt None -u 0.02056364450499021 > ./result_8chains/node180_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_5_2 -p 862 -st topic180_5_1 -pt None -u 0.02533443042469985 > ./result_8chains/node180_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_6_2 -p 889 -st topic180_6_1 -pt None -u 0.06879057718309228 > ./result_8chains/node180_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_7_2 -p 955 -st topic180_7_1 -pt None -u 0.025682933814884637 > ./result_8chains/node180_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_0_0 -p 108 -st none -pt topic180_0_0 -u 0.016561646780115014 > ./result_8chains/node180_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_1_0 -p 290 -st none -pt topic180_1_0 -u 0.01805923645148788 > ./result_8chains/node180_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_2_0 -p 451 -st none -pt topic180_2_0 -u 0.0059185981289822664 > ./result_8chains/node180_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_3_0 -p 623 -st none -pt topic180_3_0 -u 1.866014119067394e-05 > ./result_8chains/node180_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_4_0 -p 830 -st none -pt topic180_4_0 -u 0.02419471930669098 > ./result_8chains/node180_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_5_0 -p 862 -st none -pt topic180_5_0 -u 0.03017346086902567 > ./result_8chains/node180_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node180_6_0 -p 889 -st none -pt topic180_6_0 -u 0.009378030445790692 > ./result_8chains/node180_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node180_7_0 -p 955 -st none -pt topic180_7_0 -u 0.008595309002926953 > ./result_8chains/node180_7_0.txt &
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
    "./result_8chains/node180_0_0.txt 90"
    "./result_8chains/node180_0_2.txt 90"
    "./result_8chains/node180_1_0.txt 89"
    "./result_8chains/node180_1_2.txt 89"
    "./result_8chains/node180_2_0.txt 88"
    "./result_8chains/node180_2_2.txt 88"
    "./result_8chains/node180_3_0.txt 87"
    "./result_8chains/node180_3_2.txt 87"
    "./result_8chains/node180_4_0.txt 86"
    "./result_8chains/node180_4_2.txt 86"
    "./result_8chains/node180_5_0.txt 85"
    "./result_8chains/node180_5_2.txt 85"
    "./result_8chains/node180_6_0.txt 84"
    "./result_8chains/node180_6_2.txt 84"
    "./result_8chains/node180_7_0.txt 83"
    "./result_8chains/node180_7_2.txt 83"
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
