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
ros2 run evaluation_3_randomdag uunifast_node -n node374_0_2 -p 154 -st topic374_0_1 -pt None -u 0.005203294055804442 > ./result_10chains/node374_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_1_2 -p 235 -st topic374_1_1 -pt None -u 0.007373253456194273 > ./result_10chains/node374_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_2_2 -p 470 -st topic374_2_1 -pt None -u 0.012236350107762584 > ./result_10chains/node374_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_3_2 -p 496 -st topic374_3_1 -pt None -u 0.006472911274550963 > ./result_10chains/node374_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_4_2 -p 503 -st topic374_4_1 -pt None -u 0.025062834425479852 > ./result_10chains/node374_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_5_2 -p 592 -st topic374_5_1 -pt None -u 0.020389326118189527 > ./result_10chains/node374_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_6_2 -p 594 -st topic374_6_1 -pt None -u 0.014119334876270095 > ./result_10chains/node374_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_7_2 -p 709 -st topic374_7_1 -pt None -u 0.024591546446145293 > ./result_10chains/node374_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_8_2 -p 810 -st topic374_8_1 -pt None -u 0.034852972238018184 > ./result_10chains/node374_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_9_2 -p 854 -st topic374_9_1 -pt None -u 0.026450632452053327 > ./result_10chains/node374_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_0_0 -p 154 -st none -pt topic374_0_0 -u 0.00783275903859093 > ./result_10chains/node374_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_1_0 -p 235 -st none -pt topic374_1_0 -u 0.00011657425287564527 > ./result_10chains/node374_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_2_0 -p 470 -st none -pt topic374_2_0 -u 0.0012730965895039192 > ./result_10chains/node374_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_3_0 -p 496 -st none -pt topic374_3_0 -u 0.04419517240230603 > ./result_10chains/node374_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_4_0 -p 503 -st none -pt topic374_4_0 -u 0.023214604998688604 > ./result_10chains/node374_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_5_0 -p 592 -st none -pt topic374_5_0 -u 0.03233922308043874 > ./result_10chains/node374_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_6_0 -p 594 -st none -pt topic374_6_0 -u 0.05341818924706321 > ./result_10chains/node374_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_7_0 -p 709 -st none -pt topic374_7_0 -u 0.008564491216560388 > ./result_10chains/node374_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node374_8_0 -p 810 -st none -pt topic374_8_0 -u 0.007766756907376923 > ./result_10chains/node374_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node374_9_0 -p 854 -st none -pt topic374_9_0 -u 0.016437063073265923 > ./result_10chains/node374_9_0.txt &
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
    "./result_10chains/node374_0_0.txt 90"
    "./result_10chains/node374_0_2.txt 90"
    "./result_10chains/node374_1_0.txt 89"
    "./result_10chains/node374_1_2.txt 89"
    "./result_10chains/node374_2_0.txt 88"
    "./result_10chains/node374_2_2.txt 88"
    "./result_10chains/node374_3_0.txt 87"
    "./result_10chains/node374_3_2.txt 87"
    "./result_10chains/node374_4_0.txt 86"
    "./result_10chains/node374_4_2.txt 86"
    "./result_10chains/node374_5_0.txt 85"
    "./result_10chains/node374_5_2.txt 85"
    "./result_10chains/node374_6_0.txt 84"
    "./result_10chains/node374_6_2.txt 84"
    "./result_10chains/node374_7_0.txt 83"
    "./result_10chains/node374_7_2.txt 83"
    "./result_10chains/node374_8_0.txt 82"
    "./result_10chains/node374_8_2.txt 82"
    "./result_10chains/node374_9_0.txt 81"
    "./result_10chains/node374_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
