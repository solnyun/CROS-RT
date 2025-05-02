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
ros2 run evaluation_3_randomdag uunifast_node -n node236_0_2 -p 124 -st topic236_0_1 -pt None -u 0.078233630335791 > ./result_6chains/node236_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_1_2 -p 169 -st topic236_1_1 -pt None -u 0.013858879549035252 > ./result_6chains/node236_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_2_2 -p 213 -st topic236_2_1 -pt None -u 0.003479529693440897 > ./result_6chains/node236_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_3_2 -p 259 -st topic236_3_1 -pt None -u 0.010645252878467876 > ./result_6chains/node236_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_4_2 -p 646 -st topic236_4_1 -pt None -u 0.01230270893943744 > ./result_6chains/node236_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_5_2 -p 668 -st topic236_5_1 -pt None -u 0.03183165471600902 > ./result_6chains/node236_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_0_0 -p 124 -st none -pt topic236_0_0 -u 0.0036865774941521323 > ./result_6chains/node236_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_1_0 -p 169 -st none -pt topic236_1_0 -u 0.020952046265573343 > ./result_6chains/node236_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_2_0 -p 213 -st none -pt topic236_2_0 -u 0.030279183039801594 > ./result_6chains/node236_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_3_0 -p 259 -st none -pt topic236_3_0 -u 0.07434497778051619 > ./result_6chains/node236_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_4_0 -p 646 -st none -pt topic236_4_0 -u 0.028454624734073758 > ./result_6chains/node236_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_5_0 -p 668 -st none -pt topic236_5_0 -u 0.07005307668847967 > ./result_6chains/node236_5_0.txt &
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
    "./result_6chains/node236_0_0.txt 90"
    "./result_6chains/node236_0_2.txt 90"
    "./result_6chains/node236_1_0.txt 89"
    "./result_6chains/node236_1_2.txt 89"
    "./result_6chains/node236_2_0.txt 88"
    "./result_6chains/node236_2_2.txt 88"
    "./result_6chains/node236_3_0.txt 87"
    "./result_6chains/node236_3_2.txt 87"
    "./result_6chains/node236_4_0.txt 86"
    "./result_6chains/node236_4_2.txt 86"
    "./result_6chains/node236_5_0.txt 85"
    "./result_6chains/node236_5_2.txt 85"
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
