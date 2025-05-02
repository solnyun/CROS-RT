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
ros2 run evaluation_3_randomdag uunifast_node -n node415_0_2 -p 68 -st topic415_0_1 -pt None -u 0.02001393420966807 > ./result_6chains/node415_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_1_2 -p 117 -st topic415_1_1 -pt None -u 0.07162374821058387 > ./result_6chains/node415_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_2_2 -p 217 -st topic415_2_1 -pt None -u 0.008902319510747214 > ./result_6chains/node415_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_3_2 -p 444 -st topic415_3_1 -pt None -u 0.07408336830153511 > ./result_6chains/node415_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_4_2 -p 755 -st topic415_4_1 -pt None -u 0.015068859238564145 > ./result_6chains/node415_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_5_2 -p 759 -st topic415_5_1 -pt None -u 0.012362905718090813 > ./result_6chains/node415_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_0_0 -p 68 -st none -pt topic415_0_0 -u 0.012440670083298022 > ./result_6chains/node415_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_1_0 -p 117 -st none -pt topic415_1_0 -u 0.022492830717132428 > ./result_6chains/node415_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_2_0 -p 217 -st none -pt topic415_2_0 -u 0.06851463250571532 > ./result_6chains/node415_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_3_0 -p 444 -st none -pt topic415_3_0 -u 0.03450788227317106 > ./result_6chains/node415_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_4_0 -p 755 -st none -pt topic415_4_0 -u 0.00876390930663734 > ./result_6chains/node415_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node415_5_0 -p 759 -st none -pt topic415_5_0 -u 0.00912534031668738 > ./result_6chains/node415_5_0.txt &
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
    "./result_6chains/node415_0_0.txt 90"
    "./result_6chains/node415_0_2.txt 90"
    "./result_6chains/node415_1_0.txt 89"
    "./result_6chains/node415_1_2.txt 89"
    "./result_6chains/node415_2_0.txt 88"
    "./result_6chains/node415_2_2.txt 88"
    "./result_6chains/node415_3_0.txt 87"
    "./result_6chains/node415_3_2.txt 87"
    "./result_6chains/node415_4_0.txt 86"
    "./result_6chains/node415_4_2.txt 86"
    "./result_6chains/node415_5_0.txt 85"
    "./result_6chains/node415_5_2.txt 85"
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
