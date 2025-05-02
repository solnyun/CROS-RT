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
ros2 run evaluation_3_randomdag uunifast_node -n node182_0_2 -p 438 -st topic182_0_1 -pt None -u 0.011341174831980938 > ./result_8chains/node182_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_1_2 -p 508 -st topic182_1_1 -pt None -u 0.021361420775736384 > ./result_8chains/node182_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_2_2 -p 689 -st topic182_2_1 -pt None -u 0.020507057549151164 > ./result_8chains/node182_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_3_2 -p 762 -st topic182_3_1 -pt None -u 0.001479059351961659 > ./result_8chains/node182_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_4_2 -p 832 -st topic182_4_1 -pt None -u 0.024689157161303016 > ./result_8chains/node182_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_5_2 -p 885 -st topic182_5_1 -pt None -u 0.000822124736926555 > ./result_8chains/node182_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_6_2 -p 904 -st topic182_6_1 -pt None -u 0.05412317746390354 > ./result_8chains/node182_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_7_2 -p 951 -st topic182_7_1 -pt None -u 0.035027284406843065 > ./result_8chains/node182_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_0_0 -p 438 -st none -pt topic182_0_0 -u 0.0941916658252997 > ./result_8chains/node182_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_1_0 -p 508 -st none -pt topic182_1_0 -u 0.018657732760363976 > ./result_8chains/node182_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_2_0 -p 689 -st none -pt topic182_2_0 -u 0.004577956469328626 > ./result_8chains/node182_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_3_0 -p 762 -st none -pt topic182_3_0 -u 0.015503875581228621 > ./result_8chains/node182_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_4_0 -p 832 -st none -pt topic182_4_0 -u 0.003831313053220209 > ./result_8chains/node182_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_5_0 -p 885 -st none -pt topic182_5_0 -u 0.003992969619626113 > ./result_8chains/node182_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node182_6_0 -p 904 -st none -pt topic182_6_0 -u 0.0010293315771710554 > ./result_8chains/node182_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node182_7_0 -p 951 -st none -pt topic182_7_0 -u 0.002705643599154643 > ./result_8chains/node182_7_0.txt &
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
    "./result_8chains/node182_0_0.txt 90"
    "./result_8chains/node182_0_2.txt 90"
    "./result_8chains/node182_1_0.txt 89"
    "./result_8chains/node182_1_2.txt 89"
    "./result_8chains/node182_2_0.txt 88"
    "./result_8chains/node182_2_2.txt 88"
    "./result_8chains/node182_3_0.txt 87"
    "./result_8chains/node182_3_2.txt 87"
    "./result_8chains/node182_4_0.txt 86"
    "./result_8chains/node182_4_2.txt 86"
    "./result_8chains/node182_5_0.txt 85"
    "./result_8chains/node182_5_2.txt 85"
    "./result_8chains/node182_6_0.txt 84"
    "./result_8chains/node182_6_2.txt 84"
    "./result_8chains/node182_7_0.txt 83"
    "./result_8chains/node182_7_2.txt 83"
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
