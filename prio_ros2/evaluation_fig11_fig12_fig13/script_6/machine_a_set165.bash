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
ros2 run evaluation_3_randomdag uunifast_node -n node165_0_2 -p 206 -st topic165_0_1 -pt None -u 0.05222969869143207 > ./result_6chains/node165_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_1_2 -p 318 -st topic165_1_1 -pt None -u 0.09639579006686294 > ./result_6chains/node165_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_2_2 -p 322 -st topic165_2_1 -pt None -u 0.032636782463765196 > ./result_6chains/node165_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_3_2 -p 482 -st topic165_3_1 -pt None -u 0.024587950235723688 > ./result_6chains/node165_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_4_2 -p 834 -st topic165_4_1 -pt None -u 0.002244763293633295 > ./result_6chains/node165_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_5_2 -p 982 -st topic165_5_1 -pt None -u 0.08362631432975405 > ./result_6chains/node165_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_0_0 -p 206 -st none -pt topic165_0_0 -u 0.008377243074872642 > ./result_6chains/node165_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_1_0 -p 318 -st none -pt topic165_1_0 -u 0.003654119966400249 > ./result_6chains/node165_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_2_0 -p 322 -st none -pt topic165_2_0 -u 0.01271371761591411 > ./result_6chains/node165_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_3_0 -p 482 -st none -pt topic165_3_0 -u 0.0585430892634263 > ./result_6chains/node165_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node165_4_0 -p 834 -st none -pt topic165_4_0 -u 8.459056915186003e-05 > ./result_6chains/node165_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node165_5_0 -p 982 -st none -pt topic165_5_0 -u 0.04448630198726683 > ./result_6chains/node165_5_0.txt &
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
    "./result_6chains/node165_0_0.txt 90"
    "./result_6chains/node165_0_2.txt 90"
    "./result_6chains/node165_1_0.txt 89"
    "./result_6chains/node165_1_2.txt 89"
    "./result_6chains/node165_2_0.txt 88"
    "./result_6chains/node165_2_2.txt 88"
    "./result_6chains/node165_3_0.txt 87"
    "./result_6chains/node165_3_2.txt 87"
    "./result_6chains/node165_4_0.txt 86"
    "./result_6chains/node165_4_2.txt 86"
    "./result_6chains/node165_5_0.txt 85"
    "./result_6chains/node165_5_2.txt 85"
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
