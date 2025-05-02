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
ros2 run evaluation_3_randomdag uunifast_node -n node483_0_2 -p 174 -st topic483_0_1 -pt None -u 0.024846100317806485 > ./result_6chains/node483_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_1_2 -p 241 -st topic483_1_1 -pt None -u 0.06265366689270119 > ./result_6chains/node483_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_2_2 -p 325 -st topic483_2_1 -pt None -u 0.016409780217997216 > ./result_6chains/node483_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_3_2 -p 360 -st topic483_3_1 -pt None -u 0.08248945952728115 > ./result_6chains/node483_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_4_2 -p 562 -st topic483_4_1 -pt None -u 0.04288267872504348 > ./result_6chains/node483_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_5_2 -p 850 -st topic483_5_1 -pt None -u 0.005561554329460252 > ./result_6chains/node483_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_0_0 -p 174 -st none -pt topic483_0_0 -u 0.004506098530798419 > ./result_6chains/node483_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_1_0 -p 241 -st none -pt topic483_1_0 -u 0.016529757786891808 > ./result_6chains/node483_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_2_0 -p 325 -st none -pt topic483_2_0 -u 0.025497445234577698 > ./result_6chains/node483_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_3_0 -p 360 -st none -pt topic483_3_0 -u 0.03604385823612777 > ./result_6chains/node483_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_4_0 -p 562 -st none -pt topic483_4_0 -u 0.01058220300945828 > ./result_6chains/node483_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_5_0 -p 850 -st none -pt topic483_5_0 -u 0.07625348335594237 > ./result_6chains/node483_5_0.txt &
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
    "./result_6chains/node483_0_0.txt 90"
    "./result_6chains/node483_0_2.txt 90"
    "./result_6chains/node483_1_0.txt 89"
    "./result_6chains/node483_1_2.txt 89"
    "./result_6chains/node483_2_0.txt 88"
    "./result_6chains/node483_2_2.txt 88"
    "./result_6chains/node483_3_0.txt 87"
    "./result_6chains/node483_3_2.txt 87"
    "./result_6chains/node483_4_0.txt 86"
    "./result_6chains/node483_4_2.txt 86"
    "./result_6chains/node483_5_0.txt 85"
    "./result_6chains/node483_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
