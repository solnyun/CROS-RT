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
ros2 run evaluation_3_randomdag uunifast_node -n node171_0_2 -p 105 -st topic171_0_1 -pt None -u 0.00786259778132925 > ./result_6chains/node171_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_1_2 -p 191 -st topic171_1_1 -pt None -u 0.0052745610944882615 > ./result_6chains/node171_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_2_2 -p 240 -st topic171_2_1 -pt None -u 0.031365848605609425 > ./result_6chains/node171_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_3_2 -p 327 -st topic171_3_1 -pt None -u 0.012826213286139587 > ./result_6chains/node171_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_4_2 -p 604 -st topic171_4_1 -pt None -u 0.008432754015494454 > ./result_6chains/node171_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_5_2 -p 827 -st topic171_5_1 -pt None -u 0.06181565744634721 > ./result_6chains/node171_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_0_0 -p 105 -st none -pt topic171_0_0 -u 0.0009496147667961141 > ./result_6chains/node171_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_1_0 -p 191 -st none -pt topic171_1_0 -u 0.023180975908006163 > ./result_6chains/node171_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_2_0 -p 240 -st none -pt topic171_2_0 -u 0.02356151426594094 > ./result_6chains/node171_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_3_0 -p 327 -st none -pt topic171_3_0 -u 0.10010083444872153 > ./result_6chains/node171_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_4_0 -p 604 -st none -pt topic171_4_0 -u 0.04274625317982886 > ./result_6chains/node171_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_5_0 -p 827 -st none -pt topic171_5_0 -u 0.0018628322358559823 > ./result_6chains/node171_5_0.txt &
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
    "./result_6chains/node171_0_0.txt 90"
    "./result_6chains/node171_0_2.txt 90"
    "./result_6chains/node171_1_0.txt 89"
    "./result_6chains/node171_1_2.txt 89"
    "./result_6chains/node171_2_0.txt 88"
    "./result_6chains/node171_2_2.txt 88"
    "./result_6chains/node171_3_0.txt 87"
    "./result_6chains/node171_3_2.txt 87"
    "./result_6chains/node171_4_0.txt 86"
    "./result_6chains/node171_4_2.txt 86"
    "./result_6chains/node171_5_0.txt 85"
    "./result_6chains/node171_5_2.txt 85"
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
