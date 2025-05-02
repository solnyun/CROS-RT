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
ros2 run evaluation_3_randomdag uunifast_node -n node168_0_2 -p 367 -st topic168_0_1 -pt None -u 0.06525167546172922 > ./result_6chains/node168_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_1_2 -p 692 -st topic168_1_1 -pt None -u 0.020673384833237496 > ./result_6chains/node168_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_2_2 -p 805 -st topic168_2_1 -pt None -u 0.009121893790931312 > ./result_6chains/node168_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_3_2 -p 818 -st topic168_3_1 -pt None -u 0.04846094025557479 > ./result_6chains/node168_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_4_2 -p 916 -st topic168_4_1 -pt None -u 0.027309836558836134 > ./result_6chains/node168_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_5_2 -p 917 -st topic168_5_1 -pt None -u 0.00021534852687577356 > ./result_6chains/node168_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_0_0 -p 367 -st none -pt topic168_0_0 -u 0.0019352980371681872 > ./result_6chains/node168_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_1_0 -p 692 -st none -pt topic168_1_0 -u 0.014289024866141309 > ./result_6chains/node168_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_2_0 -p 805 -st none -pt topic168_2_0 -u 0.0023676157545720056 > ./result_6chains/node168_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_3_0 -p 818 -st none -pt topic168_3_0 -u 0.0006789278413290023 > ./result_6chains/node168_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_4_0 -p 916 -st none -pt topic168_4_0 -u 0.07815243778037526 > ./result_6chains/node168_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_5_0 -p 917 -st none -pt topic168_5_0 -u 0.06264803101796795 > ./result_6chains/node168_5_0.txt &
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
    "./result_6chains/node168_0_0.txt 90"
    "./result_6chains/node168_0_2.txt 90"
    "./result_6chains/node168_1_0.txt 89"
    "./result_6chains/node168_1_2.txt 89"
    "./result_6chains/node168_2_0.txt 88"
    "./result_6chains/node168_2_2.txt 88"
    "./result_6chains/node168_3_0.txt 87"
    "./result_6chains/node168_3_2.txt 87"
    "./result_6chains/node168_4_0.txt 86"
    "./result_6chains/node168_4_2.txt 86"
    "./result_6chains/node168_5_0.txt 85"
    "./result_6chains/node168_5_2.txt 85"
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
