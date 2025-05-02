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
ros2 run evaluation_3_randomdag uunifast_node -n node224_0_2 -p 89 -st topic224_0_1 -pt None -u 0.00016637492514626206 > ./result_6chains/node224_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_1_2 -p 134 -st topic224_1_1 -pt None -u 0.05556878178849789 > ./result_6chains/node224_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_2_2 -p 429 -st topic224_2_1 -pt None -u 0.0077974229590764 > ./result_6chains/node224_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_3_2 -p 479 -st topic224_3_1 -pt None -u 0.004821414381363048 > ./result_6chains/node224_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_4_2 -p 733 -st topic224_4_1 -pt None -u 0.005557899468152286 > ./result_6chains/node224_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_5_2 -p 892 -st topic224_5_1 -pt None -u 0.007121591101058626 > ./result_6chains/node224_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_0_0 -p 89 -st none -pt topic224_0_0 -u 0.019828174623910788 > ./result_6chains/node224_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_1_0 -p 134 -st none -pt topic224_1_0 -u 0.030000171885424642 > ./result_6chains/node224_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_2_0 -p 429 -st none -pt topic224_2_0 -u 0.03792673666881252 > ./result_6chains/node224_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_3_0 -p 479 -st none -pt topic224_3_0 -u 0.06042857744124272 > ./result_6chains/node224_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_4_0 -p 733 -st none -pt topic224_4_0 -u 0.008321155822199944 > ./result_6chains/node224_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_5_0 -p 892 -st none -pt topic224_5_0 -u 0.00725755866657414 > ./result_6chains/node224_5_0.txt &
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
    "./result_6chains/node224_0_0.txt 90"
    "./result_6chains/node224_0_2.txt 90"
    "./result_6chains/node224_1_0.txt 89"
    "./result_6chains/node224_1_2.txt 89"
    "./result_6chains/node224_2_0.txt 88"
    "./result_6chains/node224_2_2.txt 88"
    "./result_6chains/node224_3_0.txt 87"
    "./result_6chains/node224_3_2.txt 87"
    "./result_6chains/node224_4_0.txt 86"
    "./result_6chains/node224_4_2.txt 86"
    "./result_6chains/node224_5_0.txt 85"
    "./result_6chains/node224_5_2.txt 85"
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
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
