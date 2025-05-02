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
ros2 run evaluation_3_randomdag uunifast_node -n node268_0_2 -p 86 -st topic268_0_1 -pt None -u 0.050514806710032334 > ./result_6chains/node268_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_1_2 -p 162 -st topic268_1_1 -pt None -u 0.0038234776000078408 > ./result_6chains/node268_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_2_2 -p 529 -st topic268_2_1 -pt None -u 0.009944467398201873 > ./result_6chains/node268_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_3_2 -p 761 -st topic268_3_1 -pt None -u 0.010236944887045657 > ./result_6chains/node268_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_4_2 -p 892 -st topic268_4_1 -pt None -u 0.02499173743200106 > ./result_6chains/node268_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_5_2 -p 934 -st topic268_5_1 -pt None -u 0.029363644895931473 > ./result_6chains/node268_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_0_0 -p 86 -st none -pt topic268_0_0 -u 0.08276297147890599 > ./result_6chains/node268_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_1_0 -p 162 -st none -pt topic268_1_0 -u 0.001705692132307035 > ./result_6chains/node268_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_2_0 -p 529 -st none -pt topic268_2_0 -u 0.022307376044848226 > ./result_6chains/node268_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_3_0 -p 761 -st none -pt topic268_3_0 -u 0.00447185479584597 > ./result_6chains/node268_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_4_0 -p 892 -st none -pt topic268_4_0 -u 0.03469806015141509 > ./result_6chains/node268_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_5_0 -p 934 -st none -pt topic268_5_0 -u 0.011555027638286315 > ./result_6chains/node268_5_0.txt &
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
    "./result_6chains/node268_0_0.txt 90"
    "./result_6chains/node268_0_2.txt 90"
    "./result_6chains/node268_1_0.txt 89"
    "./result_6chains/node268_1_2.txt 89"
    "./result_6chains/node268_2_0.txt 88"
    "./result_6chains/node268_2_2.txt 88"
    "./result_6chains/node268_3_0.txt 87"
    "./result_6chains/node268_3_2.txt 87"
    "./result_6chains/node268_4_0.txt 86"
    "./result_6chains/node268_4_2.txt 86"
    "./result_6chains/node268_5_0.txt 85"
    "./result_6chains/node268_5_2.txt 85"
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
