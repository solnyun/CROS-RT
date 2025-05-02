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
ros2 run evaluation_3_randomdag uunifast_node -n node359_0_2 -p 43 -st topic359_0_1 -pt None -u 0.011763331079599204 > ./result_6chains/node359_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_1_2 -p 89 -st topic359_1_1 -pt None -u 0.007852862838685304 > ./result_6chains/node359_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_2_2 -p 132 -st topic359_2_1 -pt None -u 0.037466787902375176 > ./result_6chains/node359_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_3_2 -p 283 -st topic359_3_1 -pt None -u 0.03357792124162992 > ./result_6chains/node359_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_4_2 -p 394 -st topic359_4_1 -pt None -u 0.07623876928578137 > ./result_6chains/node359_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_5_2 -p 397 -st topic359_5_1 -pt None -u 0.06609799589187713 > ./result_6chains/node359_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_0_0 -p 43 -st none -pt topic359_0_0 -u 0.035938418367518266 > ./result_6chains/node359_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_1_0 -p 89 -st none -pt topic359_1_0 -u 0.011736569991640966 > ./result_6chains/node359_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_2_0 -p 132 -st none -pt topic359_2_0 -u 6.705204270146536e-05 > ./result_6chains/node359_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_3_0 -p 283 -st none -pt topic359_3_0 -u 0.046260623641210696 > ./result_6chains/node359_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_4_0 -p 394 -st none -pt topic359_4_0 -u 0.008256363570645742 > ./result_6chains/node359_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_5_0 -p 397 -st none -pt topic359_5_0 -u 0.026319780722577485 > ./result_6chains/node359_5_0.txt &
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
    "./result_6chains/node359_0_0.txt 90"
    "./result_6chains/node359_0_2.txt 90"
    "./result_6chains/node359_1_0.txt 89"
    "./result_6chains/node359_1_2.txt 89"
    "./result_6chains/node359_2_0.txt 88"
    "./result_6chains/node359_2_2.txt 88"
    "./result_6chains/node359_3_0.txt 87"
    "./result_6chains/node359_3_2.txt 87"
    "./result_6chains/node359_4_0.txt 86"
    "./result_6chains/node359_4_2.txt 86"
    "./result_6chains/node359_5_0.txt 85"
    "./result_6chains/node359_5_2.txt 85"
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
