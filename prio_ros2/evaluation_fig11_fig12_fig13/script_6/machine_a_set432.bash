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
ros2 run evaluation_3_randomdag uunifast_node -n node432_0_2 -p 250 -st topic432_0_1 -pt None -u 0.028551580636597962 > ./result_6chains/node432_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_1_2 -p 380 -st topic432_1_1 -pt None -u 0.00978835694873409 > ./result_6chains/node432_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_2_2 -p 397 -st topic432_2_1 -pt None -u 0.06522753527202818 > ./result_6chains/node432_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_3_2 -p 471 -st topic432_3_1 -pt None -u 0.020874683465984395 > ./result_6chains/node432_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_4_2 -p 705 -st topic432_4_1 -pt None -u 0.0459325620226812 > ./result_6chains/node432_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_5_2 -p 785 -st topic432_5_1 -pt None -u 0.0028606644681573507 > ./result_6chains/node432_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_0_0 -p 250 -st none -pt topic432_0_0 -u 0.0027875751584778286 > ./result_6chains/node432_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_1_0 -p 380 -st none -pt topic432_1_0 -u 0.005797723643683694 > ./result_6chains/node432_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_2_0 -p 397 -st none -pt topic432_2_0 -u 0.0025935572452882583 > ./result_6chains/node432_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_3_0 -p 471 -st none -pt topic432_3_0 -u 0.0424590718995248 > ./result_6chains/node432_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node432_4_0 -p 705 -st none -pt topic432_4_0 -u 0.054588449260401656 > ./result_6chains/node432_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node432_5_0 -p 785 -st none -pt topic432_5_0 -u 0.09519441038117238 > ./result_6chains/node432_5_0.txt &
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
    "./result_6chains/node432_0_0.txt 90"
    "./result_6chains/node432_0_2.txt 90"
    "./result_6chains/node432_1_0.txt 89"
    "./result_6chains/node432_1_2.txt 89"
    "./result_6chains/node432_2_0.txt 88"
    "./result_6chains/node432_2_2.txt 88"
    "./result_6chains/node432_3_0.txt 87"
    "./result_6chains/node432_3_2.txt 87"
    "./result_6chains/node432_4_0.txt 86"
    "./result_6chains/node432_4_2.txt 86"
    "./result_6chains/node432_5_0.txt 85"
    "./result_6chains/node432_5_2.txt 85"
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
