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
ros2 run evaluation_3_randomdag uunifast_node -n node290_0_2 -p 369 -st topic290_0_1 -pt None -u 0.022476694873083514 > ./result_6chains/node290_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_1_2 -p 375 -st topic290_1_1 -pt None -u 0.025520630082283446 > ./result_6chains/node290_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_2_2 -p 547 -st topic290_2_1 -pt None -u 0.006107820026407834 > ./result_6chains/node290_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_3_2 -p 695 -st topic290_3_1 -pt None -u 0.03503871227011576 > ./result_6chains/node290_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_4_2 -p 922 -st topic290_4_1 -pt None -u 0.042048544334697596 > ./result_6chains/node290_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_5_2 -p 965 -st topic290_5_1 -pt None -u 0.01788566271109698 > ./result_6chains/node290_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_0_0 -p 369 -st none -pt topic290_0_0 -u 0.020821421648576977 > ./result_6chains/node290_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_1_0 -p 375 -st none -pt topic290_1_0 -u 0.12096941778496512 > ./result_6chains/node290_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_2_0 -p 547 -st none -pt topic290_2_0 -u 0.01565497756151124 > ./result_6chains/node290_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_3_0 -p 695 -st none -pt topic290_3_0 -u 0.010908543141740834 > ./result_6chains/node290_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_4_0 -p 922 -st none -pt topic290_4_0 -u 0.008756410414193727 > ./result_6chains/node290_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_5_0 -p 965 -st none -pt topic290_5_0 -u 0.015920070362480443 > ./result_6chains/node290_5_0.txt &
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
    "./result_6chains/node290_0_0.txt 90"
    "./result_6chains/node290_0_2.txt 90"
    "./result_6chains/node290_1_0.txt 89"
    "./result_6chains/node290_1_2.txt 89"
    "./result_6chains/node290_2_0.txt 88"
    "./result_6chains/node290_2_2.txt 88"
    "./result_6chains/node290_3_0.txt 87"
    "./result_6chains/node290_3_2.txt 87"
    "./result_6chains/node290_4_0.txt 86"
    "./result_6chains/node290_4_2.txt 86"
    "./result_6chains/node290_5_0.txt 85"
    "./result_6chains/node290_5_2.txt 85"
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
