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
ros2 run evaluation_3_randomdag uunifast_node -n node162_0_2 -p 99 -st topic162_0_1 -pt None -u 0.040001622947889726 > ./result_8chains/node162_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_1_2 -p 433 -st topic162_1_1 -pt None -u 0.02046513499709879 > ./result_8chains/node162_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_2_2 -p 557 -st topic162_2_1 -pt None -u 0.009471878083254281 > ./result_8chains/node162_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_3_2 -p 636 -st topic162_3_1 -pt None -u 0.04353373092111851 > ./result_8chains/node162_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_4_2 -p 812 -st topic162_4_1 -pt None -u 0.0003246593951226895 > ./result_8chains/node162_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_5_2 -p 824 -st topic162_5_1 -pt None -u 0.025219439770469573 > ./result_8chains/node162_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_6_2 -p 841 -st topic162_6_1 -pt None -u 0.013097120447930148 > ./result_8chains/node162_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_7_2 -p 932 -st topic162_7_1 -pt None -u 0.01268415532166747 > ./result_8chains/node162_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_0_0 -p 99 -st none -pt topic162_0_0 -u 0.044092484207951144 > ./result_8chains/node162_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_1_0 -p 433 -st none -pt topic162_1_0 -u 0.0013870174177029182 > ./result_8chains/node162_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_2_0 -p 557 -st none -pt topic162_2_0 -u 0.0060944468761202075 > ./result_8chains/node162_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_3_0 -p 636 -st none -pt topic162_3_0 -u 0.04779072846162641 > ./result_8chains/node162_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_4_0 -p 812 -st none -pt topic162_4_0 -u 0.027135905762422946 > ./result_8chains/node162_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_5_0 -p 824 -st none -pt topic162_5_0 -u 0.0007853943587839418 > ./result_8chains/node162_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_6_0 -p 841 -st none -pt topic162_6_0 -u 0.03322273202511193 > ./result_8chains/node162_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_7_0 -p 932 -st none -pt topic162_7_0 -u 0.0357674378566611 > ./result_8chains/node162_7_0.txt &
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
    "./result_8chains/node162_0_0.txt 90"
    "./result_8chains/node162_0_2.txt 90"
    "./result_8chains/node162_1_0.txt 89"
    "./result_8chains/node162_1_2.txt 89"
    "./result_8chains/node162_2_0.txt 88"
    "./result_8chains/node162_2_2.txt 88"
    "./result_8chains/node162_3_0.txt 87"
    "./result_8chains/node162_3_2.txt 87"
    "./result_8chains/node162_4_0.txt 86"
    "./result_8chains/node162_4_2.txt 86"
    "./result_8chains/node162_5_0.txt 85"
    "./result_8chains/node162_5_2.txt 85"
    "./result_8chains/node162_6_0.txt 84"
    "./result_8chains/node162_6_2.txt 84"
    "./result_8chains/node162_7_0.txt 83"
    "./result_8chains/node162_7_2.txt 83"
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
