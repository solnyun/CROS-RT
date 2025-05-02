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
ros2 run evaluation_3_randomdag uunifast_node -n node295_0_2 -p 84 -st topic295_0_1 -pt None -u 0.0368665005232669 > ./result_6chains/node295_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_1_2 -p 200 -st topic295_1_1 -pt None -u 0.007356109187470428 > ./result_6chains/node295_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_2_2 -p 209 -st topic295_2_1 -pt None -u 0.010529288549547933 > ./result_6chains/node295_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_3_2 -p 556 -st topic295_3_1 -pt None -u 0.005470875837781303 > ./result_6chains/node295_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_4_2 -p 822 -st topic295_4_1 -pt None -u 0.0776764518902518 > ./result_6chains/node295_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_5_2 -p 994 -st topic295_5_1 -pt None -u 0.03120131873741388 > ./result_6chains/node295_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_0_0 -p 84 -st none -pt topic295_0_0 -u 0.02498756831746657 > ./result_6chains/node295_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_1_0 -p 200 -st none -pt topic295_1_0 -u 0.0015805427669762229 > ./result_6chains/node295_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_2_0 -p 209 -st none -pt topic295_2_0 -u 0.05053165790099701 > ./result_6chains/node295_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_3_0 -p 556 -st none -pt topic295_3_0 -u 0.029692870394230964 > ./result_6chains/node295_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_4_0 -p 822 -st none -pt topic295_4_0 -u 0.0023760134270176536 > ./result_6chains/node295_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_5_0 -p 994 -st none -pt topic295_5_0 -u 0.005681722964254857 > ./result_6chains/node295_5_0.txt &
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
    "./result_6chains/node295_0_0.txt 90"
    "./result_6chains/node295_0_2.txt 90"
    "./result_6chains/node295_1_0.txt 89"
    "./result_6chains/node295_1_2.txt 89"
    "./result_6chains/node295_2_0.txt 88"
    "./result_6chains/node295_2_2.txt 88"
    "./result_6chains/node295_3_0.txt 87"
    "./result_6chains/node295_3_2.txt 87"
    "./result_6chains/node295_4_0.txt 86"
    "./result_6chains/node295_4_2.txt 86"
    "./result_6chains/node295_5_0.txt 85"
    "./result_6chains/node295_5_2.txt 85"
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
