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
ros2 run evaluation_3_randomdag uunifast_node -n node483_0_2 -p 230 -st topic483_0_1 -pt None -u 0.0028320706373191062 > ./result_4chains/node483_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_1_2 -p 578 -st topic483_1_1 -pt None -u 0.04233033961531857 > ./result_4chains/node483_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_2_2 -p 836 -st topic483_2_1 -pt None -u 0.06227815831663376 > ./result_4chains/node483_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_3_2 -p 964 -st topic483_3_1 -pt None -u 0.028227904388080483 > ./result_4chains/node483_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_0_0 -p 230 -st none -pt topic483_0_0 -u 0.016556838267190177 > ./result_4chains/node483_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_1_0 -p 578 -st none -pt topic483_1_0 -u 0.023003753758408796 > ./result_4chains/node483_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_2_0 -p 836 -st none -pt topic483_2_0 -u 0.09434466913157169 > ./result_4chains/node483_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node483_3_0 -p 964 -st none -pt topic483_3_0 -u 0.0005157197797699062 > ./result_4chains/node483_3_0.txt &
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
    "./result_4chains/node483_0_0.txt 90"
    "./result_4chains/node483_0_2.txt 90"
    "./result_4chains/node483_1_0.txt 89"
    "./result_4chains/node483_1_2.txt 89"
    "./result_4chains/node483_2_0.txt 88"
    "./result_4chains/node483_2_2.txt 88"
    "./result_4chains/node483_3_0.txt 87"
    "./result_4chains/node483_3_2.txt 87"
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
