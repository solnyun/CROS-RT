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
ros2 run evaluation_3_randomdag uunifast_node -n node15_0_2 -p 37 -st topic15_0_1 -pt None -u 0.010742569800102408 > ./result_10chains/node15_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_1_2 -p 241 -st topic15_1_1 -pt None -u 0.006381024094120391 > ./result_10chains/node15_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_2_2 -p 249 -st topic15_2_1 -pt None -u 0.012485897063996165 > ./result_10chains/node15_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_3_2 -p 464 -st topic15_3_1 -pt None -u 0.002927074953005704 > ./result_10chains/node15_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_4_2 -p 614 -st topic15_4_1 -pt None -u 0.01240178344147519 > ./result_10chains/node15_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_5_2 -p 626 -st topic15_5_1 -pt None -u 0.005148951606995411 > ./result_10chains/node15_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_6_2 -p 636 -st topic15_6_1 -pt None -u 0.07082538265566612 > ./result_10chains/node15_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_7_2 -p 748 -st topic15_7_1 -pt None -u 0.02553451557066072 > ./result_10chains/node15_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_8_2 -p 789 -st topic15_8_1 -pt None -u 0.07783700794842693 > ./result_10chains/node15_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_9_2 -p 874 -st topic15_9_1 -pt None -u 0.05254213645552215 > ./result_10chains/node15_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_0_0 -p 37 -st none -pt topic15_0_0 -u 4.168737611381923e-05 > ./result_10chains/node15_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_1_0 -p 241 -st none -pt topic15_1_0 -u 0.0015186263203808559 > ./result_10chains/node15_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_2_0 -p 249 -st none -pt topic15_2_0 -u 0.03719093539594953 > ./result_10chains/node15_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_3_0 -p 464 -st none -pt topic15_3_0 -u 0.01686739861003611 > ./result_10chains/node15_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_4_0 -p 614 -st none -pt topic15_4_0 -u 0.002688989314055479 > ./result_10chains/node15_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_5_0 -p 626 -st none -pt topic15_5_0 -u 0.014580057476468677 > ./result_10chains/node15_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_6_0 -p 636 -st none -pt topic15_6_0 -u 0.009333950067481556 > ./result_10chains/node15_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_7_0 -p 748 -st none -pt topic15_7_0 -u 0.007416001644257791 > ./result_10chains/node15_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node15_8_0 -p 789 -st none -pt topic15_8_0 -u 0.0023988879383706196 > ./result_10chains/node15_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node15_9_0 -p 874 -st none -pt topic15_9_0 -u 0.029702029741029035 > ./result_10chains/node15_9_0.txt &
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
    "./result_10chains/node15_0_0.txt 90"
    "./result_10chains/node15_0_2.txt 90"
    "./result_10chains/node15_1_0.txt 89"
    "./result_10chains/node15_1_2.txt 89"
    "./result_10chains/node15_2_0.txt 88"
    "./result_10chains/node15_2_2.txt 88"
    "./result_10chains/node15_3_0.txt 87"
    "./result_10chains/node15_3_2.txt 87"
    "./result_10chains/node15_4_0.txt 86"
    "./result_10chains/node15_4_2.txt 86"
    "./result_10chains/node15_5_0.txt 85"
    "./result_10chains/node15_5_2.txt 85"
    "./result_10chains/node15_6_0.txt 84"
    "./result_10chains/node15_6_2.txt 84"
    "./result_10chains/node15_7_0.txt 83"
    "./result_10chains/node15_7_2.txt 83"
    "./result_10chains/node15_8_0.txt 82"
    "./result_10chains/node15_8_2.txt 82"
    "./result_10chains/node15_9_0.txt 81"
    "./result_10chains/node15_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
