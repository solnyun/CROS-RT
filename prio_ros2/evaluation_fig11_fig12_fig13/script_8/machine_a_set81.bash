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
ros2 run evaluation_3_randomdag uunifast_node -n node81_0_2 -p 205 -st topic81_0_1 -pt None -u 0.0561860810249144 > ./result_8chains/node81_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_1_2 -p 207 -st topic81_1_1 -pt None -u 0.0012469479219108792 > ./result_8chains/node81_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_2_2 -p 352 -st topic81_2_1 -pt None -u 0.019788856534073973 > ./result_8chains/node81_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_3_2 -p 501 -st topic81_3_1 -pt None -u 0.03337953632055646 > ./result_8chains/node81_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_4_2 -p 816 -st topic81_4_1 -pt None -u 0.011229025160951589 > ./result_8chains/node81_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_5_2 -p 861 -st topic81_5_1 -pt None -u 0.026493041788955868 > ./result_8chains/node81_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_6_2 -p 867 -st topic81_6_1 -pt None -u 0.020619896167916013 > ./result_8chains/node81_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_7_2 -p 988 -st topic81_7_1 -pt None -u 0.009542217366433573 > ./result_8chains/node81_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_0_0 -p 205 -st none -pt topic81_0_0 -u 0.03768641164236913 > ./result_8chains/node81_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_1_0 -p 207 -st none -pt topic81_1_0 -u 0.0008714701940804592 > ./result_8chains/node81_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_2_0 -p 352 -st none -pt topic81_2_0 -u 0.0598927891315118 > ./result_8chains/node81_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_3_0 -p 501 -st none -pt topic81_3_0 -u 0.03382409453891094 > ./result_8chains/node81_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_4_0 -p 816 -st none -pt topic81_4_0 -u 0.008297884563476216 > ./result_8chains/node81_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_5_0 -p 861 -st none -pt topic81_5_0 -u 0.011961316797369448 > ./result_8chains/node81_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node81_6_0 -p 867 -st none -pt topic81_6_0 -u 0.04419976406369408 > ./result_8chains/node81_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node81_7_0 -p 988 -st none -pt topic81_7_0 -u 0.01816727957586633 > ./result_8chains/node81_7_0.txt &
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
    "./result_8chains/node81_0_0.txt 90"
    "./result_8chains/node81_0_2.txt 90"
    "./result_8chains/node81_1_0.txt 89"
    "./result_8chains/node81_1_2.txt 89"
    "./result_8chains/node81_2_0.txt 88"
    "./result_8chains/node81_2_2.txt 88"
    "./result_8chains/node81_3_0.txt 87"
    "./result_8chains/node81_3_2.txt 87"
    "./result_8chains/node81_4_0.txt 86"
    "./result_8chains/node81_4_2.txt 86"
    "./result_8chains/node81_5_0.txt 85"
    "./result_8chains/node81_5_2.txt 85"
    "./result_8chains/node81_6_0.txt 84"
    "./result_8chains/node81_6_2.txt 84"
    "./result_8chains/node81_7_0.txt 83"
    "./result_8chains/node81_7_2.txt 83"
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
