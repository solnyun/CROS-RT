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
ros2 run evaluation_3_randomdag uunifast_node -n node200_0_2 -p 64 -st topic200_0_1 -pt None -u 0.1611538979353178 > ./result_4chains/node200_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_1_2 -p 443 -st topic200_1_1 -pt None -u 0.039021488099357154 > ./result_4chains/node200_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_2_2 -p 667 -st topic200_2_1 -pt None -u 0.029712019025383854 > ./result_4chains/node200_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_3_2 -p 926 -st topic200_3_1 -pt None -u 0.02253798359051783 > ./result_4chains/node200_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_0_0 -p 64 -st none -pt topic200_0_0 -u 0.011598097402659435 > ./result_4chains/node200_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_1_0 -p 443 -st none -pt topic200_1_0 -u 0.016046626468993685 > ./result_4chains/node200_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node200_2_0 -p 667 -st none -pt topic200_2_0 -u 0.031115121776258206 > ./result_4chains/node200_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node200_3_0 -p 926 -st none -pt topic200_3_0 -u 0.036828496440845376 > ./result_4chains/node200_3_0.txt &
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
    "./result_4chains/node200_0_0.txt 90"
    "./result_4chains/node200_0_2.txt 90"
    "./result_4chains/node200_1_0.txt 89"
    "./result_4chains/node200_1_2.txt 89"
    "./result_4chains/node200_2_0.txt 88"
    "./result_4chains/node200_2_2.txt 88"
    "./result_4chains/node200_3_0.txt 87"
    "./result_4chains/node200_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
