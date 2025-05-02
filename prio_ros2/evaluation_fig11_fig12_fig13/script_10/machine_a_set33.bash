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
ros2 run evaluation_3_randomdag uunifast_node -n node33_0_2 -p 195 -st topic33_0_1 -pt None -u 0.017440524800507673 > ./result_10chains/node33_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_1_2 -p 204 -st topic33_1_1 -pt None -u 0.07303269910559185 > ./result_10chains/node33_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_2_2 -p 231 -st topic33_2_1 -pt None -u 0.010828881382125566 > ./result_10chains/node33_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_3_2 -p 232 -st topic33_3_1 -pt None -u 0.04185318683609482 > ./result_10chains/node33_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_4_2 -p 377 -st topic33_4_1 -pt None -u 0.00510660103019428 > ./result_10chains/node33_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_5_2 -p 507 -st topic33_5_1 -pt None -u 0.016526498468501627 > ./result_10chains/node33_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_6_2 -p 556 -st topic33_6_1 -pt None -u 0.03174973036776249 > ./result_10chains/node33_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_7_2 -p 750 -st topic33_7_1 -pt None -u 0.030888591202408694 > ./result_10chains/node33_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_8_2 -p 895 -st topic33_8_1 -pt None -u 0.02653016627054179 > ./result_10chains/node33_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_9_2 -p 943 -st topic33_9_1 -pt None -u 0.026199192977940156 > ./result_10chains/node33_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_0_0 -p 195 -st none -pt topic33_0_0 -u 0.002040749871989045 > ./result_10chains/node33_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_1_0 -p 204 -st none -pt topic33_1_0 -u 0.02794576584213382 > ./result_10chains/node33_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_2_0 -p 231 -st none -pt topic33_2_0 -u 0.03491139341429311 > ./result_10chains/node33_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_3_0 -p 232 -st none -pt topic33_3_0 -u 0.0020210224296554613 > ./result_10chains/node33_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_4_0 -p 377 -st none -pt topic33_4_0 -u 0.004070824576179216 > ./result_10chains/node33_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_5_0 -p 507 -st none -pt topic33_5_0 -u 0.003510030502958228 > ./result_10chains/node33_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_6_0 -p 556 -st none -pt topic33_6_0 -u 0.010088603878784574 > ./result_10chains/node33_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_7_0 -p 750 -st none -pt topic33_7_0 -u 0.001090418229722695 > ./result_10chains/node33_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node33_8_0 -p 895 -st none -pt topic33_8_0 -u 0.0012794240589434763 > ./result_10chains/node33_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node33_9_0 -p 943 -st none -pt topic33_9_0 -u 0.00036884226352131705 > ./result_10chains/node33_9_0.txt &
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
    "./result_10chains/node33_0_0.txt 90"
    "./result_10chains/node33_0_2.txt 90"
    "./result_10chains/node33_1_0.txt 89"
    "./result_10chains/node33_1_2.txt 89"
    "./result_10chains/node33_2_0.txt 88"
    "./result_10chains/node33_2_2.txt 88"
    "./result_10chains/node33_3_0.txt 87"
    "./result_10chains/node33_3_2.txt 87"
    "./result_10chains/node33_4_0.txt 86"
    "./result_10chains/node33_4_2.txt 86"
    "./result_10chains/node33_5_0.txt 85"
    "./result_10chains/node33_5_2.txt 85"
    "./result_10chains/node33_6_0.txt 84"
    "./result_10chains/node33_6_2.txt 84"
    "./result_10chains/node33_7_0.txt 83"
    "./result_10chains/node33_7_2.txt 83"
    "./result_10chains/node33_8_0.txt 82"
    "./result_10chains/node33_8_2.txt 82"
    "./result_10chains/node33_9_0.txt 81"
    "./result_10chains/node33_9_2.txt 81"
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
