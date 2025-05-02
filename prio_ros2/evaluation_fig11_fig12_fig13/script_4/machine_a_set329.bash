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
ros2 run evaluation_3_randomdag uunifast_node -n node329_0_2 -p 287 -st topic329_0_1 -pt None -u 0.01765124980138505 > ./result_4chains/node329_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_1_2 -p 315 -st topic329_1_1 -pt None -u 0.03044447132938405 > ./result_4chains/node329_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_2_2 -p 642 -st topic329_2_1 -pt None -u 0.027526806502473522 > ./result_4chains/node329_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_3_2 -p 781 -st topic329_3_1 -pt None -u 0.018619394290080016 > ./result_4chains/node329_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_0_0 -p 287 -st none -pt topic329_0_0 -u 0.0717800453710229 > ./result_4chains/node329_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_1_0 -p 315 -st none -pt topic329_1_0 -u 0.05670116240251427 > ./result_4chains/node329_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node329_2_0 -p 642 -st none -pt topic329_2_0 -u 0.01544816559573886 > ./result_4chains/node329_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node329_3_0 -p 781 -st none -pt topic329_3_0 -u 0.07036608246591557 > ./result_4chains/node329_3_0.txt &
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
    "./result_4chains/node329_0_0.txt 90"
    "./result_4chains/node329_0_2.txt 90"
    "./result_4chains/node329_1_0.txt 89"
    "./result_4chains/node329_1_2.txt 89"
    "./result_4chains/node329_2_0.txt 88"
    "./result_4chains/node329_2_2.txt 88"
    "./result_4chains/node329_3_0.txt 87"
    "./result_4chains/node329_3_2.txt 87"
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
