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
ros2 run evaluation_3_randomdag uunifast_node -n node220_0_2 -p 83 -st topic220_0_1 -pt None -u 0.0040183329503663545 > ./result_6chains/node220_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_1_2 -p 88 -st topic220_1_1 -pt None -u 0.04702778753191039 > ./result_6chains/node220_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_2_2 -p 532 -st topic220_2_1 -pt None -u 0.03894272216099243 > ./result_6chains/node220_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_3_2 -p 724 -st topic220_3_1 -pt None -u 0.0015845944924848254 > ./result_6chains/node220_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_4_2 -p 818 -st topic220_4_1 -pt None -u 0.017167139708473736 > ./result_6chains/node220_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_5_2 -p 979 -st topic220_5_1 -pt None -u 0.041092921360826914 > ./result_6chains/node220_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_0_0 -p 83 -st none -pt topic220_0_0 -u 0.0008775504664398914 > ./result_6chains/node220_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_1_0 -p 88 -st none -pt topic220_1_0 -u 0.0014101599651946128 > ./result_6chains/node220_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_2_0 -p 532 -st none -pt topic220_2_0 -u 0.02124504146347328 > ./result_6chains/node220_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_3_0 -p 724 -st none -pt topic220_3_0 -u 0.03667031843571794 > ./result_6chains/node220_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_4_0 -p 818 -st none -pt topic220_4_0 -u 0.0418996669184345 > ./result_6chains/node220_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_5_0 -p 979 -st none -pt topic220_5_0 -u 0.0067560928685199695 > ./result_6chains/node220_5_0.txt &
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
    "./result_6chains/node220_0_0.txt 90"
    "./result_6chains/node220_0_2.txt 90"
    "./result_6chains/node220_1_0.txt 89"
    "./result_6chains/node220_1_2.txt 89"
    "./result_6chains/node220_2_0.txt 88"
    "./result_6chains/node220_2_2.txt 88"
    "./result_6chains/node220_3_0.txt 87"
    "./result_6chains/node220_3_2.txt 87"
    "./result_6chains/node220_4_0.txt 86"
    "./result_6chains/node220_4_2.txt 86"
    "./result_6chains/node220_5_0.txt 85"
    "./result_6chains/node220_5_2.txt 85"
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
