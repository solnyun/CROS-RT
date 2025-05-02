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
ros2 run evaluation_3_randomdag uunifast_node -n node16_0_2 -p 10 -st topic16_0_1 -pt None -u 0.028831996138292404 > ./result_6chains/node16_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_1_2 -p 264 -st topic16_1_1 -pt None -u 0.038116105878729434 > ./result_6chains/node16_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_2_2 -p 338 -st topic16_2_1 -pt None -u 0.00316844907236577 > ./result_6chains/node16_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_3_2 -p 412 -st topic16_3_1 -pt None -u 0.07736928934240746 > ./result_6chains/node16_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_4_2 -p 784 -st topic16_4_1 -pt None -u 0.021003835863830797 > ./result_6chains/node16_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_5_2 -p 905 -st topic16_5_1 -pt None -u 0.005917685311223755 > ./result_6chains/node16_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_0_0 -p 10 -st none -pt topic16_0_0 -u 0.058719466861192504 > ./result_6chains/node16_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_1_0 -p 264 -st none -pt topic16_1_0 -u 0.05731886363472288 > ./result_6chains/node16_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_2_0 -p 338 -st none -pt topic16_2_0 -u 0.0124086859289268 > ./result_6chains/node16_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_3_0 -p 412 -st none -pt topic16_3_0 -u 0.01438824733964203 > ./result_6chains/node16_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node16_4_0 -p 784 -st none -pt topic16_4_0 -u 0.0018178688885286676 > ./result_6chains/node16_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node16_5_0 -p 905 -st none -pt topic16_5_0 -u 0.023829931826624413 > ./result_6chains/node16_5_0.txt &
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
    "./result_6chains/node16_0_0.txt 90"
    "./result_6chains/node16_0_2.txt 90"
    "./result_6chains/node16_1_0.txt 89"
    "./result_6chains/node16_1_2.txt 89"
    "./result_6chains/node16_2_0.txt 88"
    "./result_6chains/node16_2_2.txt 88"
    "./result_6chains/node16_3_0.txt 87"
    "./result_6chains/node16_3_2.txt 87"
    "./result_6chains/node16_4_0.txt 86"
    "./result_6chains/node16_4_2.txt 86"
    "./result_6chains/node16_5_0.txt 85"
    "./result_6chains/node16_5_2.txt 85"
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
