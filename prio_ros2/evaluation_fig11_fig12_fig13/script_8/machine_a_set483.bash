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
ros2 run evaluation_3_randomdag uunifast_node -n node483_0_2 -p 118 -st topic483_0_1 -pt None -u 0.020469716759140943 > ./result_8chains/node483_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_1_2 -p 142 -st topic483_1_1 -pt None -u 0.0005847066881213281 > ./result_8chains/node483_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_2_2 -p 252 -st topic483_2_1 -pt None -u 0.013180372341528024 > ./result_8chains/node483_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_3_2 -p 295 -st topic483_3_1 -pt None -u 0.016445816808104363 > ./result_8chains/node483_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_4_2 -p 343 -st topic483_4_1 -pt None -u 0.00645192036780648 > ./result_8chains/node483_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_5_2 -p 418 -st topic483_5_1 -pt None -u 0.042095608117119404 > ./result_8chains/node483_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_6_2 -p 560 -st topic483_6_1 -pt None -u 0.02573322578365065 > ./result_8chains/node483_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_7_2 -p 736 -st topic483_7_1 -pt None -u 0.024203889904729776 > ./result_8chains/node483_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_0_0 -p 118 -st none -pt topic483_0_0 -u 0.04927988939332617 > ./result_8chains/node483_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_1_0 -p 142 -st none -pt topic483_1_0 -u 0.034709986418705596 > ./result_8chains/node483_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_2_0 -p 252 -st none -pt topic483_2_0 -u 0.05648230864422227 > ./result_8chains/node483_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_3_0 -p 295 -st none -pt topic483_3_0 -u 0.0011613761777078402 > ./result_8chains/node483_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_4_0 -p 343 -st none -pt topic483_4_0 -u 0.013862879032452008 > ./result_8chains/node483_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_5_0 -p 418 -st none -pt topic483_5_0 -u 0.0373466060565284 > ./result_8chains/node483_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_6_0 -p 560 -st none -pt topic483_6_0 -u 0.002800037675533343 > ./result_8chains/node483_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_7_0 -p 736 -st none -pt topic483_7_0 -u 0.007254564681253496 > ./result_8chains/node483_7_0.txt &
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
    "./result_8chains/node483_0_0.txt 90"
    "./result_8chains/node483_0_2.txt 90"
    "./result_8chains/node483_1_0.txt 89"
    "./result_8chains/node483_1_2.txt 89"
    "./result_8chains/node483_2_0.txt 88"
    "./result_8chains/node483_2_2.txt 88"
    "./result_8chains/node483_3_0.txt 87"
    "./result_8chains/node483_3_2.txt 87"
    "./result_8chains/node483_4_0.txt 86"
    "./result_8chains/node483_4_2.txt 86"
    "./result_8chains/node483_5_0.txt 85"
    "./result_8chains/node483_5_2.txt 85"
    "./result_8chains/node483_6_0.txt 84"
    "./result_8chains/node483_6_2.txt 84"
    "./result_8chains/node483_7_0.txt 83"
    "./result_8chains/node483_7_2.txt 83"
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
