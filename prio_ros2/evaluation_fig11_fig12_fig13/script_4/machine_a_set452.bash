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
ros2 run evaluation_3_randomdag uunifast_node -n node452_0_2 -p 278 -st topic452_0_1 -pt None -u 0.042319351000166594 > ./result_4chains/node452_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_1_2 -p 549 -st topic452_1_1 -pt None -u 0.000736264821120769 > ./result_4chains/node452_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_2_2 -p 729 -st topic452_2_1 -pt None -u 0.030125710435262507 > ./result_4chains/node452_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_3_2 -p 911 -st topic452_3_1 -pt None -u 0.06251769410197049 > ./result_4chains/node452_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_0_0 -p 278 -st none -pt topic452_0_0 -u 0.0926255272726546 > ./result_4chains/node452_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_1_0 -p 549 -st none -pt topic452_1_0 -u 0.04147559474209561 > ./result_4chains/node452_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_2_0 -p 729 -st none -pt topic452_2_0 -u 0.055208768314419926 > ./result_4chains/node452_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node452_3_0 -p 911 -st none -pt topic452_3_0 -u 0.006531613625938362 > ./result_4chains/node452_3_0.txt &
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
    "./result_4chains/node452_0_0.txt 90"
    "./result_4chains/node452_0_2.txt 90"
    "./result_4chains/node452_1_0.txt 89"
    "./result_4chains/node452_1_2.txt 89"
    "./result_4chains/node452_2_0.txt 88"
    "./result_4chains/node452_2_2.txt 88"
    "./result_4chains/node452_3_0.txt 87"
    "./result_4chains/node452_3_2.txt 87"
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
