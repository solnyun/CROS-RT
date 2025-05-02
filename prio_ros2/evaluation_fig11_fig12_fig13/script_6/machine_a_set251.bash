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
ros2 run evaluation_3_randomdag uunifast_node -n node251_0_2 -p 198 -st topic251_0_1 -pt None -u 0.004633382340893111 > ./result_6chains/node251_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_1_2 -p 421 -st topic251_1_1 -pt None -u 0.014138809844821965 > ./result_6chains/node251_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_2_2 -p 593 -st topic251_2_1 -pt None -u 0.01242669122608786 > ./result_6chains/node251_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_3_2 -p 827 -st topic251_3_1 -pt None -u 0.04357355238089272 > ./result_6chains/node251_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_4_2 -p 959 -st topic251_4_1 -pt None -u 0.07573565854211886 > ./result_6chains/node251_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_5_2 -p 966 -st topic251_5_1 -pt None -u 0.009598169171893317 > ./result_6chains/node251_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_0_0 -p 198 -st none -pt topic251_0_0 -u 0.032457627251799404 > ./result_6chains/node251_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_1_0 -p 421 -st none -pt topic251_1_0 -u 0.06596867825129865 > ./result_6chains/node251_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_2_0 -p 593 -st none -pt topic251_2_0 -u 0.05045419822741515 > ./result_6chains/node251_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_3_0 -p 827 -st none -pt topic251_3_0 -u 0.0031308091269315885 > ./result_6chains/node251_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node251_4_0 -p 959 -st none -pt topic251_4_0 -u 0.03459439381995075 > ./result_6chains/node251_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node251_5_0 -p 966 -st none -pt topic251_5_0 -u 0.026740571960770936 > ./result_6chains/node251_5_0.txt &
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
    "./result_6chains/node251_0_0.txt 90"
    "./result_6chains/node251_0_2.txt 90"
    "./result_6chains/node251_1_0.txt 89"
    "./result_6chains/node251_1_2.txt 89"
    "./result_6chains/node251_2_0.txt 88"
    "./result_6chains/node251_2_2.txt 88"
    "./result_6chains/node251_3_0.txt 87"
    "./result_6chains/node251_3_2.txt 87"
    "./result_6chains/node251_4_0.txt 86"
    "./result_6chains/node251_4_2.txt 86"
    "./result_6chains/node251_5_0.txt 85"
    "./result_6chains/node251_5_2.txt 85"
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
