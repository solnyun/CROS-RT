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
ros2 run evaluation_3_randomdag uunifast_node -n node423_0_2 -p 127 -st topic423_0_1 -pt None -u 0.027549442516070943 > ./result_8chains/node423_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_1_2 -p 235 -st topic423_1_1 -pt None -u 0.002576158396457362 > ./result_8chains/node423_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_2_2 -p 289 -st topic423_2_1 -pt None -u 0.003790549741563898 > ./result_8chains/node423_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_3_2 -p 299 -st topic423_3_1 -pt None -u 0.019388544258243934 > ./result_8chains/node423_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_4_2 -p 331 -st topic423_4_1 -pt None -u 0.09680670439120145 > ./result_8chains/node423_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_5_2 -p 687 -st topic423_5_1 -pt None -u 0.008121573660696296 > ./result_8chains/node423_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_6_2 -p 835 -st topic423_6_1 -pt None -u 0.07019272002299459 > ./result_8chains/node423_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_7_2 -p 961 -st topic423_7_1 -pt None -u 0.0004262420688517754 > ./result_8chains/node423_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_0_0 -p 127 -st none -pt topic423_0_0 -u 0.0001501482299580137 > ./result_8chains/node423_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_1_0 -p 235 -st none -pt topic423_1_0 -u 0.000655847918166641 > ./result_8chains/node423_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_2_0 -p 289 -st none -pt topic423_2_0 -u 0.051706134750534316 > ./result_8chains/node423_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_3_0 -p 299 -st none -pt topic423_3_0 -u 0.011536359078924141 > ./result_8chains/node423_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_4_0 -p 331 -st none -pt topic423_4_0 -u 0.048480210983967764 > ./result_8chains/node423_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_5_0 -p 687 -st none -pt topic423_5_0 -u 0.006407159772968296 > ./result_8chains/node423_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node423_6_0 -p 835 -st none -pt topic423_6_0 -u 0.009039923825560722 > ./result_8chains/node423_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node423_7_0 -p 961 -st none -pt topic423_7_0 -u 0.018018097975137773 > ./result_8chains/node423_7_0.txt &
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
    "./result_8chains/node423_0_0.txt 90"
    "./result_8chains/node423_0_2.txt 90"
    "./result_8chains/node423_1_0.txt 89"
    "./result_8chains/node423_1_2.txt 89"
    "./result_8chains/node423_2_0.txt 88"
    "./result_8chains/node423_2_2.txt 88"
    "./result_8chains/node423_3_0.txt 87"
    "./result_8chains/node423_3_2.txt 87"
    "./result_8chains/node423_4_0.txt 86"
    "./result_8chains/node423_4_2.txt 86"
    "./result_8chains/node423_5_0.txt 85"
    "./result_8chains/node423_5_2.txt 85"
    "./result_8chains/node423_6_0.txt 84"
    "./result_8chains/node423_6_2.txt 84"
    "./result_8chains/node423_7_0.txt 83"
    "./result_8chains/node423_7_2.txt 83"
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
