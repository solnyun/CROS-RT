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
ros2 run evaluation_3_randomdag uunifast_node -n node202_0_2 -p 107 -st topic202_0_1 -pt None -u 0.02478900320904004 > ./result_8chains/node202_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_1_2 -p 109 -st topic202_1_1 -pt None -u 0.0125830877447628 > ./result_8chains/node202_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_2_2 -p 139 -st topic202_2_1 -pt None -u 0.08426101684975701 > ./result_8chains/node202_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_3_2 -p 271 -st topic202_3_1 -pt None -u 0.01042705132825883 > ./result_8chains/node202_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_4_2 -p 373 -st topic202_4_1 -pt None -u 0.04631585204317254 > ./result_8chains/node202_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_5_2 -p 451 -st topic202_5_1 -pt None -u 0.026699199199449103 > ./result_8chains/node202_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_6_2 -p 708 -st topic202_6_1 -pt None -u 0.01473852063379653 > ./result_8chains/node202_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_7_2 -p 749 -st topic202_7_1 -pt None -u 0.0027376412459398404 > ./result_8chains/node202_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_0_0 -p 107 -st none -pt topic202_0_0 -u 0.02465554565610023 > ./result_8chains/node202_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_1_0 -p 109 -st none -pt topic202_1_0 -u 0.011654214174320165 > ./result_8chains/node202_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_2_0 -p 139 -st none -pt topic202_2_0 -u 5.6304649331151424e-05 > ./result_8chains/node202_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_3_0 -p 271 -st none -pt topic202_3_0 -u 0.04747210699853155 > ./result_8chains/node202_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_4_0 -p 373 -st none -pt topic202_4_0 -u 0.004037753437960118 > ./result_8chains/node202_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_5_0 -p 451 -st none -pt topic202_5_0 -u 0.013597409288027273 > ./result_8chains/node202_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node202_6_0 -p 708 -st none -pt topic202_6_0 -u 0.00991314609708601 > ./result_8chains/node202_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node202_7_0 -p 749 -st none -pt topic202_7_0 -u 0.00915311543194293 > ./result_8chains/node202_7_0.txt &
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
    "./result_8chains/node202_0_0.txt 90"
    "./result_8chains/node202_0_2.txt 90"
    "./result_8chains/node202_1_0.txt 89"
    "./result_8chains/node202_1_2.txt 89"
    "./result_8chains/node202_2_0.txt 88"
    "./result_8chains/node202_2_2.txt 88"
    "./result_8chains/node202_3_0.txt 87"
    "./result_8chains/node202_3_2.txt 87"
    "./result_8chains/node202_4_0.txt 86"
    "./result_8chains/node202_4_2.txt 86"
    "./result_8chains/node202_5_0.txt 85"
    "./result_8chains/node202_5_2.txt 85"
    "./result_8chains/node202_6_0.txt 84"
    "./result_8chains/node202_6_2.txt 84"
    "./result_8chains/node202_7_0.txt 83"
    "./result_8chains/node202_7_2.txt 83"
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
