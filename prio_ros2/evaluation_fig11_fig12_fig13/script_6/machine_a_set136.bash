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
ros2 run evaluation_3_randomdag uunifast_node -n node136_0_2 -p 199 -st topic136_0_1 -pt None -u 0.03597363608961657 > ./result_6chains/node136_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_1_2 -p 235 -st topic136_1_1 -pt None -u 0.008442813399363203 > ./result_6chains/node136_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_2_2 -p 399 -st topic136_2_1 -pt None -u 0.06861950988165416 > ./result_6chains/node136_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_3_2 -p 536 -st topic136_3_1 -pt None -u 0.04489539177299093 > ./result_6chains/node136_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_4_2 -p 592 -st topic136_4_1 -pt None -u 0.04666559466375962 > ./result_6chains/node136_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_5_2 -p 956 -st topic136_5_1 -pt None -u 0.007410588088463392 > ./result_6chains/node136_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_0_0 -p 199 -st none -pt topic136_0_0 -u 0.00024179105012783753 > ./result_6chains/node136_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_1_0 -p 235 -st none -pt topic136_1_0 -u 0.0012620985436218035 > ./result_6chains/node136_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_2_0 -p 399 -st none -pt topic136_2_0 -u 0.0001661107273945861 > ./result_6chains/node136_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_3_0 -p 536 -st none -pt topic136_3_0 -u 0.07430625113235267 > ./result_6chains/node136_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node136_4_0 -p 592 -st none -pt topic136_4_0 -u 0.08626874185677134 > ./result_6chains/node136_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node136_5_0 -p 956 -st none -pt topic136_5_0 -u 0.0020184625135171233 > ./result_6chains/node136_5_0.txt &
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
    "./result_6chains/node136_0_0.txt 90"
    "./result_6chains/node136_0_2.txt 90"
    "./result_6chains/node136_1_0.txt 89"
    "./result_6chains/node136_1_2.txt 89"
    "./result_6chains/node136_2_0.txt 88"
    "./result_6chains/node136_2_2.txt 88"
    "./result_6chains/node136_3_0.txt 87"
    "./result_6chains/node136_3_2.txt 87"
    "./result_6chains/node136_4_0.txt 86"
    "./result_6chains/node136_4_2.txt 86"
    "./result_6chains/node136_5_0.txt 85"
    "./result_6chains/node136_5_2.txt 85"
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
