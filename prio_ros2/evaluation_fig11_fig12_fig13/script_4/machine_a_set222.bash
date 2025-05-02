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
ros2 run evaluation_3_randomdag uunifast_node -n node222_0_2 -p 596 -st topic222_0_1 -pt None -u 0.050870369299692075 > ./result_4chains/node222_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_1_2 -p 775 -st topic222_1_1 -pt None -u 0.04514438327035797 > ./result_4chains/node222_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_2_2 -p 847 -st topic222_2_1 -pt None -u 0.022695688892750226 > ./result_4chains/node222_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_3_2 -p 938 -st topic222_3_1 -pt None -u 0.0714738994439462 > ./result_4chains/node222_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_0_0 -p 596 -st none -pt topic222_0_0 -u 0.06408832254943908 > ./result_4chains/node222_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_1_0 -p 775 -st none -pt topic222_1_0 -u 0.02498128610795125 > ./result_4chains/node222_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_2_0 -p 847 -st none -pt topic222_2_0 -u 0.0799947682747918 > ./result_4chains/node222_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_3_0 -p 938 -st none -pt topic222_3_0 -u 0.0009224868589020052 > ./result_4chains/node222_3_0.txt &
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
    "./result_4chains/node222_0_0.txt 90"
    "./result_4chains/node222_0_2.txt 90"
    "./result_4chains/node222_1_0.txt 89"
    "./result_4chains/node222_1_2.txt 89"
    "./result_4chains/node222_2_0.txt 88"
    "./result_4chains/node222_2_2.txt 88"
    "./result_4chains/node222_3_0.txt 87"
    "./result_4chains/node222_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
