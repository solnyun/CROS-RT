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
ros2 run evaluation_3_randomdag uunifast_node -n node192_0_2 -p 385 -st topic192_0_1 -pt None -u 0.0036176893857223225 > ./result_6chains/node192_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_1_2 -p 493 -st topic192_1_1 -pt None -u 0.04542080541538729 > ./result_6chains/node192_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_2_2 -p 518 -st topic192_2_1 -pt None -u 0.005303902476763905 > ./result_6chains/node192_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_3_2 -p 842 -st topic192_3_1 -pt None -u 0.014361769224153775 > ./result_6chains/node192_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_4_2 -p 949 -st topic192_4_1 -pt None -u 0.0631345249391139 > ./result_6chains/node192_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_5_2 -p 983 -st topic192_5_1 -pt None -u 0.007324407710430163 > ./result_6chains/node192_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_0_0 -p 385 -st none -pt topic192_0_0 -u 0.03080751442033386 > ./result_6chains/node192_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_1_0 -p 493 -st none -pt topic192_1_0 -u 0.004064985301170221 > ./result_6chains/node192_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_2_0 -p 518 -st none -pt topic192_2_0 -u 0.021309521218613015 > ./result_6chains/node192_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_3_0 -p 842 -st none -pt topic192_3_0 -u 0.006611619317338169 > ./result_6chains/node192_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_4_0 -p 949 -st none -pt topic192_4_0 -u 0.0001672225422925111 > ./result_6chains/node192_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_5_0 -p 983 -st none -pt topic192_5_0 -u 0.023427331859885825 > ./result_6chains/node192_5_0.txt &
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
    "./result_6chains/node192_0_0.txt 90"
    "./result_6chains/node192_0_2.txt 90"
    "./result_6chains/node192_1_0.txt 89"
    "./result_6chains/node192_1_2.txt 89"
    "./result_6chains/node192_2_0.txt 88"
    "./result_6chains/node192_2_2.txt 88"
    "./result_6chains/node192_3_0.txt 87"
    "./result_6chains/node192_3_2.txt 87"
    "./result_6chains/node192_4_0.txt 86"
    "./result_6chains/node192_4_2.txt 86"
    "./result_6chains/node192_5_0.txt 85"
    "./result_6chains/node192_5_2.txt 85"
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
