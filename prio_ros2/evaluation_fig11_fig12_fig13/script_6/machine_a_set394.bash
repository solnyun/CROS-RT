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
ros2 run evaluation_3_randomdag uunifast_node -n node394_0_2 -p 70 -st topic394_0_1 -pt None -u 0.010748725470144993 > ./result_6chains/node394_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_1_2 -p 160 -st topic394_1_1 -pt None -u 0.0657201730151657 > ./result_6chains/node394_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_2_2 -p 492 -st topic394_2_1 -pt None -u 0.010923747407597273 > ./result_6chains/node394_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_3_2 -p 729 -st topic394_3_1 -pt None -u 0.049937423603139325 > ./result_6chains/node394_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_4_2 -p 757 -st topic394_4_1 -pt None -u 0.009767644633277076 > ./result_6chains/node394_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_5_2 -p 915 -st topic394_5_1 -pt None -u 0.07202667329142007 > ./result_6chains/node394_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_0_0 -p 70 -st none -pt topic394_0_0 -u 0.04154354885807232 > ./result_6chains/node394_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_1_0 -p 160 -st none -pt topic394_1_0 -u 0.008708137268684024 > ./result_6chains/node394_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_2_0 -p 492 -st none -pt topic394_2_0 -u 0.004062054190455411 > ./result_6chains/node394_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_3_0 -p 729 -st none -pt topic394_3_0 -u 0.03260597017022149 > ./result_6chains/node394_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_4_0 -p 757 -st none -pt topic394_4_0 -u 0.010698353224909363 > ./result_6chains/node394_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_5_0 -p 915 -st none -pt topic394_5_0 -u 0.03134119488942354 > ./result_6chains/node394_5_0.txt &
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
    "./result_6chains/node394_0_0.txt 90"
    "./result_6chains/node394_0_2.txt 90"
    "./result_6chains/node394_1_0.txt 89"
    "./result_6chains/node394_1_2.txt 89"
    "./result_6chains/node394_2_0.txt 88"
    "./result_6chains/node394_2_2.txt 88"
    "./result_6chains/node394_3_0.txt 87"
    "./result_6chains/node394_3_2.txt 87"
    "./result_6chains/node394_4_0.txt 86"
    "./result_6chains/node394_4_2.txt 86"
    "./result_6chains/node394_5_0.txt 85"
    "./result_6chains/node394_5_2.txt 85"
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
