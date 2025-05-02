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
ros2 run evaluation_3_randomdag uunifast_node -n node85_0_2 -p 294 -st topic85_0_1 -pt None -u 0.0015186127050451637 > ./result_6chains/node85_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_1_2 -p 481 -st topic85_1_1 -pt None -u 0.04149704775722579 > ./result_6chains/node85_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_2_2 -p 568 -st topic85_2_1 -pt None -u 0.09859081559357191 > ./result_6chains/node85_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_3_2 -p 625 -st topic85_3_1 -pt None -u 0.00688277881944882 > ./result_6chains/node85_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_4_2 -p 700 -st topic85_4_1 -pt None -u 0.004219771572675224 > ./result_6chains/node85_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_5_2 -p 947 -st topic85_5_1 -pt None -u 0.029258018846731754 > ./result_6chains/node85_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_0_0 -p 294 -st none -pt topic85_0_0 -u 0.014719467295805866 > ./result_6chains/node85_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_1_0 -p 481 -st none -pt topic85_1_0 -u 0.009109691414347532 > ./result_6chains/node85_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_2_0 -p 568 -st none -pt topic85_2_0 -u 0.0010192909843916853 > ./result_6chains/node85_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_3_0 -p 625 -st none -pt topic85_3_0 -u 0.003281736797232482 > ./result_6chains/node85_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node85_4_0 -p 700 -st none -pt topic85_4_0 -u 0.0060371609805991155 > ./result_6chains/node85_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node85_5_0 -p 947 -st none -pt topic85_5_0 -u 0.10058499223903247 > ./result_6chains/node85_5_0.txt &
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
    "./result_6chains/node85_0_0.txt 90"
    "./result_6chains/node85_0_2.txt 90"
    "./result_6chains/node85_1_0.txt 89"
    "./result_6chains/node85_1_2.txt 89"
    "./result_6chains/node85_2_0.txt 88"
    "./result_6chains/node85_2_2.txt 88"
    "./result_6chains/node85_3_0.txt 87"
    "./result_6chains/node85_3_2.txt 87"
    "./result_6chains/node85_4_0.txt 86"
    "./result_6chains/node85_4_2.txt 86"
    "./result_6chains/node85_5_0.txt 85"
    "./result_6chains/node85_5_2.txt 85"
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
