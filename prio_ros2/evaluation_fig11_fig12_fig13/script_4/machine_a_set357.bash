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
ros2 run evaluation_3_randomdag uunifast_node -n node357_0_2 -p 197 -st topic357_0_1 -pt None -u 0.015131738089994129 > ./result_4chains/node357_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_1_2 -p 604 -st topic357_1_1 -pt None -u 0.11453213579640592 > ./result_4chains/node357_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_2_2 -p 718 -st topic357_2_1 -pt None -u 0.016020146897566145 > ./result_4chains/node357_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_3_2 -p 816 -st topic357_3_1 -pt None -u 0.1882067970950407 > ./result_4chains/node357_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_0_0 -p 197 -st none -pt topic357_0_0 -u 0.02028046481036 > ./result_4chains/node357_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_1_0 -p 604 -st none -pt topic357_1_0 -u 0.03522565981257719 > ./result_4chains/node357_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_2_0 -p 718 -st none -pt topic357_2_0 -u 0.045606116521582696 > ./result_4chains/node357_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_3_0 -p 816 -st none -pt topic357_3_0 -u 0.02205167914314235 > ./result_4chains/node357_3_0.txt &
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
    "./result_4chains/node357_0_0.txt 90"
    "./result_4chains/node357_0_2.txt 90"
    "./result_4chains/node357_1_0.txt 89"
    "./result_4chains/node357_1_2.txt 89"
    "./result_4chains/node357_2_0.txt 88"
    "./result_4chains/node357_2_2.txt 88"
    "./result_4chains/node357_3_0.txt 87"
    "./result_4chains/node357_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
