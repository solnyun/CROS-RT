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
ros2 run evaluation_3_randomdag uunifast_node -n node488_0_2 -p 53 -st topic488_0_1 -pt None -u 0.0031376156791810828 > ./result_6chains/node488_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_1_2 -p 237 -st topic488_1_1 -pt None -u 0.04970904998894776 > ./result_6chains/node488_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_2_2 -p 356 -st topic488_2_1 -pt None -u 0.023651612195714433 > ./result_6chains/node488_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_3_2 -p 709 -st topic488_3_1 -pt None -u 0.013830967504629005 > ./result_6chains/node488_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_4_2 -p 764 -st topic488_4_1 -pt None -u 0.011141877815205758 > ./result_6chains/node488_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_5_2 -p 766 -st topic488_5_1 -pt None -u 0.05367764565927883 > ./result_6chains/node488_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_0_0 -p 53 -st none -pt topic488_0_0 -u 0.032112619120352404 > ./result_6chains/node488_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_1_0 -p 237 -st none -pt topic488_1_0 -u 0.013059748784362335 > ./result_6chains/node488_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_2_0 -p 356 -st none -pt topic488_2_0 -u 0.013886382125577912 > ./result_6chains/node488_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_3_0 -p 709 -st none -pt topic488_3_0 -u 0.044015913626513914 > ./result_6chains/node488_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node488_4_0 -p 764 -st none -pt topic488_4_0 -u 0.0029901708410853545 > ./result_6chains/node488_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node488_5_0 -p 766 -st none -pt topic488_5_0 -u 0.04228311620925558 > ./result_6chains/node488_5_0.txt &
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
    "./result_6chains/node488_0_0.txt 90"
    "./result_6chains/node488_0_2.txt 90"
    "./result_6chains/node488_1_0.txt 89"
    "./result_6chains/node488_1_2.txt 89"
    "./result_6chains/node488_2_0.txt 88"
    "./result_6chains/node488_2_2.txt 88"
    "./result_6chains/node488_3_0.txt 87"
    "./result_6chains/node488_3_2.txt 87"
    "./result_6chains/node488_4_0.txt 86"
    "./result_6chains/node488_4_2.txt 86"
    "./result_6chains/node488_5_0.txt 85"
    "./result_6chains/node488_5_2.txt 85"
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
