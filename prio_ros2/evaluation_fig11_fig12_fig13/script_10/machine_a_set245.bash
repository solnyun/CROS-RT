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
ros2 run evaluation_3_randomdag uunifast_node -n node245_0_2 -p 47 -st topic245_0_1 -pt None -u 0.01663411988745722 > ./result_10chains/node245_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_1_2 -p 88 -st topic245_1_1 -pt None -u 0.0022140935577104615 > ./result_10chains/node245_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_2_2 -p 192 -st topic245_2_1 -pt None -u 0.001494817486935529 > ./result_10chains/node245_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_3_2 -p 388 -st topic245_3_1 -pt None -u 0.0015786156931217321 > ./result_10chains/node245_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_4_2 -p 424 -st topic245_4_1 -pt None -u 0.002791850699791709 > ./result_10chains/node245_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_5_2 -p 547 -st topic245_5_1 -pt None -u 0.01454317427541707 > ./result_10chains/node245_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_6_2 -p 651 -st topic245_6_1 -pt None -u 0.010818398906472765 > ./result_10chains/node245_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_7_2 -p 804 -st topic245_7_1 -pt None -u 0.018358282933880976 > ./result_10chains/node245_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_8_2 -p 916 -st topic245_8_1 -pt None -u 0.07754044008915094 > ./result_10chains/node245_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_9_2 -p 917 -st topic245_9_1 -pt None -u 0.00038256388380878456 > ./result_10chains/node245_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_0_0 -p 47 -st none -pt topic245_0_0 -u 0.0008151051572015122 > ./result_10chains/node245_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_1_0 -p 88 -st none -pt topic245_1_0 -u 0.013311740641691716 > ./result_10chains/node245_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_2_0 -p 192 -st none -pt topic245_2_0 -u 0.009428809355363665 > ./result_10chains/node245_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_3_0 -p 388 -st none -pt topic245_3_0 -u 0.030894762525278063 > ./result_10chains/node245_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_4_0 -p 424 -st none -pt topic245_4_0 -u 0.007855505873237856 > ./result_10chains/node245_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_5_0 -p 547 -st none -pt topic245_5_0 -u 0.006439853816737284 > ./result_10chains/node245_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_6_0 -p 651 -st none -pt topic245_6_0 -u 0.03474781401496019 > ./result_10chains/node245_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_7_0 -p 804 -st none -pt topic245_7_0 -u 0.0011804938650788188 > ./result_10chains/node245_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_8_0 -p 916 -st none -pt topic245_8_0 -u 0.0021548944762319056 > ./result_10chains/node245_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_9_0 -p 917 -st none -pt topic245_9_0 -u 0.03215107293405457 > ./result_10chains/node245_9_0.txt &
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
    "./result_10chains/node245_0_0.txt 90"
    "./result_10chains/node245_0_2.txt 90"
    "./result_10chains/node245_1_0.txt 89"
    "./result_10chains/node245_1_2.txt 89"
    "./result_10chains/node245_2_0.txt 88"
    "./result_10chains/node245_2_2.txt 88"
    "./result_10chains/node245_3_0.txt 87"
    "./result_10chains/node245_3_2.txt 87"
    "./result_10chains/node245_4_0.txt 86"
    "./result_10chains/node245_4_2.txt 86"
    "./result_10chains/node245_5_0.txt 85"
    "./result_10chains/node245_5_2.txt 85"
    "./result_10chains/node245_6_0.txt 84"
    "./result_10chains/node245_6_2.txt 84"
    "./result_10chains/node245_7_0.txt 83"
    "./result_10chains/node245_7_2.txt 83"
    "./result_10chains/node245_8_0.txt 82"
    "./result_10chains/node245_8_2.txt 82"
    "./result_10chains/node245_9_0.txt 81"
    "./result_10chains/node245_9_2.txt 81"
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
