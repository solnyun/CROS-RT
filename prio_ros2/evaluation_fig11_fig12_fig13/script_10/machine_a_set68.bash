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
ros2 run evaluation_3_randomdag uunifast_node -n node68_0_2 -p 44 -st topic68_0_1 -pt None -u 0.0019344501645314205 > ./result_10chains/node68_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_1_2 -p 109 -st topic68_1_1 -pt None -u 0.11426111604850203 > ./result_10chains/node68_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_2_2 -p 270 -st topic68_2_1 -pt None -u 0.009823819154232638 > ./result_10chains/node68_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_3_2 -p 431 -st topic68_3_1 -pt None -u 0.003864791519148536 > ./result_10chains/node68_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_4_2 -p 434 -st topic68_4_1 -pt None -u 0.0005872134009538565 > ./result_10chains/node68_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_5_2 -p 490 -st topic68_5_1 -pt None -u 0.0011253705867862729 > ./result_10chains/node68_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_6_2 -p 587 -st topic68_6_1 -pt None -u 0.005305149776731577 > ./result_10chains/node68_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_7_2 -p 605 -st topic68_7_1 -pt None -u 0.06473315882732406 > ./result_10chains/node68_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_8_2 -p 817 -st topic68_8_1 -pt None -u 0.0006404454244998171 > ./result_10chains/node68_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_9_2 -p 847 -st topic68_9_1 -pt None -u 0.010051441994761334 > ./result_10chains/node68_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_0_0 -p 44 -st none -pt topic68_0_0 -u 0.0002316950503500892 > ./result_10chains/node68_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_1_0 -p 109 -st none -pt topic68_1_0 -u 0.0118815553318663 > ./result_10chains/node68_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_2_0 -p 270 -st none -pt topic68_2_0 -u 0.031123150131296295 > ./result_10chains/node68_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_3_0 -p 431 -st none -pt topic68_3_0 -u 0.01715665761493118 > ./result_10chains/node68_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_4_0 -p 434 -st none -pt topic68_4_0 -u 0.004282220157581451 > ./result_10chains/node68_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_5_0 -p 490 -st none -pt topic68_5_0 -u 0.020237378048469062 > ./result_10chains/node68_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_6_0 -p 587 -st none -pt topic68_6_0 -u 0.030241914887536248 > ./result_10chains/node68_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_7_0 -p 605 -st none -pt topic68_7_0 -u 0.001723669604697442 > ./result_10chains/node68_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node68_8_0 -p 817 -st none -pt topic68_8_0 -u 0.023316472539565994 > ./result_10chains/node68_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node68_9_0 -p 847 -st none -pt topic68_9_0 -u 0.009671181157419308 > ./result_10chains/node68_9_0.txt &
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
    "./result_10chains/node68_0_0.txt 90"
    "./result_10chains/node68_0_2.txt 90"
    "./result_10chains/node68_1_0.txt 89"
    "./result_10chains/node68_1_2.txt 89"
    "./result_10chains/node68_2_0.txt 88"
    "./result_10chains/node68_2_2.txt 88"
    "./result_10chains/node68_3_0.txt 87"
    "./result_10chains/node68_3_2.txt 87"
    "./result_10chains/node68_4_0.txt 86"
    "./result_10chains/node68_4_2.txt 86"
    "./result_10chains/node68_5_0.txt 85"
    "./result_10chains/node68_5_2.txt 85"
    "./result_10chains/node68_6_0.txt 84"
    "./result_10chains/node68_6_2.txt 84"
    "./result_10chains/node68_7_0.txt 83"
    "./result_10chains/node68_7_2.txt 83"
    "./result_10chains/node68_8_0.txt 82"
    "./result_10chains/node68_8_2.txt 82"
    "./result_10chains/node68_9_0.txt 81"
    "./result_10chains/node68_9_2.txt 81"
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
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
