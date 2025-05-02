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
ros2 run evaluation_3_randomdag uunifast_node -n node119_0_2 -p 220 -st topic119_0_1 -pt None -u 0.08433191291213832 > ./result_6chains/node119_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_1_2 -p 503 -st topic119_1_1 -pt None -u 0.0014701007032930646 > ./result_6chains/node119_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_2_2 -p 629 -st topic119_2_1 -pt None -u 0.0008081306415017586 > ./result_6chains/node119_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_3_2 -p 636 -st topic119_3_1 -pt None -u 0.005866976440141697 > ./result_6chains/node119_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_4_2 -p 785 -st topic119_4_1 -pt None -u 0.04487564309328179 > ./result_6chains/node119_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_5_2 -p 966 -st topic119_5_1 -pt None -u 0.04409321481085469 > ./result_6chains/node119_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_0_0 -p 220 -st none -pt topic119_0_0 -u 0.01117339095959946 > ./result_6chains/node119_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_1_0 -p 503 -st none -pt topic119_1_0 -u 0.011565711543837065 > ./result_6chains/node119_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_2_0 -p 629 -st none -pt topic119_2_0 -u 0.0031689456349462963 > ./result_6chains/node119_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_3_0 -p 636 -st none -pt topic119_3_0 -u 0.0061894288628597804 > ./result_6chains/node119_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_4_0 -p 785 -st none -pt topic119_4_0 -u 0.003771757151333738 > ./result_6chains/node119_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_5_0 -p 966 -st none -pt topic119_5_0 -u 0.00295222721739917 > ./result_6chains/node119_5_0.txt &
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
    "./result_6chains/node119_0_0.txt 90"
    "./result_6chains/node119_0_2.txt 90"
    "./result_6chains/node119_1_0.txt 89"
    "./result_6chains/node119_1_2.txt 89"
    "./result_6chains/node119_2_0.txt 88"
    "./result_6chains/node119_2_2.txt 88"
    "./result_6chains/node119_3_0.txt 87"
    "./result_6chains/node119_3_2.txt 87"
    "./result_6chains/node119_4_0.txt 86"
    "./result_6chains/node119_4_2.txt 86"
    "./result_6chains/node119_5_0.txt 85"
    "./result_6chains/node119_5_2.txt 85"
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
