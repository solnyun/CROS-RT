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
ros2 run evaluation_3_randomdag uunifast_node -n node25_0_2 -p 21 -st topic25_0_1 -pt None -u 0.04468490612516757 > ./result_10chains/node25_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_1_2 -p 104 -st topic25_1_1 -pt None -u 0.050747592816001164 > ./result_10chains/node25_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_2_2 -p 246 -st topic25_2_1 -pt None -u 0.0032384916473807146 > ./result_10chains/node25_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_3_2 -p 275 -st topic25_3_1 -pt None -u 0.01355280645789736 > ./result_10chains/node25_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_4_2 -p 474 -st topic25_4_1 -pt None -u 0.022446751713714547 > ./result_10chains/node25_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_5_2 -p 558 -st topic25_5_1 -pt None -u 0.003738748847015319 > ./result_10chains/node25_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_6_2 -p 724 -st topic25_6_1 -pt None -u 0.0108604039778228 > ./result_10chains/node25_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_7_2 -p 769 -st topic25_7_1 -pt None -u 0.02921167927893943 > ./result_10chains/node25_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_8_2 -p 935 -st topic25_8_1 -pt None -u 0.015156887106555003 > ./result_10chains/node25_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_9_2 -p 963 -st topic25_9_1 -pt None -u 0.0022875266600909756 > ./result_10chains/node25_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_0_0 -p 21 -st none -pt topic25_0_0 -u 0.0188646413228849 > ./result_10chains/node25_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_1_0 -p 104 -st none -pt topic25_1_0 -u 0.02806188621028982 > ./result_10chains/node25_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_2_0 -p 246 -st none -pt topic25_2_0 -u 0.0008024399491728396 > ./result_10chains/node25_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_3_0 -p 275 -st none -pt topic25_3_0 -u 0.037229161048682125 > ./result_10chains/node25_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_4_0 -p 474 -st none -pt topic25_4_0 -u 0.001924245001586472 > ./result_10chains/node25_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_5_0 -p 558 -st none -pt topic25_5_0 -u 0.003692189081786257 > ./result_10chains/node25_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_6_0 -p 724 -st none -pt topic25_6_0 -u 0.012788162849246859 > ./result_10chains/node25_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_7_0 -p 769 -st none -pt topic25_7_0 -u 0.005631154096932892 > ./result_10chains/node25_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node25_8_0 -p 935 -st none -pt topic25_8_0 -u 0.008387088076744716 > ./result_10chains/node25_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node25_9_0 -p 963 -st none -pt topic25_9_0 -u 0.006898464338212455 > ./result_10chains/node25_9_0.txt &
sleep 10
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
    "./result_10chains/node25_0_0.txt 90"
    "./result_10chains/node25_0_2.txt 90"
    "./result_10chains/node25_1_0.txt 89"
    "./result_10chains/node25_1_2.txt 89"
    "./result_10chains/node25_2_0.txt 88"
    "./result_10chains/node25_2_2.txt 88"
    "./result_10chains/node25_3_0.txt 87"
    "./result_10chains/node25_3_2.txt 87"
    "./result_10chains/node25_4_0.txt 86"
    "./result_10chains/node25_4_2.txt 86"
    "./result_10chains/node25_5_0.txt 85"
    "./result_10chains/node25_5_2.txt 85"
    "./result_10chains/node25_6_0.txt 84"
    "./result_10chains/node25_6_2.txt 84"
    "./result_10chains/node25_7_0.txt 83"
    "./result_10chains/node25_7_2.txt 83"
    "./result_10chains/node25_8_0.txt 82"
    "./result_10chains/node25_8_2.txt 82"
    "./result_10chains/node25_9_0.txt 81"
    "./result_10chains/node25_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
