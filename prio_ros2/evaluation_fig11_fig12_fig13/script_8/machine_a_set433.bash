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
ros2 run evaluation_3_randomdag uunifast_node -n node433_0_2 -p 15 -st topic433_0_1 -pt None -u 0.002215223327508342 > ./result_8chains/node433_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_1_2 -p 146 -st topic433_1_1 -pt None -u 0.005755937300850611 > ./result_8chains/node433_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_2_2 -p 206 -st topic433_2_1 -pt None -u 0.0027977377988388508 > ./result_8chains/node433_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_3_2 -p 561 -st topic433_3_1 -pt None -u 0.020908809985012877 > ./result_8chains/node433_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_4_2 -p 687 -st topic433_4_1 -pt None -u 0.009466676526154294 > ./result_8chains/node433_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_5_2 -p 848 -st topic433_5_1 -pt None -u 0.009264640510156325 > ./result_8chains/node433_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_6_2 -p 952 -st topic433_6_1 -pt None -u 0.0023197070015971433 > ./result_8chains/node433_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_7_2 -p 991 -st topic433_7_1 -pt None -u 0.012780797682158082 > ./result_8chains/node433_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_0_0 -p 15 -st none -pt topic433_0_0 -u 0.039679338235800055 > ./result_8chains/node433_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_1_0 -p 146 -st none -pt topic433_1_0 -u 0.0007415279001524167 > ./result_8chains/node433_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_2_0 -p 206 -st none -pt topic433_2_0 -u 0.010108449750102111 > ./result_8chains/node433_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_3_0 -p 561 -st none -pt topic433_3_0 -u 0.0007866247570142426 > ./result_8chains/node433_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_4_0 -p 687 -st none -pt topic433_4_0 -u 0.021614066204808602 > ./result_8chains/node433_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_5_0 -p 848 -st none -pt topic433_5_0 -u 0.0388044083456732 > ./result_8chains/node433_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_6_0 -p 952 -st none -pt topic433_6_0 -u 0.0732683355321549 > ./result_8chains/node433_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_7_0 -p 991 -st none -pt topic433_7_0 -u 0.004118993397755608 > ./result_8chains/node433_7_0.txt &
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
    "./result_8chains/node433_0_0.txt 90"
    "./result_8chains/node433_0_2.txt 90"
    "./result_8chains/node433_1_0.txt 89"
    "./result_8chains/node433_1_2.txt 89"
    "./result_8chains/node433_2_0.txt 88"
    "./result_8chains/node433_2_2.txt 88"
    "./result_8chains/node433_3_0.txt 87"
    "./result_8chains/node433_3_2.txt 87"
    "./result_8chains/node433_4_0.txt 86"
    "./result_8chains/node433_4_2.txt 86"
    "./result_8chains/node433_5_0.txt 85"
    "./result_8chains/node433_5_2.txt 85"
    "./result_8chains/node433_6_0.txt 84"
    "./result_8chains/node433_6_2.txt 84"
    "./result_8chains/node433_7_0.txt 83"
    "./result_8chains/node433_7_2.txt 83"
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
