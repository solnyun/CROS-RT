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
ros2 run evaluation_3_randomdag uunifast_node -n node379_0_2 -p 225 -st topic379_0_1 -pt None -u 0.013310609821094721 > ./result_4chains/node379_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_1_2 -p 336 -st topic379_1_1 -pt None -u 0.08508703871385995 > ./result_4chains/node379_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_2_2 -p 573 -st topic379_2_1 -pt None -u 0.010489671077215879 > ./result_4chains/node379_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_3_2 -p 583 -st topic379_3_1 -pt None -u 0.01260004247362603 > ./result_4chains/node379_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_0_0 -p 225 -st none -pt topic379_0_0 -u 0.03434690631270648 > ./result_4chains/node379_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_1_0 -p 336 -st none -pt topic379_1_0 -u 0.008224036667997037 > ./result_4chains/node379_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_2_0 -p 573 -st none -pt topic379_2_0 -u 0.08981506501664716 > ./result_4chains/node379_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_3_0 -p 583 -st none -pt topic379_3_0 -u 0.04303761272142404 > ./result_4chains/node379_3_0.txt &
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
    "./result_4chains/node379_0_0.txt 90"
    "./result_4chains/node379_0_2.txt 90"
    "./result_4chains/node379_1_0.txt 89"
    "./result_4chains/node379_1_2.txt 89"
    "./result_4chains/node379_2_0.txt 88"
    "./result_4chains/node379_2_2.txt 88"
    "./result_4chains/node379_3_0.txt 87"
    "./result_4chains/node379_3_2.txt 87"
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
