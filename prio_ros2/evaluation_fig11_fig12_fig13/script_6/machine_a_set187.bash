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
ros2 run evaluation_3_randomdag uunifast_node -n node187_0_2 -p 268 -st topic187_0_1 -pt None -u 0.0032395120518255993 > ./result_6chains/node187_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_1_2 -p 397 -st topic187_1_1 -pt None -u 0.03946588328411077 > ./result_6chains/node187_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_2_2 -p 449 -st topic187_2_1 -pt None -u 0.015109521805069137 > ./result_6chains/node187_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_3_2 -p 683 -st topic187_3_1 -pt None -u 0.025248779874449012 > ./result_6chains/node187_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_4_2 -p 747 -st topic187_4_1 -pt None -u 0.020525308289260878 > ./result_6chains/node187_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_5_2 -p 852 -st topic187_5_1 -pt None -u 0.002050454695542668 > ./result_6chains/node187_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_0_0 -p 268 -st none -pt topic187_0_0 -u 0.005132643315535146 > ./result_6chains/node187_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_1_0 -p 397 -st none -pt topic187_1_0 -u 0.024243952828980564 > ./result_6chains/node187_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_2_0 -p 449 -st none -pt topic187_2_0 -u 0.0042116130073529545 > ./result_6chains/node187_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_3_0 -p 683 -st none -pt topic187_3_0 -u 0.022330312171338462 > ./result_6chains/node187_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_4_0 -p 747 -st none -pt topic187_4_0 -u 0.20719373926896098 > ./result_6chains/node187_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node187_5_0 -p 852 -st none -pt topic187_5_0 -u 0.03679670714478962 > ./result_6chains/node187_5_0.txt &
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
    "./result_6chains/node187_0_0.txt 90"
    "./result_6chains/node187_0_2.txt 90"
    "./result_6chains/node187_1_0.txt 89"
    "./result_6chains/node187_1_2.txt 89"
    "./result_6chains/node187_2_0.txt 88"
    "./result_6chains/node187_2_2.txt 88"
    "./result_6chains/node187_3_0.txt 87"
    "./result_6chains/node187_3_2.txt 87"
    "./result_6chains/node187_4_0.txt 86"
    "./result_6chains/node187_4_2.txt 86"
    "./result_6chains/node187_5_0.txt 85"
    "./result_6chains/node187_5_2.txt 85"
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
