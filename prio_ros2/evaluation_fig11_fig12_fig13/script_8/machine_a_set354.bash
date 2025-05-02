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
ros2 run evaluation_3_randomdag uunifast_node -n node354_0_2 -p 169 -st topic354_0_1 -pt None -u 0.004514445395760347 > ./result_8chains/node354_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_1_2 -p 345 -st topic354_1_1 -pt None -u 0.009505563179080578 > ./result_8chains/node354_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_2_2 -p 346 -st topic354_2_1 -pt None -u 0.033985940764287015 > ./result_8chains/node354_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_3_2 -p 585 -st topic354_3_1 -pt None -u 0.01538455877793743 > ./result_8chains/node354_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_4_2 -p 588 -st topic354_4_1 -pt None -u 0.0015076315129643747 > ./result_8chains/node354_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_5_2 -p 634 -st topic354_5_1 -pt None -u 0.05038815111189528 > ./result_8chains/node354_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_6_2 -p 928 -st topic354_6_1 -pt None -u 0.02204791901322946 > ./result_8chains/node354_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_7_2 -p 956 -st topic354_7_1 -pt None -u 0.0015869790348999177 > ./result_8chains/node354_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_0_0 -p 169 -st none -pt topic354_0_0 -u 0.008922127236613175 > ./result_8chains/node354_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_1_0 -p 345 -st none -pt topic354_1_0 -u 0.04926080925737747 > ./result_8chains/node354_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_2_0 -p 346 -st none -pt topic354_2_0 -u 0.06280365282970263 > ./result_8chains/node354_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_3_0 -p 585 -st none -pt topic354_3_0 -u 0.05182941984422912 > ./result_8chains/node354_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_4_0 -p 588 -st none -pt topic354_4_0 -u 0.005980509475344231 > ./result_8chains/node354_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_5_0 -p 634 -st none -pt topic354_5_0 -u 0.005251615391454967 > ./result_8chains/node354_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node354_6_0 -p 928 -st none -pt topic354_6_0 -u 0.01048634136841553 > ./result_8chains/node354_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node354_7_0 -p 956 -st none -pt topic354_7_0 -u 0.021777957186204854 > ./result_8chains/node354_7_0.txt &
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
    "./result_8chains/node354_0_0.txt 90"
    "./result_8chains/node354_0_2.txt 90"
    "./result_8chains/node354_1_0.txt 89"
    "./result_8chains/node354_1_2.txt 89"
    "./result_8chains/node354_2_0.txt 88"
    "./result_8chains/node354_2_2.txt 88"
    "./result_8chains/node354_3_0.txt 87"
    "./result_8chains/node354_3_2.txt 87"
    "./result_8chains/node354_4_0.txt 86"
    "./result_8chains/node354_4_2.txt 86"
    "./result_8chains/node354_5_0.txt 85"
    "./result_8chains/node354_5_2.txt 85"
    "./result_8chains/node354_6_0.txt 84"
    "./result_8chains/node354_6_2.txt 84"
    "./result_8chains/node354_7_0.txt 83"
    "./result_8chains/node354_7_2.txt 83"
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
