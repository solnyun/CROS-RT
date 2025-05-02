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
ros2 run evaluation_3_randomdag uunifast_node -n node250_0_2 -p 161 -st topic250_0_1 -pt None -u 0.002376283606999652 > ./result_8chains/node250_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_1_2 -p 197 -st topic250_1_1 -pt None -u 0.007282963039312307 > ./result_8chains/node250_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_2_2 -p 285 -st topic250_2_1 -pt None -u 2.9113576618611248e-05 > ./result_8chains/node250_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_3_2 -p 295 -st topic250_3_1 -pt None -u 0.03722707422845767 > ./result_8chains/node250_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_4_2 -p 572 -st topic250_4_1 -pt None -u 0.006191005618308432 > ./result_8chains/node250_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_5_2 -p 631 -st topic250_5_1 -pt None -u 0.032762066445270605 > ./result_8chains/node250_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_6_2 -p 887 -st topic250_6_1 -pt None -u 0.053626497946726776 > ./result_8chains/node250_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_7_2 -p 977 -st topic250_7_1 -pt None -u 0.004430553821801318 > ./result_8chains/node250_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_0_0 -p 161 -st none -pt topic250_0_0 -u 0.018018926973697003 > ./result_8chains/node250_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_1_0 -p 197 -st none -pt topic250_1_0 -u 0.048650828504781085 > ./result_8chains/node250_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_2_0 -p 285 -st none -pt topic250_2_0 -u 0.008874795625590293 > ./result_8chains/node250_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_3_0 -p 295 -st none -pt topic250_3_0 -u 0.005263411317555922 > ./result_8chains/node250_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_4_0 -p 572 -st none -pt topic250_4_0 -u 0.025464130039887234 > ./result_8chains/node250_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_5_0 -p 631 -st none -pt topic250_5_0 -u 0.02798855303817524 > ./result_8chains/node250_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node250_6_0 -p 887 -st none -pt topic250_6_0 -u 0.006333381028419183 > ./result_8chains/node250_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node250_7_0 -p 977 -st none -pt topic250_7_0 -u 0.02388801524143043 > ./result_8chains/node250_7_0.txt &
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
    "./result_8chains/node250_0_0.txt 90"
    "./result_8chains/node250_0_2.txt 90"
    "./result_8chains/node250_1_0.txt 89"
    "./result_8chains/node250_1_2.txt 89"
    "./result_8chains/node250_2_0.txt 88"
    "./result_8chains/node250_2_2.txt 88"
    "./result_8chains/node250_3_0.txt 87"
    "./result_8chains/node250_3_2.txt 87"
    "./result_8chains/node250_4_0.txt 86"
    "./result_8chains/node250_4_2.txt 86"
    "./result_8chains/node250_5_0.txt 85"
    "./result_8chains/node250_5_2.txt 85"
    "./result_8chains/node250_6_0.txt 84"
    "./result_8chains/node250_6_2.txt 84"
    "./result_8chains/node250_7_0.txt 83"
    "./result_8chains/node250_7_2.txt 83"
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
