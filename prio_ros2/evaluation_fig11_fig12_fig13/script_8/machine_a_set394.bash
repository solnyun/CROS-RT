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
ros2 run evaluation_3_randomdag uunifast_node -n node394_0_2 -p 160 -st topic394_0_1 -pt None -u 0.026720843318358056 > ./result_8chains/node394_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_1_2 -p 304 -st topic394_1_1 -pt None -u 0.001740596579193121 > ./result_8chains/node394_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_2_2 -p 432 -st topic394_2_1 -pt None -u 0.0026958839242536836 > ./result_8chains/node394_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_3_2 -p 604 -st topic394_3_1 -pt None -u 0.05688709084227339 > ./result_8chains/node394_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_4_2 -p 678 -st topic394_4_1 -pt None -u 0.004643230686621813 > ./result_8chains/node394_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_5_2 -p 763 -st topic394_5_1 -pt None -u 0.029134600729483623 > ./result_8chains/node394_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_6_2 -p 772 -st topic394_6_1 -pt None -u 0.02477209328266283 > ./result_8chains/node394_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_7_2 -p 881 -st topic394_7_1 -pt None -u 0.0033952971569503588 > ./result_8chains/node394_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_0_0 -p 160 -st none -pt topic394_0_0 -u 0.03703604157734136 > ./result_8chains/node394_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_1_0 -p 304 -st none -pt topic394_1_0 -u 0.03841664621461549 > ./result_8chains/node394_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_2_0 -p 432 -st none -pt topic394_2_0 -u 0.025308811134558185 > ./result_8chains/node394_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_3_0 -p 604 -st none -pt topic394_3_0 -u 0.003576092905492989 > ./result_8chains/node394_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_4_0 -p 678 -st none -pt topic394_4_0 -u 0.003488952196240208 > ./result_8chains/node394_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_5_0 -p 763 -st none -pt topic394_5_0 -u 0.025903094154175493 > ./result_8chains/node394_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_6_0 -p 772 -st none -pt topic394_6_0 -u 0.025863199162171842 > ./result_8chains/node394_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_7_0 -p 881 -st none -pt topic394_7_0 -u 0.0036678847673301557 > ./result_8chains/node394_7_0.txt &
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
    "./result_8chains/node394_0_0.txt 90"
    "./result_8chains/node394_0_2.txt 90"
    "./result_8chains/node394_1_0.txt 89"
    "./result_8chains/node394_1_2.txt 89"
    "./result_8chains/node394_2_0.txt 88"
    "./result_8chains/node394_2_2.txt 88"
    "./result_8chains/node394_3_0.txt 87"
    "./result_8chains/node394_3_2.txt 87"
    "./result_8chains/node394_4_0.txt 86"
    "./result_8chains/node394_4_2.txt 86"
    "./result_8chains/node394_5_0.txt 85"
    "./result_8chains/node394_5_2.txt 85"
    "./result_8chains/node394_6_0.txt 84"
    "./result_8chains/node394_6_2.txt 84"
    "./result_8chains/node394_7_0.txt 83"
    "./result_8chains/node394_7_2.txt 83"
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
