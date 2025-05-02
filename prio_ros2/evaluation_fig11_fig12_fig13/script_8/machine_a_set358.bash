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
ros2 run evaluation_3_randomdag uunifast_node -n node358_0_2 -p 76 -st topic358_0_1 -pt None -u 0.03686755364491662 > ./result_8chains/node358_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_1_2 -p 336 -st topic358_1_1 -pt None -u 0.016455562309425575 > ./result_8chains/node358_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_2_2 -p 436 -st topic358_2_1 -pt None -u 0.009049208841154677 > ./result_8chains/node358_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_3_2 -p 511 -st topic358_3_1 -pt None -u 0.007643407201054442 > ./result_8chains/node358_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_4_2 -p 557 -st topic358_4_1 -pt None -u 0.0340474846150029 > ./result_8chains/node358_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_5_2 -p 800 -st topic358_5_1 -pt None -u 0.021785902436070884 > ./result_8chains/node358_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_6_2 -p 839 -st topic358_6_1 -pt None -u 0.004968756989878267 > ./result_8chains/node358_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_7_2 -p 871 -st topic358_7_1 -pt None -u 0.01618138217596896 > ./result_8chains/node358_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_0_0 -p 76 -st none -pt topic358_0_0 -u 0.005916730488886468 > ./result_8chains/node358_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_1_0 -p 336 -st none -pt topic358_1_0 -u 0.008255193493927282 > ./result_8chains/node358_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_2_0 -p 436 -st none -pt topic358_2_0 -u 0.004516255809189018 > ./result_8chains/node358_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_3_0 -p 511 -st none -pt topic358_3_0 -u 0.09733395751130919 > ./result_8chains/node358_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_4_0 -p 557 -st none -pt topic358_4_0 -u 0.0022452591439059144 > ./result_8chains/node358_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_5_0 -p 800 -st none -pt topic358_5_0 -u 0.046085688674656594 > ./result_8chains/node358_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_6_0 -p 839 -st none -pt topic358_6_0 -u 0.009804648304176496 > ./result_8chains/node358_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_7_0 -p 871 -st none -pt topic358_7_0 -u 0.0063663256082109425 > ./result_8chains/node358_7_0.txt &
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
    "./result_8chains/node358_0_0.txt 90"
    "./result_8chains/node358_0_2.txt 90"
    "./result_8chains/node358_1_0.txt 89"
    "./result_8chains/node358_1_2.txt 89"
    "./result_8chains/node358_2_0.txt 88"
    "./result_8chains/node358_2_2.txt 88"
    "./result_8chains/node358_3_0.txt 87"
    "./result_8chains/node358_3_2.txt 87"
    "./result_8chains/node358_4_0.txt 86"
    "./result_8chains/node358_4_2.txt 86"
    "./result_8chains/node358_5_0.txt 85"
    "./result_8chains/node358_5_2.txt 85"
    "./result_8chains/node358_6_0.txt 84"
    "./result_8chains/node358_6_2.txt 84"
    "./result_8chains/node358_7_0.txt 83"
    "./result_8chains/node358_7_2.txt 83"
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
