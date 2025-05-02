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
ros2 run evaluation_3_randomdag uunifast_node -n node382_0_2 -p 39 -st topic382_0_1 -pt None -u 0.02490637100279952 > ./result_6chains/node382_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_1_2 -p 133 -st topic382_1_1 -pt None -u 0.007850636779409115 > ./result_6chains/node382_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_2_2 -p 165 -st topic382_2_1 -pt None -u 0.016815713748000227 > ./result_6chains/node382_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_3_2 -p 460 -st topic382_3_1 -pt None -u 0.06518456636690631 > ./result_6chains/node382_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_4_2 -p 784 -st topic382_4_1 -pt None -u 0.03767442939361107 > ./result_6chains/node382_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_5_2 -p 899 -st topic382_5_1 -pt None -u 0.06517531739340074 > ./result_6chains/node382_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_0_0 -p 39 -st none -pt topic382_0_0 -u 0.029348465901308962 > ./result_6chains/node382_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_1_0 -p 133 -st none -pt topic382_1_0 -u 0.001240702276288197 > ./result_6chains/node382_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_2_0 -p 165 -st none -pt topic382_2_0 -u 0.02907570659500125 > ./result_6chains/node382_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_3_0 -p 460 -st none -pt topic382_3_0 -u 0.028764250286817283 > ./result_6chains/node382_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_4_0 -p 784 -st none -pt topic382_4_0 -u 0.04323572753038235 > ./result_6chains/node382_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_5_0 -p 899 -st none -pt topic382_5_0 -u 0.020648535976717383 > ./result_6chains/node382_5_0.txt &
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
    "./result_6chains/node382_0_0.txt 90"
    "./result_6chains/node382_0_2.txt 90"
    "./result_6chains/node382_1_0.txt 89"
    "./result_6chains/node382_1_2.txt 89"
    "./result_6chains/node382_2_0.txt 88"
    "./result_6chains/node382_2_2.txt 88"
    "./result_6chains/node382_3_0.txt 87"
    "./result_6chains/node382_3_2.txt 87"
    "./result_6chains/node382_4_0.txt 86"
    "./result_6chains/node382_4_2.txt 86"
    "./result_6chains/node382_5_0.txt 85"
    "./result_6chains/node382_5_2.txt 85"
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
