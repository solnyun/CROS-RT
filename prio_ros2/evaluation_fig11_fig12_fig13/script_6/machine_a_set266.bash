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
ros2 run evaluation_3_randomdag uunifast_node -n node266_0_2 -p 92 -st topic266_0_1 -pt None -u 0.11647850680958727 > ./result_6chains/node266_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_1_2 -p 186 -st topic266_1_1 -pt None -u 0.026012719918506455 > ./result_6chains/node266_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_2_2 -p 330 -st topic266_2_1 -pt None -u 0.002246363807333396 > ./result_6chains/node266_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_3_2 -p 371 -st topic266_3_1 -pt None -u 0.02916283470227607 > ./result_6chains/node266_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_4_2 -p 747 -st topic266_4_1 -pt None -u 0.08806164644723782 > ./result_6chains/node266_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_5_2 -p 943 -st topic266_5_1 -pt None -u 0.058041595601843896 > ./result_6chains/node266_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_0_0 -p 92 -st none -pt topic266_0_0 -u 0.0011119668321003529 > ./result_6chains/node266_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_1_0 -p 186 -st none -pt topic266_1_0 -u 0.01322807032501222 > ./result_6chains/node266_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_2_0 -p 330 -st none -pt topic266_2_0 -u 0.05417021694249441 > ./result_6chains/node266_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_3_0 -p 371 -st none -pt topic266_3_0 -u 0.02101506176965684 > ./result_6chains/node266_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_4_0 -p 747 -st none -pt topic266_4_0 -u 0.01596501230752509 > ./result_6chains/node266_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_5_0 -p 943 -st none -pt topic266_5_0 -u 0.01118381045197217 > ./result_6chains/node266_5_0.txt &
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
    "./result_6chains/node266_0_0.txt 90"
    "./result_6chains/node266_0_2.txt 90"
    "./result_6chains/node266_1_0.txt 89"
    "./result_6chains/node266_1_2.txt 89"
    "./result_6chains/node266_2_0.txt 88"
    "./result_6chains/node266_2_2.txt 88"
    "./result_6chains/node266_3_0.txt 87"
    "./result_6chains/node266_3_2.txt 87"
    "./result_6chains/node266_4_0.txt 86"
    "./result_6chains/node266_4_2.txt 86"
    "./result_6chains/node266_5_0.txt 85"
    "./result_6chains/node266_5_2.txt 85"
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
