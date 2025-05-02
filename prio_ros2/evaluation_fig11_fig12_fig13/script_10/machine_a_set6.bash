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
ros2 run evaluation_3_randomdag uunifast_node -n node6_0_2 -p 455 -st topic6_0_1 -pt None -u 0.0001220964680254677 > ./result_10chains/node6_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_1_2 -p 508 -st topic6_1_1 -pt None -u 0.004744560804332942 > ./result_10chains/node6_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_2_2 -p 622 -st topic6_2_1 -pt None -u 0.04210557812075605 > ./result_10chains/node6_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_3_2 -p 673 -st topic6_3_1 -pt None -u 0.018766289876007036 > ./result_10chains/node6_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_4_2 -p 678 -st topic6_4_1 -pt None -u 0.02752684941602454 > ./result_10chains/node6_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_5_2 -p 715 -st topic6_5_1 -pt None -u 0.003151039664650912 > ./result_10chains/node6_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_6_2 -p 734 -st topic6_6_1 -pt None -u 0.0007269530211193309 > ./result_10chains/node6_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_7_2 -p 741 -st topic6_7_1 -pt None -u 0.0029723476995084236 > ./result_10chains/node6_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_8_2 -p 924 -st topic6_8_1 -pt None -u 0.000440446432690797 > ./result_10chains/node6_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_9_2 -p 956 -st topic6_9_1 -pt None -u 0.0038734086633713076 > ./result_10chains/node6_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_0_0 -p 455 -st none -pt topic6_0_0 -u 0.015973064547243843 > ./result_10chains/node6_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_1_0 -p 508 -st none -pt topic6_1_0 -u 0.019442879234599142 > ./result_10chains/node6_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_2_0 -p 622 -st none -pt topic6_2_0 -u 0.002235988511673337 > ./result_10chains/node6_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_3_0 -p 673 -st none -pt topic6_3_0 -u 0.00525100451047944 > ./result_10chains/node6_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_4_0 -p 678 -st none -pt topic6_4_0 -u 0.002523941592260659 > ./result_10chains/node6_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_5_0 -p 715 -st none -pt topic6_5_0 -u 0.017203779368651556 > ./result_10chains/node6_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_6_0 -p 734 -st none -pt topic6_6_0 -u 0.0663018938545538 > ./result_10chains/node6_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_7_0 -p 741 -st none -pt topic6_7_0 -u 0.004858309318799756 > ./result_10chains/node6_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_8_0 -p 924 -st none -pt topic6_8_0 -u 0.0007017587185096305 > ./result_10chains/node6_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_9_0 -p 956 -st none -pt topic6_9_0 -u 0.02299124657562947 > ./result_10chains/node6_9_0.txt &
sleep 10
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
    "./result_10chains/node6_0_0.txt 90"
    "./result_10chains/node6_0_2.txt 90"
    "./result_10chains/node6_1_0.txt 89"
    "./result_10chains/node6_1_2.txt 89"
    "./result_10chains/node6_2_0.txt 88"
    "./result_10chains/node6_2_2.txt 88"
    "./result_10chains/node6_3_0.txt 87"
    "./result_10chains/node6_3_2.txt 87"
    "./result_10chains/node6_4_0.txt 86"
    "./result_10chains/node6_4_2.txt 86"
    "./result_10chains/node6_5_0.txt 85"
    "./result_10chains/node6_5_2.txt 85"
    "./result_10chains/node6_6_0.txt 84"
    "./result_10chains/node6_6_2.txt 84"
    "./result_10chains/node6_7_0.txt 83"
    "./result_10chains/node6_7_2.txt 83"
    "./result_10chains/node6_8_0.txt 82"
    "./result_10chains/node6_8_2.txt 82"
    "./result_10chains/node6_9_0.txt 81"
    "./result_10chains/node6_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
