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
ros2 run evaluation_3_randomdag uunifast_node -n node234_0_2 -p 343 -st topic234_0_1 -pt None -u 0.06154537610899424 > ./result_6chains/node234_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_1_2 -p 512 -st topic234_1_1 -pt None -u 0.09553036258422787 > ./result_6chains/node234_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_2_2 -p 718 -st topic234_2_1 -pt None -u 0.0020414681562487824 > ./result_6chains/node234_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_3_2 -p 762 -st topic234_3_1 -pt None -u 0.11228815895436642 > ./result_6chains/node234_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_4_2 -p 799 -st topic234_4_1 -pt None -u 0.006579784860384269 > ./result_6chains/node234_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_5_2 -p 932 -st topic234_5_1 -pt None -u 0.0071525255965372014 > ./result_6chains/node234_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_0_0 -p 343 -st none -pt topic234_0_0 -u 0.0025642628176213433 > ./result_6chains/node234_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_1_0 -p 512 -st none -pt topic234_1_0 -u 0.00270778589197207 > ./result_6chains/node234_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_2_0 -p 718 -st none -pt topic234_2_0 -u 0.011383984906375155 > ./result_6chains/node234_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_3_0 -p 762 -st none -pt topic234_3_0 -u 0.00804970832641616 > ./result_6chains/node234_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_4_0 -p 799 -st none -pt topic234_4_0 -u 0.039606216694165655 > ./result_6chains/node234_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_5_0 -p 932 -st none -pt topic234_5_0 -u 0.06530696725237634 > ./result_6chains/node234_5_0.txt &
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
    "./result_6chains/node234_0_0.txt 90"
    "./result_6chains/node234_0_2.txt 90"
    "./result_6chains/node234_1_0.txt 89"
    "./result_6chains/node234_1_2.txt 89"
    "./result_6chains/node234_2_0.txt 88"
    "./result_6chains/node234_2_2.txt 88"
    "./result_6chains/node234_3_0.txt 87"
    "./result_6chains/node234_3_2.txt 87"
    "./result_6chains/node234_4_0.txt 86"
    "./result_6chains/node234_4_2.txt 86"
    "./result_6chains/node234_5_0.txt 85"
    "./result_6chains/node234_5_2.txt 85"
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
