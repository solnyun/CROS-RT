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
ros2 run evaluation_3_randomdag uunifast_node -n node366_0_2 -p 39 -st topic366_0_1 -pt None -u 0.045277079734148185 > ./result_6chains/node366_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_1_2 -p 88 -st topic366_1_1 -pt None -u 0.018223099431991963 > ./result_6chains/node366_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_2_2 -p 252 -st topic366_2_1 -pt None -u 0.004260263802857239 > ./result_6chains/node366_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_3_2 -p 606 -st topic366_3_1 -pt None -u 0.015532433486122599 > ./result_6chains/node366_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_4_2 -p 607 -st topic366_4_1 -pt None -u 0.01125178603350939 > ./result_6chains/node366_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_5_2 -p 654 -st topic366_5_1 -pt None -u 0.03486597154314184 > ./result_6chains/node366_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_0_0 -p 39 -st none -pt topic366_0_0 -u 0.013480754116057037 > ./result_6chains/node366_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_1_0 -p 88 -st none -pt topic366_1_0 -u 0.0045321762952845734 > ./result_6chains/node366_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_2_0 -p 252 -st none -pt topic366_2_0 -u 0.022718311234412925 > ./result_6chains/node366_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_3_0 -p 606 -st none -pt topic366_3_0 -u 0.015692751013146378 > ./result_6chains/node366_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_4_0 -p 607 -st none -pt topic366_4_0 -u 0.06289523950992254 > ./result_6chains/node366_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_5_0 -p 654 -st none -pt topic366_5_0 -u 0.010626112440046263 > ./result_6chains/node366_5_0.txt &
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
    "./result_6chains/node366_0_0.txt 90"
    "./result_6chains/node366_0_2.txt 90"
    "./result_6chains/node366_1_0.txt 89"
    "./result_6chains/node366_1_2.txt 89"
    "./result_6chains/node366_2_0.txt 88"
    "./result_6chains/node366_2_2.txt 88"
    "./result_6chains/node366_3_0.txt 87"
    "./result_6chains/node366_3_2.txt 87"
    "./result_6chains/node366_4_0.txt 86"
    "./result_6chains/node366_4_2.txt 86"
    "./result_6chains/node366_5_0.txt 85"
    "./result_6chains/node366_5_2.txt 85"
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
