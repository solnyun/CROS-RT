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
ros2 run evaluation_3_randomdag uunifast_node -n node380_0_2 -p 237 -st topic380_0_1 -pt None -u 0.027014453571600427 > ./result_8chains/node380_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_1_2 -p 454 -st topic380_1_1 -pt None -u 0.0020864064482369327 > ./result_8chains/node380_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_2_2 -p 455 -st topic380_2_1 -pt None -u 0.008160672915962841 > ./result_8chains/node380_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_3_2 -p 554 -st topic380_3_1 -pt None -u 0.011747921337826595 > ./result_8chains/node380_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_4_2 -p 653 -st topic380_4_1 -pt None -u 0.01269152651858732 > ./result_8chains/node380_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_5_2 -p 861 -st topic380_5_1 -pt None -u 0.003445050095063379 > ./result_8chains/node380_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_6_2 -p 886 -st topic380_6_1 -pt None -u 0.028585144296937755 > ./result_8chains/node380_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_7_2 -p 968 -st topic380_7_1 -pt None -u 0.02069395096918625 > ./result_8chains/node380_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_0_0 -p 237 -st none -pt topic380_0_0 -u 0.037850428702603967 > ./result_8chains/node380_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_1_0 -p 454 -st none -pt topic380_1_0 -u 0.03284866316693685 > ./result_8chains/node380_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_2_0 -p 455 -st none -pt topic380_2_0 -u 0.07449567143091396 > ./result_8chains/node380_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_3_0 -p 554 -st none -pt topic380_3_0 -u 0.01791102665950517 > ./result_8chains/node380_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_4_0 -p 653 -st none -pt topic380_4_0 -u 0.04875787587712252 > ./result_8chains/node380_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_5_0 -p 861 -st none -pt topic380_5_0 -u 0.01677602406479195 > ./result_8chains/node380_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node380_6_0 -p 886 -st none -pt topic380_6_0 -u 0.018972166229758884 > ./result_8chains/node380_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node380_7_0 -p 968 -st none -pt topic380_7_0 -u 0.00232354837766751 > ./result_8chains/node380_7_0.txt &
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
    "./result_8chains/node380_0_0.txt 90"
    "./result_8chains/node380_0_2.txt 90"
    "./result_8chains/node380_1_0.txt 89"
    "./result_8chains/node380_1_2.txt 89"
    "./result_8chains/node380_2_0.txt 88"
    "./result_8chains/node380_2_2.txt 88"
    "./result_8chains/node380_3_0.txt 87"
    "./result_8chains/node380_3_2.txt 87"
    "./result_8chains/node380_4_0.txt 86"
    "./result_8chains/node380_4_2.txt 86"
    "./result_8chains/node380_5_0.txt 85"
    "./result_8chains/node380_5_2.txt 85"
    "./result_8chains/node380_6_0.txt 84"
    "./result_8chains/node380_6_2.txt 84"
    "./result_8chains/node380_7_0.txt 83"
    "./result_8chains/node380_7_2.txt 83"
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
