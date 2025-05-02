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
ros2 run evaluation_3_randomdag uunifast_node -n node462_0_2 -p 58 -st topic462_0_1 -pt None -u 0.009461249108098813 > ./result_8chains/node462_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_1_2 -p 173 -st topic462_1_1 -pt None -u 0.007622301324660075 > ./result_8chains/node462_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_2_2 -p 426 -st topic462_2_1 -pt None -u 0.009222402987412559 > ./result_8chains/node462_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_3_2 -p 606 -st topic462_3_1 -pt None -u 0.00044491090400361477 > ./result_8chains/node462_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_4_2 -p 774 -st topic462_4_1 -pt None -u 0.024059986849033432 > ./result_8chains/node462_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_5_2 -p 841 -st topic462_5_1 -pt None -u 0.02225821095746111 > ./result_8chains/node462_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_6_2 -p 945 -st topic462_6_1 -pt None -u 0.014496876395552208 > ./result_8chains/node462_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_7_2 -p 976 -st topic462_7_1 -pt None -u 0.010432510164881092 > ./result_8chains/node462_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_0_0 -p 58 -st none -pt topic462_0_0 -u 0.008203315042858983 > ./result_8chains/node462_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_1_0 -p 173 -st none -pt topic462_1_0 -u 0.00953549885537952 > ./result_8chains/node462_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_2_0 -p 426 -st none -pt topic462_2_0 -u 0.005939201834704699 > ./result_8chains/node462_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_3_0 -p 606 -st none -pt topic462_3_0 -u 0.044541370066330355 > ./result_8chains/node462_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_4_0 -p 774 -st none -pt topic462_4_0 -u 0.010143140327204758 > ./result_8chains/node462_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_5_0 -p 841 -st none -pt topic462_5_0 -u 0.03287433218681862 > ./result_8chains/node462_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node462_6_0 -p 945 -st none -pt topic462_6_0 -u 0.02159044288018991 > ./result_8chains/node462_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node462_7_0 -p 976 -st none -pt topic462_7_0 -u 0.007600291730205017 > ./result_8chains/node462_7_0.txt &
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
    "./result_8chains/node462_0_0.txt 90"
    "./result_8chains/node462_0_2.txt 90"
    "./result_8chains/node462_1_0.txt 89"
    "./result_8chains/node462_1_2.txt 89"
    "./result_8chains/node462_2_0.txt 88"
    "./result_8chains/node462_2_2.txt 88"
    "./result_8chains/node462_3_0.txt 87"
    "./result_8chains/node462_3_2.txt 87"
    "./result_8chains/node462_4_0.txt 86"
    "./result_8chains/node462_4_2.txt 86"
    "./result_8chains/node462_5_0.txt 85"
    "./result_8chains/node462_5_2.txt 85"
    "./result_8chains/node462_6_0.txt 84"
    "./result_8chains/node462_6_2.txt 84"
    "./result_8chains/node462_7_0.txt 83"
    "./result_8chains/node462_7_2.txt 83"
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
