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
ros2 run evaluation_3_randomdag uunifast_node -n node279_0_2 -p 16 -st topic279_0_1 -pt None -u 0.003323857383553286 > ./result_6chains/node279_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_1_2 -p 50 -st topic279_1_1 -pt None -u 0.03661363609136631 > ./result_6chains/node279_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_2_2 -p 78 -st topic279_2_1 -pt None -u 0.04156644351237121 > ./result_6chains/node279_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_3_2 -p 266 -st topic279_3_1 -pt None -u 0.07646904591247658 > ./result_6chains/node279_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_4_2 -p 450 -st topic279_4_1 -pt None -u 0.0005590774354411326 > ./result_6chains/node279_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_5_2 -p 512 -st topic279_5_1 -pt None -u 0.03298586171147897 > ./result_6chains/node279_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_0_0 -p 16 -st none -pt topic279_0_0 -u 0.0004701040124938105 > ./result_6chains/node279_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_1_0 -p 50 -st none -pt topic279_1_0 -u 0.008453680956543641 > ./result_6chains/node279_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_2_0 -p 78 -st none -pt topic279_2_0 -u 0.044483331383081526 > ./result_6chains/node279_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_3_0 -p 266 -st none -pt topic279_3_0 -u 0.08713767819751306 > ./result_6chains/node279_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node279_4_0 -p 450 -st none -pt topic279_4_0 -u 0.0156361664313764 > ./result_6chains/node279_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node279_5_0 -p 512 -st none -pt topic279_5_0 -u 0.03948240972142823 > ./result_6chains/node279_5_0.txt &
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
    "./result_6chains/node279_0_0.txt 90"
    "./result_6chains/node279_0_2.txt 90"
    "./result_6chains/node279_1_0.txt 89"
    "./result_6chains/node279_1_2.txt 89"
    "./result_6chains/node279_2_0.txt 88"
    "./result_6chains/node279_2_2.txt 88"
    "./result_6chains/node279_3_0.txt 87"
    "./result_6chains/node279_3_2.txt 87"
    "./result_6chains/node279_4_0.txt 86"
    "./result_6chains/node279_4_2.txt 86"
    "./result_6chains/node279_5_0.txt 85"
    "./result_6chains/node279_5_2.txt 85"
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
