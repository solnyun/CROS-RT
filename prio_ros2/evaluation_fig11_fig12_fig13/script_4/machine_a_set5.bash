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
ros2 run evaluation_3_randomdag uunifast_node -n node5_0_2 -p 101 -st topic5_0_1 -pt None -u 0.054361008710620884 > ./result_4chains/node5_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_1_2 -p 507 -st topic5_1_1 -pt None -u 0.14792966459895582 > ./result_4chains/node5_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_2_2 -p 771 -st topic5_2_1 -pt None -u 0.06361380147790899 > ./result_4chains/node5_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_3_2 -p 854 -st topic5_3_1 -pt None -u 0.009004065995512784 > ./result_4chains/node5_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_0_0 -p 101 -st none -pt topic5_0_0 -u 0.026757930552295583 > ./result_4chains/node5_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_1_0 -p 507 -st none -pt topic5_1_0 -u 0.020926951681475903 > ./result_4chains/node5_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node5_2_0 -p 771 -st none -pt topic5_2_0 -u 0.022644646734773483 > ./result_4chains/node5_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node5_3_0 -p 854 -st none -pt topic5_3_0 -u 0.04268187861662942 > ./result_4chains/node5_3_0.txt &
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
    "./result_4chains/node5_0_0.txt 90"
    "./result_4chains/node5_0_2.txt 90"
    "./result_4chains/node5_1_0.txt 89"
    "./result_4chains/node5_1_2.txt 89"
    "./result_4chains/node5_2_0.txt 88"
    "./result_4chains/node5_2_2.txt 88"
    "./result_4chains/node5_3_0.txt 87"
    "./result_4chains/node5_3_2.txt 87"
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
sleep 70s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 40s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
