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
ros2 run evaluation_3_randomdag uunifast_node -n node13_0_2 -p 65 -st topic13_0_1 -pt None -u 0.01625363396309476 > ./result_6chains/node13_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_1_2 -p 421 -st topic13_1_1 -pt None -u 0.026457625319300904 > ./result_6chains/node13_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_2_2 -p 756 -st topic13_2_1 -pt None -u 0.014229954842079506 > ./result_6chains/node13_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_3_2 -p 826 -st topic13_3_1 -pt None -u 0.08126812451045953 > ./result_6chains/node13_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_4_2 -p 901 -st topic13_4_1 -pt None -u 0.013660527663469965 > ./result_6chains/node13_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_5_2 -p 938 -st topic13_5_1 -pt None -u 0.009746846075650328 > ./result_6chains/node13_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_0_0 -p 65 -st none -pt topic13_0_0 -u 0.014278123805318899 > ./result_6chains/node13_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_1_0 -p 421 -st none -pt topic13_1_0 -u 0.014387778022402653 > ./result_6chains/node13_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_2_0 -p 756 -st none -pt topic13_2_0 -u 0.007534393546752838 > ./result_6chains/node13_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_3_0 -p 826 -st none -pt topic13_3_0 -u 0.0004596984107521629 > ./result_6chains/node13_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node13_4_0 -p 901 -st none -pt topic13_4_0 -u 0.004403271268733661 > ./result_6chains/node13_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node13_5_0 -p 938 -st none -pt topic13_5_0 -u 0.0010533161003082048 > ./result_6chains/node13_5_0.txt &
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
    "./result_6chains/node13_0_0.txt 90"
    "./result_6chains/node13_0_2.txt 90"
    "./result_6chains/node13_1_0.txt 89"
    "./result_6chains/node13_1_2.txt 89"
    "./result_6chains/node13_2_0.txt 88"
    "./result_6chains/node13_2_2.txt 88"
    "./result_6chains/node13_3_0.txt 87"
    "./result_6chains/node13_3_2.txt 87"
    "./result_6chains/node13_4_0.txt 86"
    "./result_6chains/node13_4_2.txt 86"
    "./result_6chains/node13_5_0.txt 85"
    "./result_6chains/node13_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
