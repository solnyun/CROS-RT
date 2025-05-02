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
ros2 run evaluation_3_randomdag uunifast_node -n node171_0_2 -p 249 -st topic171_0_1 -pt None -u 0.024333345064274536 > ./result_4chains/node171_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_1_2 -p 482 -st topic171_1_1 -pt None -u 0.08978561856152689 > ./result_4chains/node171_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_2_2 -p 539 -st topic171_2_1 -pt None -u 0.03820275558548952 > ./result_4chains/node171_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_3_2 -p 540 -st topic171_3_1 -pt None -u 0.03726397804143798 > ./result_4chains/node171_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_0_0 -p 249 -st none -pt topic171_0_0 -u 0.026683687583015647 > ./result_4chains/node171_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_1_0 -p 482 -st none -pt topic171_1_0 -u 0.09689932835328935 > ./result_4chains/node171_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_2_0 -p 539 -st none -pt topic171_2_0 -u 0.018911824434922175 > ./result_4chains/node171_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node171_3_0 -p 540 -st none -pt topic171_3_0 -u 0.017913869281215328 > ./result_4chains/node171_3_0.txt &
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
    "./result_4chains/node171_0_0.txt 90"
    "./result_4chains/node171_0_2.txt 90"
    "./result_4chains/node171_1_0.txt 89"
    "./result_4chains/node171_1_2.txt 89"
    "./result_4chains/node171_2_0.txt 88"
    "./result_4chains/node171_2_2.txt 88"
    "./result_4chains/node171_3_0.txt 87"
    "./result_4chains/node171_3_2.txt 87"
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
