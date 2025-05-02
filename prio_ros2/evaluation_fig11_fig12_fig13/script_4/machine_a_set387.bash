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
ros2 run evaluation_3_randomdag uunifast_node -n node387_0_2 -p 386 -st topic387_0_1 -pt None -u 0.11437072957561728 > ./result_4chains/node387_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_1_2 -p 670 -st topic387_1_1 -pt None -u 0.008395995015466062 > ./result_4chains/node387_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_2_2 -p 727 -st topic387_2_1 -pt None -u 0.010812643075427175 > ./result_4chains/node387_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_3_2 -p 858 -st topic387_3_1 -pt None -u 0.03299894938133479 > ./result_4chains/node387_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_0_0 -p 386 -st none -pt topic387_0_0 -u 0.020123746178500435 > ./result_4chains/node387_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_1_0 -p 670 -st none -pt topic387_1_0 -u 0.08357634436066547 > ./result_4chains/node387_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node387_2_0 -p 727 -st none -pt topic387_2_0 -u 0.16416131774162857 > ./result_4chains/node387_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node387_3_0 -p 858 -st none -pt topic387_3_0 -u 0.030238699097347402 > ./result_4chains/node387_3_0.txt &
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
    "./result_4chains/node387_0_0.txt 90"
    "./result_4chains/node387_0_2.txt 90"
    "./result_4chains/node387_1_0.txt 89"
    "./result_4chains/node387_1_2.txt 89"
    "./result_4chains/node387_2_0.txt 88"
    "./result_4chains/node387_2_2.txt 88"
    "./result_4chains/node387_3_0.txt 87"
    "./result_4chains/node387_3_2.txt 87"
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
