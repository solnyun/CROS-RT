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
ros2 run evaluation_3_randomdag uunifast_node -n node11_0_2 -p 59 -st topic11_0_1 -pt None -u 0.011811823958823242 > ./result_6chains/node11_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_1_2 -p 163 -st topic11_1_1 -pt None -u 0.05394610361390223 > ./result_6chains/node11_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_2_2 -p 176 -st topic11_2_1 -pt None -u 0.02413683158312535 > ./result_6chains/node11_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_3_2 -p 375 -st topic11_3_1 -pt None -u 0.004348097755221603 > ./result_6chains/node11_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_4_2 -p 487 -st topic11_4_1 -pt None -u 0.07066218012086228 > ./result_6chains/node11_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_5_2 -p 765 -st topic11_5_1 -pt None -u 0.09479593380764 > ./result_6chains/node11_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_0_0 -p 59 -st none -pt topic11_0_0 -u 0.03769283288551567 > ./result_6chains/node11_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_1_0 -p 163 -st none -pt topic11_1_0 -u 0.02955010800328378 > ./result_6chains/node11_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_2_0 -p 176 -st none -pt topic11_2_0 -u 0.0893389748274484 > ./result_6chains/node11_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_3_0 -p 375 -st none -pt topic11_3_0 -u 0.01063075938898908 > ./result_6chains/node11_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node11_4_0 -p 487 -st none -pt topic11_4_0 -u 0.0004497366845716555 > ./result_6chains/node11_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node11_5_0 -p 765 -st none -pt topic11_5_0 -u 0.01239049275999271 > ./result_6chains/node11_5_0.txt &
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
    "./result_6chains/node11_0_0.txt 90"
    "./result_6chains/node11_0_2.txt 90"
    "./result_6chains/node11_1_0.txt 89"
    "./result_6chains/node11_1_2.txt 89"
    "./result_6chains/node11_2_0.txt 88"
    "./result_6chains/node11_2_2.txt 88"
    "./result_6chains/node11_3_0.txt 87"
    "./result_6chains/node11_3_2.txt 87"
    "./result_6chains/node11_4_0.txt 86"
    "./result_6chains/node11_4_2.txt 86"
    "./result_6chains/node11_5_0.txt 85"
    "./result_6chains/node11_5_2.txt 85"
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
