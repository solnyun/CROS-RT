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
ros2 run evaluation_3_randomdag uunifast_node -n node499_0_2 -p 220 -st topic499_0_1 -pt None -u 0.05809597405194822 > ./result_6chains/node499_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_1_2 -p 245 -st topic499_1_1 -pt None -u 0.013734788901585415 > ./result_6chains/node499_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_2_2 -p 418 -st topic499_2_1 -pt None -u 0.021415029897919657 > ./result_6chains/node499_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_3_2 -p 576 -st topic499_3_1 -pt None -u 0.0038348911273410613 > ./result_6chains/node499_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_4_2 -p 624 -st topic499_4_1 -pt None -u 0.011442270518030775 > ./result_6chains/node499_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_5_2 -p 936 -st topic499_5_1 -pt None -u 0.07322246098995674 > ./result_6chains/node499_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_0_0 -p 220 -st none -pt topic499_0_0 -u 0.030454327758568434 > ./result_6chains/node499_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_1_0 -p 245 -st none -pt topic499_1_0 -u 0.00019473399493352694 > ./result_6chains/node499_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_2_0 -p 418 -st none -pt topic499_2_0 -u 0.05066200743192084 > ./result_6chains/node499_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_3_0 -p 576 -st none -pt topic499_3_0 -u 0.0008851907992667718 > ./result_6chains/node499_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node499_4_0 -p 624 -st none -pt topic499_4_0 -u 0.0353606509927899 > ./result_6chains/node499_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node499_5_0 -p 936 -st none -pt topic499_5_0 -u 0.0018597313656597697 > ./result_6chains/node499_5_0.txt &
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
    "./result_6chains/node499_0_0.txt 90"
    "./result_6chains/node499_0_2.txt 90"
    "./result_6chains/node499_1_0.txt 89"
    "./result_6chains/node499_1_2.txt 89"
    "./result_6chains/node499_2_0.txt 88"
    "./result_6chains/node499_2_2.txt 88"
    "./result_6chains/node499_3_0.txt 87"
    "./result_6chains/node499_3_2.txt 87"
    "./result_6chains/node499_4_0.txt 86"
    "./result_6chains/node499_4_2.txt 86"
    "./result_6chains/node499_5_0.txt 85"
    "./result_6chains/node499_5_2.txt 85"
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
