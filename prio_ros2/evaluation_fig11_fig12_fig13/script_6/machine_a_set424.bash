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
ros2 run evaluation_3_randomdag uunifast_node -n node424_0_2 -p 75 -st topic424_0_1 -pt None -u 0.0051341752421882325 > ./result_6chains/node424_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_1_2 -p 210 -st topic424_1_1 -pt None -u 0.05744169787645381 > ./result_6chains/node424_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_2_2 -p 516 -st topic424_2_1 -pt None -u 0.005798860069339162 > ./result_6chains/node424_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_3_2 -p 588 -st topic424_3_1 -pt None -u 0.007943734796792556 > ./result_6chains/node424_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_4_2 -p 714 -st topic424_4_1 -pt None -u 0.018348359555308086 > ./result_6chains/node424_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_5_2 -p 989 -st topic424_5_1 -pt None -u 0.00590011387352575 > ./result_6chains/node424_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_0_0 -p 75 -st none -pt topic424_0_0 -u 0.02697612810807548 > ./result_6chains/node424_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_1_0 -p 210 -st none -pt topic424_1_0 -u 0.016448781246074795 > ./result_6chains/node424_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_2_0 -p 516 -st none -pt topic424_2_0 -u 0.037773609521189105 > ./result_6chains/node424_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_3_0 -p 588 -st none -pt topic424_3_0 -u 0.03921297723224257 > ./result_6chains/node424_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_4_0 -p 714 -st none -pt topic424_4_0 -u 0.00344521309248888 > ./result_6chains/node424_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_5_0 -p 989 -st none -pt topic424_5_0 -u 0.007903222126655757 > ./result_6chains/node424_5_0.txt &
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
    "./result_6chains/node424_0_0.txt 90"
    "./result_6chains/node424_0_2.txt 90"
    "./result_6chains/node424_1_0.txt 89"
    "./result_6chains/node424_1_2.txt 89"
    "./result_6chains/node424_2_0.txt 88"
    "./result_6chains/node424_2_2.txt 88"
    "./result_6chains/node424_3_0.txt 87"
    "./result_6chains/node424_3_2.txt 87"
    "./result_6chains/node424_4_0.txt 86"
    "./result_6chains/node424_4_2.txt 86"
    "./result_6chains/node424_5_0.txt 85"
    "./result_6chains/node424_5_2.txt 85"
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
