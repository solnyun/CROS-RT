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
ros2 run evaluation_3_randomdag uunifast_node -n node274_0_2 -p 55 -st topic274_0_1 -pt None -u 0.014106385581888148 > ./result_6chains/node274_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_1_2 -p 734 -st topic274_1_1 -pt None -u 0.01852826480151909 > ./result_6chains/node274_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_2_2 -p 869 -st topic274_2_1 -pt None -u 0.018681159332571196 > ./result_6chains/node274_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_3_2 -p 902 -st topic274_3_1 -pt None -u 0.009379690365533211 > ./result_6chains/node274_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_4_2 -p 933 -st topic274_4_1 -pt None -u 0.04077360637194903 > ./result_6chains/node274_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_5_2 -p 950 -st topic274_5_1 -pt None -u 0.02126224720107271 > ./result_6chains/node274_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_0_0 -p 55 -st none -pt topic274_0_0 -u 0.03622174515430843 > ./result_6chains/node274_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_1_0 -p 734 -st none -pt topic274_1_0 -u 0.011873039524346651 > ./result_6chains/node274_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_2_0 -p 869 -st none -pt topic274_2_0 -u 0.012820488914356387 > ./result_6chains/node274_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_3_0 -p 902 -st none -pt topic274_3_0 -u 0.025263073930692076 > ./result_6chains/node274_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_4_0 -p 933 -st none -pt topic274_4_0 -u 0.04781214964754979 > ./result_6chains/node274_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_5_0 -p 950 -st none -pt topic274_5_0 -u 0.0005597821326487895 > ./result_6chains/node274_5_0.txt &
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
    "./result_6chains/node274_0_0.txt 90"
    "./result_6chains/node274_0_2.txt 90"
    "./result_6chains/node274_1_0.txt 89"
    "./result_6chains/node274_1_2.txt 89"
    "./result_6chains/node274_2_0.txt 88"
    "./result_6chains/node274_2_2.txt 88"
    "./result_6chains/node274_3_0.txt 87"
    "./result_6chains/node274_3_2.txt 87"
    "./result_6chains/node274_4_0.txt 86"
    "./result_6chains/node274_4_2.txt 86"
    "./result_6chains/node274_5_0.txt 85"
    "./result_6chains/node274_5_2.txt 85"
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
