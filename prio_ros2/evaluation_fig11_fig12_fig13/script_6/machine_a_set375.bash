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
ros2 run evaluation_3_randomdag uunifast_node -n node375_0_2 -p 61 -st topic375_0_1 -pt None -u 0.04313911495046302 > ./result_6chains/node375_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_1_2 -p 356 -st topic375_1_1 -pt None -u 0.0899771470605421 > ./result_6chains/node375_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_2_2 -p 442 -st topic375_2_1 -pt None -u 0.055840907479195734 > ./result_6chains/node375_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_3_2 -p 467 -st topic375_3_1 -pt None -u 0.013419050436107277 > ./result_6chains/node375_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_4_2 -p 498 -st topic375_4_1 -pt None -u 0.0490371677265838 > ./result_6chains/node375_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_5_2 -p 935 -st topic375_5_1 -pt None -u 0.001209428585413686 > ./result_6chains/node375_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_0_0 -p 61 -st none -pt topic375_0_0 -u 0.042920866590188345 > ./result_6chains/node375_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_1_0 -p 356 -st none -pt topic375_1_0 -u 0.028893696371951494 > ./result_6chains/node375_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_2_0 -p 442 -st none -pt topic375_2_0 -u 0.0004960936540688299 > ./result_6chains/node375_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_3_0 -p 467 -st none -pt topic375_3_0 -u 0.022509087762805857 > ./result_6chains/node375_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node375_4_0 -p 498 -st none -pt topic375_4_0 -u 0.025897565736296715 > ./result_6chains/node375_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node375_5_0 -p 935 -st none -pt topic375_5_0 -u 0.012358373087687644 > ./result_6chains/node375_5_0.txt &
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
    "./result_6chains/node375_0_0.txt 90"
    "./result_6chains/node375_0_2.txt 90"
    "./result_6chains/node375_1_0.txt 89"
    "./result_6chains/node375_1_2.txt 89"
    "./result_6chains/node375_2_0.txt 88"
    "./result_6chains/node375_2_2.txt 88"
    "./result_6chains/node375_3_0.txt 87"
    "./result_6chains/node375_3_2.txt 87"
    "./result_6chains/node375_4_0.txt 86"
    "./result_6chains/node375_4_2.txt 86"
    "./result_6chains/node375_5_0.txt 85"
    "./result_6chains/node375_5_2.txt 85"
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
