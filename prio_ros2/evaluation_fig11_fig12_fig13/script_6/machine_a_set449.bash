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
ros2 run evaluation_3_randomdag uunifast_node -n node449_0_2 -p 34 -st topic449_0_1 -pt None -u 0.02548448794708319 > ./result_6chains/node449_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_1_2 -p 63 -st topic449_1_1 -pt None -u 0.003689575636410203 > ./result_6chains/node449_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_2_2 -p 304 -st topic449_2_1 -pt None -u 0.06481380003765536 > ./result_6chains/node449_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_3_2 -p 708 -st topic449_3_1 -pt None -u 0.0501187827969945 > ./result_6chains/node449_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_4_2 -p 790 -st topic449_4_1 -pt None -u 0.047109805231430185 > ./result_6chains/node449_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_5_2 -p 929 -st topic449_5_1 -pt None -u 0.0589230391565217 > ./result_6chains/node449_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_0_0 -p 34 -st none -pt topic449_0_0 -u 0.023604056056711953 > ./result_6chains/node449_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_1_0 -p 63 -st none -pt topic449_1_0 -u 0.0034733312898193036 > ./result_6chains/node449_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_2_0 -p 304 -st none -pt topic449_2_0 -u 0.0005866798424367103 > ./result_6chains/node449_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_3_0 -p 708 -st none -pt topic449_3_0 -u 0.027075270954624142 > ./result_6chains/node449_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_4_0 -p 790 -st none -pt topic449_4_0 -u 0.012561162655664093 > ./result_6chains/node449_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_5_0 -p 929 -st none -pt topic449_5_0 -u 0.018208540941958715 > ./result_6chains/node449_5_0.txt &
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
    "./result_6chains/node449_0_0.txt 90"
    "./result_6chains/node449_0_2.txt 90"
    "./result_6chains/node449_1_0.txt 89"
    "./result_6chains/node449_1_2.txt 89"
    "./result_6chains/node449_2_0.txt 88"
    "./result_6chains/node449_2_2.txt 88"
    "./result_6chains/node449_3_0.txt 87"
    "./result_6chains/node449_3_2.txt 87"
    "./result_6chains/node449_4_0.txt 86"
    "./result_6chains/node449_4_2.txt 86"
    "./result_6chains/node449_5_0.txt 85"
    "./result_6chains/node449_5_2.txt 85"
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
