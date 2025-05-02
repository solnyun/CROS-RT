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
ros2 run evaluation_3_randomdag uunifast_node -n node63_0_2 -p 153 -st topic63_0_1 -pt None -u 0.0035281663930479823 > ./result_10chains/node63_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_1_2 -p 159 -st topic63_1_1 -pt None -u 0.016274408719108457 > ./result_10chains/node63_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_2_2 -p 169 -st topic63_2_1 -pt None -u 0.04683042832002238 > ./result_10chains/node63_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_3_2 -p 227 -st topic63_3_1 -pt None -u 0.03381914104886996 > ./result_10chains/node63_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_4_2 -p 297 -st topic63_4_1 -pt None -u 0.0008750099179010151 > ./result_10chains/node63_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_5_2 -p 467 -st topic63_5_1 -pt None -u 0.037396901615780936 > ./result_10chains/node63_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_6_2 -p 579 -st topic63_6_1 -pt None -u 0.009325987789335355 > ./result_10chains/node63_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_7_2 -p 686 -st topic63_7_1 -pt None -u 0.016576402134815066 > ./result_10chains/node63_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_8_2 -p 876 -st topic63_8_1 -pt None -u 0.007675182637004285 > ./result_10chains/node63_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_9_2 -p 951 -st topic63_9_1 -pt None -u 0.01289536919024199 > ./result_10chains/node63_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_0_0 -p 153 -st none -pt topic63_0_0 -u 0.0008401036091462699 > ./result_10chains/node63_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_1_0 -p 159 -st none -pt topic63_1_0 -u 0.007096393395851608 > ./result_10chains/node63_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_2_0 -p 169 -st none -pt topic63_2_0 -u 0.008106990184121532 > ./result_10chains/node63_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_3_0 -p 227 -st none -pt topic63_3_0 -u 0.0029591201312359483 > ./result_10chains/node63_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_4_0 -p 297 -st none -pt topic63_4_0 -u 0.016665689744346623 > ./result_10chains/node63_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_5_0 -p 467 -st none -pt topic63_5_0 -u 0.0024085034370742164 > ./result_10chains/node63_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_6_0 -p 579 -st none -pt topic63_6_0 -u 0.008395896117145585 > ./result_10chains/node63_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_7_0 -p 686 -st none -pt topic63_7_0 -u 0.05045704020824948 > ./result_10chains/node63_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node63_8_0 -p 876 -st none -pt topic63_8_0 -u 0.012761074546549345 > ./result_10chains/node63_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node63_9_0 -p 951 -st none -pt topic63_9_0 -u 0.015748400078189274 > ./result_10chains/node63_9_0.txt &
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
    "./result_10chains/node63_0_0.txt 90"
    "./result_10chains/node63_0_2.txt 90"
    "./result_10chains/node63_1_0.txt 89"
    "./result_10chains/node63_1_2.txt 89"
    "./result_10chains/node63_2_0.txt 88"
    "./result_10chains/node63_2_2.txt 88"
    "./result_10chains/node63_3_0.txt 87"
    "./result_10chains/node63_3_2.txt 87"
    "./result_10chains/node63_4_0.txt 86"
    "./result_10chains/node63_4_2.txt 86"
    "./result_10chains/node63_5_0.txt 85"
    "./result_10chains/node63_5_2.txt 85"
    "./result_10chains/node63_6_0.txt 84"
    "./result_10chains/node63_6_2.txt 84"
    "./result_10chains/node63_7_0.txt 83"
    "./result_10chains/node63_7_2.txt 83"
    "./result_10chains/node63_8_0.txt 82"
    "./result_10chains/node63_8_2.txt 82"
    "./result_10chains/node63_9_0.txt 81"
    "./result_10chains/node63_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
