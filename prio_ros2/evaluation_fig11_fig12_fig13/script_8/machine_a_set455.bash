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
ros2 run evaluation_3_randomdag uunifast_node -n node455_0_2 -p 19 -st topic455_0_1 -pt None -u 0.020378784157004004 > ./result_8chains/node455_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_1_2 -p 373 -st topic455_1_1 -pt None -u 0.010966005432905324 > ./result_8chains/node455_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_2_2 -p 481 -st topic455_2_1 -pt None -u 0.012311440964207443 > ./result_8chains/node455_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_3_2 -p 585 -st topic455_3_1 -pt None -u 0.018511344909115157 > ./result_8chains/node455_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_4_2 -p 641 -st topic455_4_1 -pt None -u 0.001172931073656791 > ./result_8chains/node455_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_5_2 -p 819 -st topic455_5_1 -pt None -u 0.01901921885656402 > ./result_8chains/node455_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_6_2 -p 952 -st topic455_6_1 -pt None -u 0.00835114191923464 > ./result_8chains/node455_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_7_2 -p 993 -st topic455_7_1 -pt None -u 0.053581392799221014 > ./result_8chains/node455_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_0_0 -p 19 -st none -pt topic455_0_0 -u 0.0010845788892758224 > ./result_8chains/node455_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_1_0 -p 373 -st none -pt topic455_1_0 -u 0.040498353555400324 > ./result_8chains/node455_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_2_0 -p 481 -st none -pt topic455_2_0 -u 0.026892893451641142 > ./result_8chains/node455_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_3_0 -p 585 -st none -pt topic455_3_0 -u 0.00689330012170597 > ./result_8chains/node455_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_4_0 -p 641 -st none -pt topic455_4_0 -u 0.010225501900238076 > ./result_8chains/node455_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_5_0 -p 819 -st none -pt topic455_5_0 -u 0.03016659514418754 > ./result_8chains/node455_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node455_6_0 -p 952 -st none -pt topic455_6_0 -u 0.054355827080560276 > ./result_8chains/node455_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node455_7_0 -p 993 -st none -pt topic455_7_0 -u 0.011580224113918874 > ./result_8chains/node455_7_0.txt &
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
    "./result_8chains/node455_0_0.txt 90"
    "./result_8chains/node455_0_2.txt 90"
    "./result_8chains/node455_1_0.txt 89"
    "./result_8chains/node455_1_2.txt 89"
    "./result_8chains/node455_2_0.txt 88"
    "./result_8chains/node455_2_2.txt 88"
    "./result_8chains/node455_3_0.txt 87"
    "./result_8chains/node455_3_2.txt 87"
    "./result_8chains/node455_4_0.txt 86"
    "./result_8chains/node455_4_2.txt 86"
    "./result_8chains/node455_5_0.txt 85"
    "./result_8chains/node455_5_2.txt 85"
    "./result_8chains/node455_6_0.txt 84"
    "./result_8chains/node455_6_2.txt 84"
    "./result_8chains/node455_7_0.txt 83"
    "./result_8chains/node455_7_2.txt 83"
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
