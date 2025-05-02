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
ros2 run evaluation_3_randomdag uunifast_node -n node385_0_2 -p 257 -st topic385_0_1 -pt None -u 0.007162725644737855 > ./result_6chains/node385_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_1_2 -p 349 -st topic385_1_1 -pt None -u 0.12452061256470809 > ./result_6chains/node385_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_2_2 -p 358 -st topic385_2_1 -pt None -u 0.09420268814283422 > ./result_6chains/node385_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_3_2 -p 521 -st topic385_3_1 -pt None -u 0.039943914615583054 > ./result_6chains/node385_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_4_2 -p 721 -st topic385_4_1 -pt None -u 0.04145756169504741 > ./result_6chains/node385_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_5_2 -p 735 -st topic385_5_1 -pt None -u 0.014046341812417217 > ./result_6chains/node385_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_0_0 -p 257 -st none -pt topic385_0_0 -u 0.020655752504948888 > ./result_6chains/node385_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_1_0 -p 349 -st none -pt topic385_1_0 -u 0.004815089468508393 > ./result_6chains/node385_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_2_0 -p 358 -st none -pt topic385_2_0 -u 0.0023924183084758632 > ./result_6chains/node385_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_3_0 -p 521 -st none -pt topic385_3_0 -u 0.020148729328530735 > ./result_6chains/node385_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_4_0 -p 721 -st none -pt topic385_4_0 -u 0.006900168067009715 > ./result_6chains/node385_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_5_0 -p 735 -st none -pt topic385_5_0 -u 0.004634376138480525 > ./result_6chains/node385_5_0.txt &
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
    "./result_6chains/node385_0_0.txt 90"
    "./result_6chains/node385_0_2.txt 90"
    "./result_6chains/node385_1_0.txt 89"
    "./result_6chains/node385_1_2.txt 89"
    "./result_6chains/node385_2_0.txt 88"
    "./result_6chains/node385_2_2.txt 88"
    "./result_6chains/node385_3_0.txt 87"
    "./result_6chains/node385_3_2.txt 87"
    "./result_6chains/node385_4_0.txt 86"
    "./result_6chains/node385_4_2.txt 86"
    "./result_6chains/node385_5_0.txt 85"
    "./result_6chains/node385_5_2.txt 85"
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
