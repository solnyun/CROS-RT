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
ros2 run evaluation_3_randomdag uunifast_node -n node314_0_2 -p 571 -st topic314_0_1 -pt None -u 0.01390642807251724 > ./result_6chains/node314_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_1_2 -p 668 -st topic314_1_1 -pt None -u 0.030022783590747892 > ./result_6chains/node314_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_2_2 -p 704 -st topic314_2_1 -pt None -u 0.01804844961195856 > ./result_6chains/node314_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_3_2 -p 906 -st topic314_3_1 -pt None -u 0.00561117901128122 > ./result_6chains/node314_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_4_2 -p 907 -st topic314_4_1 -pt None -u 0.022710975365861738 > ./result_6chains/node314_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_5_2 -p 969 -st topic314_5_1 -pt None -u 0.06545277563141134 > ./result_6chains/node314_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_0_0 -p 571 -st none -pt topic314_0_0 -u 0.0151418756873275 > ./result_6chains/node314_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_1_0 -p 668 -st none -pt topic314_1_0 -u 0.04940567144696972 > ./result_6chains/node314_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_2_0 -p 704 -st none -pt topic314_2_0 -u 0.0334966464335959 > ./result_6chains/node314_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_3_0 -p 906 -st none -pt topic314_3_0 -u 0.030532059673420042 > ./result_6chains/node314_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node314_4_0 -p 907 -st none -pt topic314_4_0 -u 0.0853160980507203 > ./result_6chains/node314_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node314_5_0 -p 969 -st none -pt topic314_5_0 -u 0.02413278599741024 > ./result_6chains/node314_5_0.txt &
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
    "./result_6chains/node314_0_0.txt 90"
    "./result_6chains/node314_0_2.txt 90"
    "./result_6chains/node314_1_0.txt 89"
    "./result_6chains/node314_1_2.txt 89"
    "./result_6chains/node314_2_0.txt 88"
    "./result_6chains/node314_2_2.txt 88"
    "./result_6chains/node314_3_0.txt 87"
    "./result_6chains/node314_3_2.txt 87"
    "./result_6chains/node314_4_0.txt 86"
    "./result_6chains/node314_4_2.txt 86"
    "./result_6chains/node314_5_0.txt 85"
    "./result_6chains/node314_5_2.txt 85"
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
