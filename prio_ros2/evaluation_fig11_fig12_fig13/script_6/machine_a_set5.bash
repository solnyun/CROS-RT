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
ros2 run evaluation_3_randomdag uunifast_node -n node5_0_2 -p 81 -st topic5_0_1 -pt None -u 0.02914308186379938 > ./result_6chains/node5_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_1_2 -p 428 -st topic5_1_1 -pt None -u 0.016639222838941536 > ./result_6chains/node5_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_2_2 -p 474 -st topic5_2_1 -pt None -u 0.007571481829520416 > ./result_6chains/node5_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_3_2 -p 675 -st topic5_3_1 -pt None -u 0.007710263005085538 > ./result_6chains/node5_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_4_2 -p 942 -st topic5_4_1 -pt None -u 0.0017463758638560645 > ./result_6chains/node5_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_5_2 -p 986 -st topic5_5_1 -pt None -u 0.06712696398613428 > ./result_6chains/node5_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_0_0 -p 81 -st none -pt topic5_0_0 -u 0.023002067839783258 > ./result_6chains/node5_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_1_0 -p 428 -st none -pt topic5_1_0 -u 0.12213869039438824 > ./result_6chains/node5_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_2_0 -p 474 -st none -pt topic5_2_0 -u 0.019668898029102655 > ./result_6chains/node5_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_3_0 -p 675 -st none -pt topic5_3_0 -u 0.025488021345045492 > ./result_6chains/node5_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_4_0 -p 942 -st none -pt topic5_4_0 -u 0.004020693233164313 > ./result_6chains/node5_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_5_0 -p 986 -st none -pt topic5_5_0 -u 0.01363815917142594 > ./result_6chains/node5_5_0.txt &
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
    "./result_6chains/node5_0_0.txt 90"
    "./result_6chains/node5_0_2.txt 90"
    "./result_6chains/node5_1_0.txt 89"
    "./result_6chains/node5_1_2.txt 89"
    "./result_6chains/node5_2_0.txt 88"
    "./result_6chains/node5_2_2.txt 88"
    "./result_6chains/node5_3_0.txt 87"
    "./result_6chains/node5_3_2.txt 87"
    "./result_6chains/node5_4_0.txt 86"
    "./result_6chains/node5_4_2.txt 86"
    "./result_6chains/node5_5_0.txt 85"
    "./result_6chains/node5_5_2.txt 85"
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
