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
ros2 run evaluation_3_randomdag uunifast_node -n node146_0_2 -p 11 -st topic146_0_1 -pt None -u 0.02814319025976042 > ./result_8chains/node146_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_1_2 -p 15 -st topic146_1_1 -pt None -u 0.011661713272183294 > ./result_8chains/node146_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_2_2 -p 59 -st topic146_2_1 -pt None -u 0.029665257068844764 > ./result_8chains/node146_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_3_2 -p 68 -st topic146_3_1 -pt None -u 0.0014730993470337683 > ./result_8chains/node146_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_4_2 -p 88 -st topic146_4_1 -pt None -u 0.028721549486669024 > ./result_8chains/node146_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_5_2 -p 113 -st topic146_5_1 -pt None -u 0.09348726674155895 > ./result_8chains/node146_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_6_2 -p 667 -st topic146_6_1 -pt None -u 0.009959389792454004 > ./result_8chains/node146_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_7_2 -p 770 -st topic146_7_1 -pt None -u 0.021680189159432116 > ./result_8chains/node146_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_0_0 -p 11 -st none -pt topic146_0_0 -u 0.01784505879192494 > ./result_8chains/node146_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_1_0 -p 15 -st none -pt topic146_1_0 -u 0.0011754681218614782 > ./result_8chains/node146_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_2_0 -p 59 -st none -pt topic146_2_0 -u 0.05069420343688297 > ./result_8chains/node146_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_3_0 -p 68 -st none -pt topic146_3_0 -u 0.013417133911356294 > ./result_8chains/node146_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_4_0 -p 88 -st none -pt topic146_4_0 -u 0.007888466920230042 > ./result_8chains/node146_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_5_0 -p 113 -st none -pt topic146_5_0 -u 0.0013605145596088108 > ./result_8chains/node146_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node146_6_0 -p 667 -st none -pt topic146_6_0 -u 0.0506168483026944 > ./result_8chains/node146_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node146_7_0 -p 770 -st none -pt topic146_7_0 -u 0.013267414628054176 > ./result_8chains/node146_7_0.txt &
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
    "./result_8chains/node146_0_0.txt 90"
    "./result_8chains/node146_0_2.txt 90"
    "./result_8chains/node146_1_0.txt 89"
    "./result_8chains/node146_1_2.txt 89"
    "./result_8chains/node146_2_0.txt 88"
    "./result_8chains/node146_2_2.txt 88"
    "./result_8chains/node146_3_0.txt 87"
    "./result_8chains/node146_3_2.txt 87"
    "./result_8chains/node146_4_0.txt 86"
    "./result_8chains/node146_4_2.txt 86"
    "./result_8chains/node146_5_0.txt 85"
    "./result_8chains/node146_5_2.txt 85"
    "./result_8chains/node146_6_0.txt 84"
    "./result_8chains/node146_6_2.txt 84"
    "./result_8chains/node146_7_0.txt 83"
    "./result_8chains/node146_7_2.txt 83"
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
