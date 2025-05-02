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
ros2 run evaluation_3_randomdag uunifast_node -n node61_0_2 -p 176 -st topic61_0_1 -pt None -u 0.014179025557950531 > ./result_6chains/node61_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_1_2 -p 357 -st topic61_1_1 -pt None -u 0.012739696869934813 > ./result_6chains/node61_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_2_2 -p 385 -st topic61_2_1 -pt None -u 0.011180838059467846 > ./result_6chains/node61_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_3_2 -p 728 -st topic61_3_1 -pt None -u 0.08570696121333526 > ./result_6chains/node61_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_4_2 -p 742 -st topic61_4_1 -pt None -u 0.08893420470572926 > ./result_6chains/node61_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_5_2 -p 918 -st topic61_5_1 -pt None -u 0.009675239178495474 > ./result_6chains/node61_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_0_0 -p 176 -st none -pt topic61_0_0 -u 0.018182645732893188 > ./result_6chains/node61_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_1_0 -p 357 -st none -pt topic61_1_0 -u 0.009231195934075342 > ./result_6chains/node61_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_2_0 -p 385 -st none -pt topic61_2_0 -u 0.04103181761208757 > ./result_6chains/node61_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_3_0 -p 728 -st none -pt topic61_3_0 -u 0.024378590645338427 > ./result_6chains/node61_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node61_4_0 -p 742 -st none -pt topic61_4_0 -u 0.03291157667993466 > ./result_6chains/node61_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node61_5_0 -p 918 -st none -pt topic61_5_0 -u 0.028149360463645252 > ./result_6chains/node61_5_0.txt &
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
    "./result_6chains/node61_0_0.txt 90"
    "./result_6chains/node61_0_2.txt 90"
    "./result_6chains/node61_1_0.txt 89"
    "./result_6chains/node61_1_2.txt 89"
    "./result_6chains/node61_2_0.txt 88"
    "./result_6chains/node61_2_2.txt 88"
    "./result_6chains/node61_3_0.txt 87"
    "./result_6chains/node61_3_2.txt 87"
    "./result_6chains/node61_4_0.txt 86"
    "./result_6chains/node61_4_2.txt 86"
    "./result_6chains/node61_5_0.txt 85"
    "./result_6chains/node61_5_2.txt 85"
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
