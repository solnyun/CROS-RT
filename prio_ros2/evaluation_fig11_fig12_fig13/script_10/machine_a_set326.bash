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
ros2 run evaluation_3_randomdag uunifast_node -n node326_0_2 -p 34 -st topic326_0_1 -pt None -u 0.009027843834239768 > ./result_10chains/node326_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_1_2 -p 81 -st topic326_1_1 -pt None -u 0.01554573807413312 > ./result_10chains/node326_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_2_2 -p 95 -st topic326_2_1 -pt None -u 0.02985235707004169 > ./result_10chains/node326_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_3_2 -p 336 -st topic326_3_1 -pt None -u 0.005789598434092547 > ./result_10chains/node326_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_4_2 -p 468 -st topic326_4_1 -pt None -u 0.013624834479777165 > ./result_10chains/node326_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_5_2 -p 494 -st topic326_5_1 -pt None -u 0.013721752178168456 > ./result_10chains/node326_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_6_2 -p 614 -st topic326_6_1 -pt None -u 0.014573060281682315 > ./result_10chains/node326_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_7_2 -p 671 -st topic326_7_1 -pt None -u 0.006962000901627796 > ./result_10chains/node326_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_8_2 -p 802 -st topic326_8_1 -pt None -u 0.017613098821341634 > ./result_10chains/node326_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_9_2 -p 854 -st topic326_9_1 -pt None -u 0.00677142728587381 > ./result_10chains/node326_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_0_0 -p 34 -st none -pt topic326_0_0 -u 0.0005290006848228113 > ./result_10chains/node326_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_1_0 -p 81 -st none -pt topic326_1_0 -u 0.01787693817248337 > ./result_10chains/node326_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_2_0 -p 95 -st none -pt topic326_2_0 -u 0.05351694578462679 > ./result_10chains/node326_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_3_0 -p 336 -st none -pt topic326_3_0 -u 0.04093361246316379 > ./result_10chains/node326_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_4_0 -p 468 -st none -pt topic326_4_0 -u 0.005155358672435828 > ./result_10chains/node326_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_5_0 -p 494 -st none -pt topic326_5_0 -u 0.03556204874938973 > ./result_10chains/node326_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_6_0 -p 614 -st none -pt topic326_6_0 -u 0.01296961677248179 > ./result_10chains/node326_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_7_0 -p 671 -st none -pt topic326_7_0 -u 0.0671177867757628 > ./result_10chains/node326_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_8_0 -p 802 -st none -pt topic326_8_0 -u 0.03178062734723368 > ./result_10chains/node326_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node326_9_0 -p 854 -st none -pt topic326_9_0 -u 0.001323390392492487 > ./result_10chains/node326_9_0.txt &
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
    "./result_10chains/node326_0_0.txt 90"
    "./result_10chains/node326_0_2.txt 90"
    "./result_10chains/node326_1_0.txt 89"
    "./result_10chains/node326_1_2.txt 89"
    "./result_10chains/node326_2_0.txt 88"
    "./result_10chains/node326_2_2.txt 88"
    "./result_10chains/node326_3_0.txt 87"
    "./result_10chains/node326_3_2.txt 87"
    "./result_10chains/node326_4_0.txt 86"
    "./result_10chains/node326_4_2.txt 86"
    "./result_10chains/node326_5_0.txt 85"
    "./result_10chains/node326_5_2.txt 85"
    "./result_10chains/node326_6_0.txt 84"
    "./result_10chains/node326_6_2.txt 84"
    "./result_10chains/node326_7_0.txt 83"
    "./result_10chains/node326_7_2.txt 83"
    "./result_10chains/node326_8_0.txt 82"
    "./result_10chains/node326_8_2.txt 82"
    "./result_10chains/node326_9_0.txt 81"
    "./result_10chains/node326_9_2.txt 81"
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
