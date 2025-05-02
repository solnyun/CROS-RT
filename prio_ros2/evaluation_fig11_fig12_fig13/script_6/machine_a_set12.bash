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
ros2 run evaluation_3_randomdag uunifast_node -n node12_0_2 -p 16 -st topic12_0_1 -pt None -u 0.024612896982977417 > ./result_6chains/node12_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_1_2 -p 81 -st topic12_1_1 -pt None -u 0.006740914741718396 > ./result_6chains/node12_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_2_2 -p 86 -st topic12_2_1 -pt None -u 0.06886686934863934 > ./result_6chains/node12_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_3_2 -p 305 -st topic12_3_1 -pt None -u 0.0050239799021941645 > ./result_6chains/node12_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_4_2 -p 738 -st topic12_4_1 -pt None -u 0.03941188948662652 > ./result_6chains/node12_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_5_2 -p 742 -st topic12_5_1 -pt None -u 0.0005728358945290727 > ./result_6chains/node12_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_0_0 -p 16 -st none -pt topic12_0_0 -u 0.00013476627471320501 > ./result_6chains/node12_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_1_0 -p 81 -st none -pt topic12_1_0 -u 0.05135341468760779 > ./result_6chains/node12_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_2_0 -p 86 -st none -pt topic12_2_0 -u 0.07639920492440333 > ./result_6chains/node12_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_3_0 -p 305 -st none -pt topic12_3_0 -u 0.0396197311775566 > ./result_6chains/node12_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node12_4_0 -p 738 -st none -pt topic12_4_0 -u 0.017966087161645827 > ./result_6chains/node12_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node12_5_0 -p 742 -st none -pt topic12_5_0 -u 0.04616253174411877 > ./result_6chains/node12_5_0.txt &
sleep 10
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
    "./result_6chains/node12_0_0.txt 90"
    "./result_6chains/node12_0_2.txt 90"
    "./result_6chains/node12_1_0.txt 89"
    "./result_6chains/node12_1_2.txt 89"
    "./result_6chains/node12_2_0.txt 88"
    "./result_6chains/node12_2_2.txt 88"
    "./result_6chains/node12_3_0.txt 87"
    "./result_6chains/node12_3_2.txt 87"
    "./result_6chains/node12_4_0.txt 86"
    "./result_6chains/node12_4_2.txt 86"
    "./result_6chains/node12_5_0.txt 85"
    "./result_6chains/node12_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
