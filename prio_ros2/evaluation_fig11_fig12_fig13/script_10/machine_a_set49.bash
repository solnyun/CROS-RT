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
ros2 run evaluation_3_randomdag uunifast_node -n node49_0_2 -p 23 -st topic49_0_1 -pt None -u 0.0110324276249405 > ./result_10chains/node49_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_1_2 -p 356 -st topic49_1_1 -pt None -u 0.020168720354150238 > ./result_10chains/node49_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_2_2 -p 368 -st topic49_2_1 -pt None -u 0.026607742641323817 > ./result_10chains/node49_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_3_2 -p 451 -st topic49_3_1 -pt None -u 0.0037015385154718916 > ./result_10chains/node49_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_4_2 -p 453 -st topic49_4_1 -pt None -u 0.027104398838639604 > ./result_10chains/node49_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_5_2 -p 721 -st topic49_5_1 -pt None -u 0.0010947433262854522 > ./result_10chains/node49_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_6_2 -p 732 -st topic49_6_1 -pt None -u 0.03740671885712181 > ./result_10chains/node49_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_7_2 -p 746 -st topic49_7_1 -pt None -u 0.004528628354896744 > ./result_10chains/node49_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_8_2 -p 944 -st topic49_8_1 -pt None -u 0.002094859207403703 > ./result_10chains/node49_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_9_2 -p 962 -st topic49_9_1 -pt None -u 0.018537932429705455 > ./result_10chains/node49_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_0_0 -p 23 -st none -pt topic49_0_0 -u 0.018315972177164075 > ./result_10chains/node49_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_1_0 -p 356 -st none -pt topic49_1_0 -u 0.0070775612641738594 > ./result_10chains/node49_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_2_0 -p 368 -st none -pt topic49_2_0 -u 0.01438930076036865 > ./result_10chains/node49_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_3_0 -p 451 -st none -pt topic49_3_0 -u 0.0065456974896911935 > ./result_10chains/node49_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_4_0 -p 453 -st none -pt topic49_4_0 -u 0.0013546616007333867 > ./result_10chains/node49_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_5_0 -p 721 -st none -pt topic49_5_0 -u 0.002001249970863206 > ./result_10chains/node49_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_6_0 -p 732 -st none -pt topic49_6_0 -u 0.019256445920414672 > ./result_10chains/node49_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_7_0 -p 746 -st none -pt topic49_7_0 -u 0.0036191382493979823 > ./result_10chains/node49_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node49_8_0 -p 944 -st none -pt topic49_8_0 -u 0.005278338943124107 > ./result_10chains/node49_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node49_9_0 -p 962 -st none -pt topic49_9_0 -u 0.011104358167668797 > ./result_10chains/node49_9_0.txt &
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
    "./result_10chains/node49_0_0.txt 90"
    "./result_10chains/node49_0_2.txt 90"
    "./result_10chains/node49_1_0.txt 89"
    "./result_10chains/node49_1_2.txt 89"
    "./result_10chains/node49_2_0.txt 88"
    "./result_10chains/node49_2_2.txt 88"
    "./result_10chains/node49_3_0.txt 87"
    "./result_10chains/node49_3_2.txt 87"
    "./result_10chains/node49_4_0.txt 86"
    "./result_10chains/node49_4_2.txt 86"
    "./result_10chains/node49_5_0.txt 85"
    "./result_10chains/node49_5_2.txt 85"
    "./result_10chains/node49_6_0.txt 84"
    "./result_10chains/node49_6_2.txt 84"
    "./result_10chains/node49_7_0.txt 83"
    "./result_10chains/node49_7_2.txt 83"
    "./result_10chains/node49_8_0.txt 82"
    "./result_10chains/node49_8_2.txt 82"
    "./result_10chains/node49_9_0.txt 81"
    "./result_10chains/node49_9_2.txt 81"
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
