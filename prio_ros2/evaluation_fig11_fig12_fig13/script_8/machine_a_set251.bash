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
ros2 run evaluation_3_randomdag uunifast_node -n node251_0_2 -p 250 -st topic251_0_1 -pt None -u 0.026822479063513205 > ./result_8chains/node251_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_1_2 -p 360 -st topic251_1_1 -pt None -u 0.031758958706463225 > ./result_8chains/node251_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_2_2 -p 490 -st topic251_2_1 -pt None -u 0.004459583080592133 > ./result_8chains/node251_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_3_2 -p 552 -st topic251_3_1 -pt None -u 0.024710414036178574 > ./result_8chains/node251_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_4_2 -p 642 -st topic251_4_1 -pt None -u 0.010892005917714803 > ./result_8chains/node251_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_5_2 -p 769 -st topic251_5_1 -pt None -u 0.020955068707592756 > ./result_8chains/node251_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_6_2 -p 813 -st topic251_6_1 -pt None -u 0.026230449995433336 > ./result_8chains/node251_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_7_2 -p 830 -st topic251_7_1 -pt None -u 0.01943613761321232 > ./result_8chains/node251_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_0_0 -p 250 -st none -pt topic251_0_0 -u 0.006526476970956652 > ./result_8chains/node251_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_1_0 -p 360 -st none -pt topic251_1_0 -u 0.016900957928702776 > ./result_8chains/node251_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_2_0 -p 490 -st none -pt topic251_2_0 -u 0.0016424541943755866 > ./result_8chains/node251_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_3_0 -p 552 -st none -pt topic251_3_0 -u 0.0029170042211400515 > ./result_8chains/node251_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_4_0 -p 642 -st none -pt topic251_4_0 -u 0.000964244844007478 > ./result_8chains/node251_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_5_0 -p 769 -st none -pt topic251_5_0 -u 0.017727725780107506 > ./result_8chains/node251_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_6_0 -p 813 -st none -pt topic251_6_0 -u 0.030103789651823504 > ./result_8chains/node251_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_7_0 -p 830 -st none -pt topic251_7_0 -u 0.08360119058234883 > ./result_8chains/node251_7_0.txt &
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
    "./result_8chains/node251_0_0.txt 90"
    "./result_8chains/node251_0_2.txt 90"
    "./result_8chains/node251_1_0.txt 89"
    "./result_8chains/node251_1_2.txt 89"
    "./result_8chains/node251_2_0.txt 88"
    "./result_8chains/node251_2_2.txt 88"
    "./result_8chains/node251_3_0.txt 87"
    "./result_8chains/node251_3_2.txt 87"
    "./result_8chains/node251_4_0.txt 86"
    "./result_8chains/node251_4_2.txt 86"
    "./result_8chains/node251_5_0.txt 85"
    "./result_8chains/node251_5_2.txt 85"
    "./result_8chains/node251_6_0.txt 84"
    "./result_8chains/node251_6_2.txt 84"
    "./result_8chains/node251_7_0.txt 83"
    "./result_8chains/node251_7_2.txt 83"
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
