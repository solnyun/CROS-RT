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
ros2 run evaluation_3_randomdag uunifast_node -n node162_0_2 -p 59 -st topic162_0_1 -pt None -u 0.0032788125922597056 > ./result_10chains/node162_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_1_2 -p 92 -st topic162_1_1 -pt None -u 0.009531401415329377 > ./result_10chains/node162_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_2_2 -p 126 -st topic162_2_1 -pt None -u 0.01131912358695153 > ./result_10chains/node162_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_3_2 -p 261 -st topic162_3_1 -pt None -u 0.029678636034423833 > ./result_10chains/node162_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_4_2 -p 395 -st topic162_4_1 -pt None -u 0.013162595646946496 > ./result_10chains/node162_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_5_2 -p 516 -st topic162_5_1 -pt None -u 0.000666410785979149 > ./result_10chains/node162_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_6_2 -p 530 -st topic162_6_1 -pt None -u 0.01340717320953591 > ./result_10chains/node162_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_7_2 -p 567 -st topic162_7_1 -pt None -u 0.006040955329211409 > ./result_10chains/node162_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_8_2 -p 732 -st topic162_8_1 -pt None -u 0.00024063091550878546 > ./result_10chains/node162_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_9_2 -p 851 -st topic162_9_1 -pt None -u 0.010664271607726403 > ./result_10chains/node162_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_0_0 -p 59 -st none -pt topic162_0_0 -u 0.008266384796601911 > ./result_10chains/node162_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_1_0 -p 92 -st none -pt topic162_1_0 -u 0.01192895744906941 > ./result_10chains/node162_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_2_0 -p 126 -st none -pt topic162_2_0 -u 0.008996157118324355 > ./result_10chains/node162_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_3_0 -p 261 -st none -pt topic162_3_0 -u 0.0026924752840516986 > ./result_10chains/node162_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_4_0 -p 395 -st none -pt topic162_4_0 -u 0.0034258113173321614 > ./result_10chains/node162_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_5_0 -p 516 -st none -pt topic162_5_0 -u 0.040876560229826775 > ./result_10chains/node162_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_6_0 -p 530 -st none -pt topic162_6_0 -u 0.023030439468267133 > ./result_10chains/node162_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_7_0 -p 567 -st none -pt topic162_7_0 -u 0.05965857889065211 > ./result_10chains/node162_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_8_0 -p 732 -st none -pt topic162_8_0 -u 0.0015796250152121105 > ./result_10chains/node162_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_9_0 -p 851 -st none -pt topic162_9_0 -u 0.016461473643283236 > ./result_10chains/node162_9_0.txt &
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
    "./result_10chains/node162_0_0.txt 90"
    "./result_10chains/node162_0_2.txt 90"
    "./result_10chains/node162_1_0.txt 89"
    "./result_10chains/node162_1_2.txt 89"
    "./result_10chains/node162_2_0.txt 88"
    "./result_10chains/node162_2_2.txt 88"
    "./result_10chains/node162_3_0.txt 87"
    "./result_10chains/node162_3_2.txt 87"
    "./result_10chains/node162_4_0.txt 86"
    "./result_10chains/node162_4_2.txt 86"
    "./result_10chains/node162_5_0.txt 85"
    "./result_10chains/node162_5_2.txt 85"
    "./result_10chains/node162_6_0.txt 84"
    "./result_10chains/node162_6_2.txt 84"
    "./result_10chains/node162_7_0.txt 83"
    "./result_10chains/node162_7_2.txt 83"
    "./result_10chains/node162_8_0.txt 82"
    "./result_10chains/node162_8_2.txt 82"
    "./result_10chains/node162_9_0.txt 81"
    "./result_10chains/node162_9_2.txt 81"
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
