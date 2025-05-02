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
ros2 run evaluation_3_randomdag uunifast_node -n node186_0_2 -p 101 -st topic186_0_1 -pt None -u 0.0416601784082794 > ./result_8chains/node186_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_1_2 -p 257 -st topic186_1_1 -pt None -u 0.0019507437952206441 > ./result_8chains/node186_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_2_2 -p 484 -st topic186_2_1 -pt None -u 0.012370220390789166 > ./result_8chains/node186_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_3_2 -p 551 -st topic186_3_1 -pt None -u 0.004115647041230519 > ./result_8chains/node186_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_4_2 -p 723 -st topic186_4_1 -pt None -u 0.03658675560349911 > ./result_8chains/node186_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_5_2 -p 858 -st topic186_5_1 -pt None -u 0.04316718712359205 > ./result_8chains/node186_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_6_2 -p 866 -st topic186_6_1 -pt None -u 0.006612095458522621 > ./result_8chains/node186_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_7_2 -p 936 -st topic186_7_1 -pt None -u 0.03424707375509933 > ./result_8chains/node186_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_0_0 -p 101 -st none -pt topic186_0_0 -u 0.00020306374107742498 > ./result_8chains/node186_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_1_0 -p 257 -st none -pt topic186_1_0 -u 0.009298013121996074 > ./result_8chains/node186_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_2_0 -p 484 -st none -pt topic186_2_0 -u 0.00590689133660427 > ./result_8chains/node186_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_3_0 -p 551 -st none -pt topic186_3_0 -u 0.04355159788655616 > ./result_8chains/node186_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_4_0 -p 723 -st none -pt topic186_4_0 -u 0.018781046407186808 > ./result_8chains/node186_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_5_0 -p 858 -st none -pt topic186_5_0 -u 0.0040715979299962846 > ./result_8chains/node186_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_6_0 -p 866 -st none -pt topic186_6_0 -u 0.028845505470558197 > ./result_8chains/node186_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_7_0 -p 936 -st none -pt topic186_7_0 -u 0.05007848810419291 > ./result_8chains/node186_7_0.txt &
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
    "./result_8chains/node186_0_0.txt 90"
    "./result_8chains/node186_0_2.txt 90"
    "./result_8chains/node186_1_0.txt 89"
    "./result_8chains/node186_1_2.txt 89"
    "./result_8chains/node186_2_0.txt 88"
    "./result_8chains/node186_2_2.txt 88"
    "./result_8chains/node186_3_0.txt 87"
    "./result_8chains/node186_3_2.txt 87"
    "./result_8chains/node186_4_0.txt 86"
    "./result_8chains/node186_4_2.txt 86"
    "./result_8chains/node186_5_0.txt 85"
    "./result_8chains/node186_5_2.txt 85"
    "./result_8chains/node186_6_0.txt 84"
    "./result_8chains/node186_6_2.txt 84"
    "./result_8chains/node186_7_0.txt 83"
    "./result_8chains/node186_7_2.txt 83"
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
