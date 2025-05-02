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
ros2 run evaluation_3_randomdag uunifast_node -n node264_0_2 -p 13 -st topic264_0_1 -pt None -u 0.08831462281438063 > ./result_6chains/node264_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_1_2 -p 82 -st topic264_1_1 -pt None -u 0.013774400809118736 > ./result_6chains/node264_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_2_2 -p 663 -st topic264_2_1 -pt None -u 0.000287839909603238 > ./result_6chains/node264_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_3_2 -p 726 -st topic264_3_1 -pt None -u 0.08430421882582272 > ./result_6chains/node264_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_4_2 -p 872 -st topic264_4_1 -pt None -u 0.0018722417688820728 > ./result_6chains/node264_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_5_2 -p 992 -st topic264_5_1 -pt None -u 0.009635203653831368 > ./result_6chains/node264_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_0_0 -p 13 -st none -pt topic264_0_0 -u 0.021252389388629722 > ./result_6chains/node264_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_1_0 -p 82 -st none -pt topic264_1_0 -u 0.0034348803322493127 > ./result_6chains/node264_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_2_0 -p 663 -st none -pt topic264_2_0 -u 0.00026108712599870465 > ./result_6chains/node264_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_3_0 -p 726 -st none -pt topic264_3_0 -u 0.08263020912079752 > ./result_6chains/node264_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node264_4_0 -p 872 -st none -pt topic264_4_0 -u 0.0306394459790868 > ./result_6chains/node264_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node264_5_0 -p 992 -st none -pt topic264_5_0 -u 0.036591979357840115 > ./result_6chains/node264_5_0.txt &
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
    "./result_6chains/node264_0_0.txt 90"
    "./result_6chains/node264_0_2.txt 90"
    "./result_6chains/node264_1_0.txt 89"
    "./result_6chains/node264_1_2.txt 89"
    "./result_6chains/node264_2_0.txt 88"
    "./result_6chains/node264_2_2.txt 88"
    "./result_6chains/node264_3_0.txt 87"
    "./result_6chains/node264_3_2.txt 87"
    "./result_6chains/node264_4_0.txt 86"
    "./result_6chains/node264_4_2.txt 86"
    "./result_6chains/node264_5_0.txt 85"
    "./result_6chains/node264_5_2.txt 85"
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
