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
ros2 run evaluation_3_randomdag uunifast_node -n node170_0_2 -p 17 -st topic170_0_1 -pt None -u 0.06924372743788543 > ./result_8chains/node170_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_1_2 -p 141 -st topic170_1_1 -pt None -u 0.0016168997205409097 > ./result_8chains/node170_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_2_2 -p 370 -st topic170_2_1 -pt None -u 0.020386722810997182 > ./result_8chains/node170_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_3_2 -p 455 -st topic170_3_1 -pt None -u 0.07863824574068984 > ./result_8chains/node170_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_4_2 -p 478 -st topic170_4_1 -pt None -u 0.01187081562198991 > ./result_8chains/node170_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_5_2 -p 517 -st topic170_5_1 -pt None -u 0.02729160340116446 > ./result_8chains/node170_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_6_2 -p 534 -st topic170_6_1 -pt None -u 0.013188801443334883 > ./result_8chains/node170_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_7_2 -p 799 -st topic170_7_1 -pt None -u 0.019663471258833057 > ./result_8chains/node170_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_0_0 -p 17 -st none -pt topic170_0_0 -u 0.0016538006416195739 > ./result_8chains/node170_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_1_0 -p 141 -st none -pt topic170_1_0 -u 0.0010176591042074246 > ./result_8chains/node170_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_2_0 -p 370 -st none -pt topic170_2_0 -u 0.003150359961900273 > ./result_8chains/node170_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_3_0 -p 455 -st none -pt topic170_3_0 -u 0.001911690630912788 > ./result_8chains/node170_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_4_0 -p 478 -st none -pt topic170_4_0 -u 0.0027977688957213087 > ./result_8chains/node170_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_5_0 -p 517 -st none -pt topic170_5_0 -u 0.0543249247108043 > ./result_8chains/node170_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_6_0 -p 534 -st none -pt topic170_6_0 -u 0.010159255082317464 > ./result_8chains/node170_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_7_0 -p 799 -st none -pt topic170_7_0 -u 0.022584509381979298 > ./result_8chains/node170_7_0.txt &
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
    "./result_8chains/node170_0_0.txt 90"
    "./result_8chains/node170_0_2.txt 90"
    "./result_8chains/node170_1_0.txt 89"
    "./result_8chains/node170_1_2.txt 89"
    "./result_8chains/node170_2_0.txt 88"
    "./result_8chains/node170_2_2.txt 88"
    "./result_8chains/node170_3_0.txt 87"
    "./result_8chains/node170_3_2.txt 87"
    "./result_8chains/node170_4_0.txt 86"
    "./result_8chains/node170_4_2.txt 86"
    "./result_8chains/node170_5_0.txt 85"
    "./result_8chains/node170_5_2.txt 85"
    "./result_8chains/node170_6_0.txt 84"
    "./result_8chains/node170_6_2.txt 84"
    "./result_8chains/node170_7_0.txt 83"
    "./result_8chains/node170_7_2.txt 83"
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
