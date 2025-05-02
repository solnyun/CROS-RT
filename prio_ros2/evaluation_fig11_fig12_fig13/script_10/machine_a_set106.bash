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
ros2 run evaluation_3_randomdag uunifast_node -n node106_0_2 -p 18 -st topic106_0_1 -pt None -u 0.0010210723577686598 > ./result_10chains/node106_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_1_2 -p 117 -st topic106_1_1 -pt None -u 0.013098622257598558 > ./result_10chains/node106_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_2_2 -p 375 -st topic106_2_1 -pt None -u 0.002051044610758168 > ./result_10chains/node106_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_3_2 -p 440 -st topic106_3_1 -pt None -u 0.02060259299096695 > ./result_10chains/node106_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_4_2 -p 454 -st topic106_4_1 -pt None -u 0.007809756540881285 > ./result_10chains/node106_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_5_2 -p 466 -st topic106_5_1 -pt None -u 0.03964037554230987 > ./result_10chains/node106_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_6_2 -p 626 -st topic106_6_1 -pt None -u 0.046476446139375904 > ./result_10chains/node106_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_7_2 -p 783 -st topic106_7_1 -pt None -u 0.0065997932931616266 > ./result_10chains/node106_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_8_2 -p 803 -st topic106_8_1 -pt None -u 9.933214511007038e-05 > ./result_10chains/node106_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_9_2 -p 853 -st topic106_9_1 -pt None -u 0.011827511545278857 > ./result_10chains/node106_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_0_0 -p 18 -st none -pt topic106_0_0 -u 0.008166546476569447 > ./result_10chains/node106_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_1_0 -p 117 -st none -pt topic106_1_0 -u 0.025810295088580404 > ./result_10chains/node106_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_2_0 -p 375 -st none -pt topic106_2_0 -u 0.0015928216326614453 > ./result_10chains/node106_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_3_0 -p 440 -st none -pt topic106_3_0 -u 0.01378544733636261 > ./result_10chains/node106_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_4_0 -p 454 -st none -pt topic106_4_0 -u 0.015015696232728581 > ./result_10chains/node106_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_5_0 -p 466 -st none -pt topic106_5_0 -u 0.012060475332316412 > ./result_10chains/node106_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_6_0 -p 626 -st none -pt topic106_6_0 -u 0.029294032522613117 > ./result_10chains/node106_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_7_0 -p 783 -st none -pt topic106_7_0 -u 0.006940230233129369 > ./result_10chains/node106_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node106_8_0 -p 803 -st none -pt topic106_8_0 -u 0.031822275106952735 > ./result_10chains/node106_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node106_9_0 -p 853 -st none -pt topic106_9_0 -u 0.0032545969730565782 > ./result_10chains/node106_9_0.txt &
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
    "./result_10chains/node106_0_0.txt 90"
    "./result_10chains/node106_0_2.txt 90"
    "./result_10chains/node106_1_0.txt 89"
    "./result_10chains/node106_1_2.txt 89"
    "./result_10chains/node106_2_0.txt 88"
    "./result_10chains/node106_2_2.txt 88"
    "./result_10chains/node106_3_0.txt 87"
    "./result_10chains/node106_3_2.txt 87"
    "./result_10chains/node106_4_0.txt 86"
    "./result_10chains/node106_4_2.txt 86"
    "./result_10chains/node106_5_0.txt 85"
    "./result_10chains/node106_5_2.txt 85"
    "./result_10chains/node106_6_0.txt 84"
    "./result_10chains/node106_6_2.txt 84"
    "./result_10chains/node106_7_0.txt 83"
    "./result_10chains/node106_7_2.txt 83"
    "./result_10chains/node106_8_0.txt 82"
    "./result_10chains/node106_8_2.txt 82"
    "./result_10chains/node106_9_0.txt 81"
    "./result_10chains/node106_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
