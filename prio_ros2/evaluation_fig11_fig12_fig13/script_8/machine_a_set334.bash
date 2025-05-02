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
ros2 run evaluation_3_randomdag uunifast_node -n node334_0_2 -p 72 -st topic334_0_1 -pt None -u 0.012998631780934855 > ./result_8chains/node334_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_1_2 -p 353 -st topic334_1_1 -pt None -u 0.018667362692260103 > ./result_8chains/node334_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_2_2 -p 381 -st topic334_2_1 -pt None -u 0.04705905437617264 > ./result_8chains/node334_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_3_2 -p 545 -st topic334_3_1 -pt None -u 0.007458471565847669 > ./result_8chains/node334_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_4_2 -p 658 -st topic334_4_1 -pt None -u 0.04830142246725322 > ./result_8chains/node334_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_5_2 -p 697 -st topic334_5_1 -pt None -u 0.013979750937527846 > ./result_8chains/node334_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_6_2 -p 816 -st topic334_6_1 -pt None -u 0.008499068370590251 > ./result_8chains/node334_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_7_2 -p 821 -st topic334_7_1 -pt None -u 0.00016051313068755042 > ./result_8chains/node334_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_0_0 -p 72 -st none -pt topic334_0_0 -u 0.02177375636015444 > ./result_8chains/node334_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_1_0 -p 353 -st none -pt topic334_1_0 -u 0.019841491906632036 > ./result_8chains/node334_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_2_0 -p 381 -st none -pt topic334_2_0 -u 0.005740012719233412 > ./result_8chains/node334_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_3_0 -p 545 -st none -pt topic334_3_0 -u 0.0067621418280737755 > ./result_8chains/node334_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_4_0 -p 658 -st none -pt topic334_4_0 -u 0.0035061194537582274 > ./result_8chains/node334_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_5_0 -p 697 -st none -pt topic334_5_0 -u 0.0032970319403653747 > ./result_8chains/node334_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_6_0 -p 816 -st none -pt topic334_6_0 -u 0.018219795715357576 > ./result_8chains/node334_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node334_7_0 -p 821 -st none -pt topic334_7_0 -u 0.047046010023175086 > ./result_8chains/node334_7_0.txt &
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
    "./result_8chains/node334_0_0.txt 90"
    "./result_8chains/node334_0_2.txt 90"
    "./result_8chains/node334_1_0.txt 89"
    "./result_8chains/node334_1_2.txt 89"
    "./result_8chains/node334_2_0.txt 88"
    "./result_8chains/node334_2_2.txt 88"
    "./result_8chains/node334_3_0.txt 87"
    "./result_8chains/node334_3_2.txt 87"
    "./result_8chains/node334_4_0.txt 86"
    "./result_8chains/node334_4_2.txt 86"
    "./result_8chains/node334_5_0.txt 85"
    "./result_8chains/node334_5_2.txt 85"
    "./result_8chains/node334_6_0.txt 84"
    "./result_8chains/node334_6_2.txt 84"
    "./result_8chains/node334_7_0.txt 83"
    "./result_8chains/node334_7_2.txt 83"
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
