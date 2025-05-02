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
ros2 run evaluation_3_randomdag uunifast_node -n node9_0_2 -p 172 -st topic9_0_1 -pt None -u 0.025194184693193067 > ./result_8chains/node9_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_1_2 -p 217 -st topic9_1_1 -pt None -u 0.04527770108434109 > ./result_8chains/node9_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_2_2 -p 222 -st topic9_2_1 -pt None -u 0.03468598275454804 > ./result_8chains/node9_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_3_2 -p 239 -st topic9_3_1 -pt None -u 0.0163771312557775 > ./result_8chains/node9_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_4_2 -p 501 -st topic9_4_1 -pt None -u 0.008639211709360745 > ./result_8chains/node9_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_5_2 -p 629 -st topic9_5_1 -pt None -u 0.028492360102328057 > ./result_8chains/node9_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_6_2 -p 728 -st topic9_6_1 -pt None -u 0.0062426781652568375 > ./result_8chains/node9_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_7_2 -p 760 -st topic9_7_1 -pt None -u 0.05779499907372592 > ./result_8chains/node9_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_0_0 -p 172 -st none -pt topic9_0_0 -u 0.007210089395801034 > ./result_8chains/node9_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_1_0 -p 217 -st none -pt topic9_1_0 -u 0.008960306902059179 > ./result_8chains/node9_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_2_0 -p 222 -st none -pt topic9_2_0 -u 0.0050796161591051825 > ./result_8chains/node9_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_3_0 -p 239 -st none -pt topic9_3_0 -u 0.0028796631276645224 > ./result_8chains/node9_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_4_0 -p 501 -st none -pt topic9_4_0 -u 0.005521403383169143 > ./result_8chains/node9_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_5_0 -p 629 -st none -pt topic9_5_0 -u 0.0004490166921129468 > ./result_8chains/node9_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_6_0 -p 728 -st none -pt topic9_6_0 -u 0.00309434453419985 > ./result_8chains/node9_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_7_0 -p 760 -st none -pt topic9_7_0 -u 0.03549674657765495 > ./result_8chains/node9_7_0.txt &
sleep 10
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
    "./result_8chains/node9_0_0.txt 90"
    "./result_8chains/node9_0_2.txt 90"
    "./result_8chains/node9_1_0.txt 89"
    "./result_8chains/node9_1_2.txt 89"
    "./result_8chains/node9_2_0.txt 88"
    "./result_8chains/node9_2_2.txt 88"
    "./result_8chains/node9_3_0.txt 87"
    "./result_8chains/node9_3_2.txt 87"
    "./result_8chains/node9_4_0.txt 86"
    "./result_8chains/node9_4_2.txt 86"
    "./result_8chains/node9_5_0.txt 85"
    "./result_8chains/node9_5_2.txt 85"
    "./result_8chains/node9_6_0.txt 84"
    "./result_8chains/node9_6_2.txt 84"
    "./result_8chains/node9_7_0.txt 83"
    "./result_8chains/node9_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
