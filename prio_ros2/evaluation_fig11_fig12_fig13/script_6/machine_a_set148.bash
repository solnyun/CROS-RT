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
ros2 run evaluation_3_randomdag uunifast_node -n node148_0_2 -p 14 -st topic148_0_1 -pt None -u 0.026396887080093967 > ./result_6chains/node148_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_1_2 -p 424 -st topic148_1_1 -pt None -u 0.06287691656526573 > ./result_6chains/node148_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_2_2 -p 663 -st topic148_2_1 -pt None -u 0.03222558147932633 > ./result_6chains/node148_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_3_2 -p 770 -st topic148_3_1 -pt None -u 0.013167897154451352 > ./result_6chains/node148_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_4_2 -p 893 -st topic148_4_1 -pt None -u 0.003487802132356832 > ./result_6chains/node148_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_5_2 -p 933 -st topic148_5_1 -pt None -u 0.046148958450578245 > ./result_6chains/node148_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_0_0 -p 14 -st none -pt topic148_0_0 -u 0.017652256399914357 > ./result_6chains/node148_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_1_0 -p 424 -st none -pt topic148_1_0 -u 0.02509774558516986 > ./result_6chains/node148_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_2_0 -p 663 -st none -pt topic148_2_0 -u 0.06135327414115843 > ./result_6chains/node148_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_3_0 -p 770 -st none -pt topic148_3_0 -u 0.0029992127053442563 > ./result_6chains/node148_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node148_4_0 -p 893 -st none -pt topic148_4_0 -u 0.045884589294184736 > ./result_6chains/node148_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node148_5_0 -p 933 -st none -pt topic148_5_0 -u 0.007080547894282849 > ./result_6chains/node148_5_0.txt &
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
    "./result_6chains/node148_0_0.txt 90"
    "./result_6chains/node148_0_2.txt 90"
    "./result_6chains/node148_1_0.txt 89"
    "./result_6chains/node148_1_2.txt 89"
    "./result_6chains/node148_2_0.txt 88"
    "./result_6chains/node148_2_2.txt 88"
    "./result_6chains/node148_3_0.txt 87"
    "./result_6chains/node148_3_2.txt 87"
    "./result_6chains/node148_4_0.txt 86"
    "./result_6chains/node148_4_2.txt 86"
    "./result_6chains/node148_5_0.txt 85"
    "./result_6chains/node148_5_2.txt 85"
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
