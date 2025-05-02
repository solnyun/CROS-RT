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
ros2 run evaluation_3_randomdag uunifast_node -n node162_0_2 -p 299 -st topic162_0_1 -pt None -u 0.03739022579404566 > ./result_6chains/node162_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_1_2 -p 595 -st topic162_1_1 -pt None -u 0.02316209618970838 > ./result_6chains/node162_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_2_2 -p 864 -st topic162_2_1 -pt None -u 0.014435745651922294 > ./result_6chains/node162_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_3_2 -p 866 -st topic162_3_1 -pt None -u 0.02185260195387212 > ./result_6chains/node162_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_4_2 -p 890 -st topic162_4_1 -pt None -u 0.013231700743083913 > ./result_6chains/node162_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_5_2 -p 897 -st topic162_5_1 -pt None -u 0.04907542895443944 > ./result_6chains/node162_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_0_0 -p 299 -st none -pt topic162_0_0 -u 0.03816824706266869 > ./result_6chains/node162_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_1_0 -p 595 -st none -pt topic162_1_0 -u 0.016796278905198136 > ./result_6chains/node162_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_2_0 -p 864 -st none -pt topic162_2_0 -u 0.020673255418887593 > ./result_6chains/node162_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_3_0 -p 866 -st none -pt topic162_3_0 -u 0.006031130216498259 > ./result_6chains/node162_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node162_4_0 -p 890 -st none -pt topic162_4_0 -u 0.06657001922292327 > ./result_6chains/node162_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node162_5_0 -p 897 -st none -pt topic162_5_0 -u 0.01746944174017731 > ./result_6chains/node162_5_0.txt &
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
    "./result_6chains/node162_0_0.txt 90"
    "./result_6chains/node162_0_2.txt 90"
    "./result_6chains/node162_1_0.txt 89"
    "./result_6chains/node162_1_2.txt 89"
    "./result_6chains/node162_2_0.txt 88"
    "./result_6chains/node162_2_2.txt 88"
    "./result_6chains/node162_3_0.txt 87"
    "./result_6chains/node162_3_2.txt 87"
    "./result_6chains/node162_4_0.txt 86"
    "./result_6chains/node162_4_2.txt 86"
    "./result_6chains/node162_5_0.txt 85"
    "./result_6chains/node162_5_2.txt 85"
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
