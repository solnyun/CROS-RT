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
ros2 run evaluation_3_randomdag uunifast_node -n node113_0_2 -p 396 -st topic113_0_1 -pt None -u 0.01878724809517457 > ./result_6chains/node113_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_1_2 -p 507 -st topic113_1_1 -pt None -u 0.005197307945939478 > ./result_6chains/node113_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_2_2 -p 548 -st topic113_2_1 -pt None -u 0.012509978576201397 > ./result_6chains/node113_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_3_2 -p 755 -st topic113_3_1 -pt None -u 0.06140616231870499 > ./result_6chains/node113_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_4_2 -p 955 -st topic113_4_1 -pt None -u 0.0038103352195290874 > ./result_6chains/node113_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_5_2 -p 959 -st topic113_5_1 -pt None -u 0.03759885135193318 > ./result_6chains/node113_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_0_0 -p 396 -st none -pt topic113_0_0 -u 0.037065226248035266 > ./result_6chains/node113_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_1_0 -p 507 -st none -pt topic113_1_0 -u 0.003915695189507795 > ./result_6chains/node113_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_2_0 -p 548 -st none -pt topic113_2_0 -u 0.0362788299257808 > ./result_6chains/node113_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_3_0 -p 755 -st none -pt topic113_3_0 -u 0.016062953070231506 > ./result_6chains/node113_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node113_4_0 -p 955 -st none -pt topic113_4_0 -u 0.013258363781611687 > ./result_6chains/node113_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node113_5_0 -p 959 -st none -pt topic113_5_0 -u 0.009529452442881545 > ./result_6chains/node113_5_0.txt &
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
    "./result_6chains/node113_0_0.txt 90"
    "./result_6chains/node113_0_2.txt 90"
    "./result_6chains/node113_1_0.txt 89"
    "./result_6chains/node113_1_2.txt 89"
    "./result_6chains/node113_2_0.txt 88"
    "./result_6chains/node113_2_2.txt 88"
    "./result_6chains/node113_3_0.txt 87"
    "./result_6chains/node113_3_2.txt 87"
    "./result_6chains/node113_4_0.txt 86"
    "./result_6chains/node113_4_2.txt 86"
    "./result_6chains/node113_5_0.txt 85"
    "./result_6chains/node113_5_2.txt 85"
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
