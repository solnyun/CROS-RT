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
ros2 run evaluation_3_randomdag uunifast_node -n node70_0_2 -p 75 -st topic70_0_1 -pt None -u 0.00026333170205727896 > ./result_6chains/node70_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_1_2 -p 112 -st topic70_1_1 -pt None -u 0.058703411989751486 > ./result_6chains/node70_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_2_2 -p 457 -st topic70_2_1 -pt None -u 0.016865234613983426 > ./result_6chains/node70_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_3_2 -p 547 -st topic70_3_1 -pt None -u 0.054363260581145406 > ./result_6chains/node70_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_4_2 -p 630 -st topic70_4_1 -pt None -u 0.004026707771533439 > ./result_6chains/node70_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_5_2 -p 951 -st topic70_5_1 -pt None -u 0.005961615769772932 > ./result_6chains/node70_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_0_0 -p 75 -st none -pt topic70_0_0 -u 0.03773188083477175 > ./result_6chains/node70_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_1_0 -p 112 -st none -pt topic70_1_0 -u 0.08956076002656521 > ./result_6chains/node70_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_2_0 -p 457 -st none -pt topic70_2_0 -u 7.32545288838482e-05 > ./result_6chains/node70_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_3_0 -p 547 -st none -pt topic70_3_0 -u 0.027336267446607748 > ./result_6chains/node70_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node70_4_0 -p 630 -st none -pt topic70_4_0 -u 0.011550391144484057 > ./result_6chains/node70_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node70_5_0 -p 951 -st none -pt topic70_5_0 -u 0.002816402370129145 > ./result_6chains/node70_5_0.txt &
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
    "./result_6chains/node70_0_0.txt 90"
    "./result_6chains/node70_0_2.txt 90"
    "./result_6chains/node70_1_0.txt 89"
    "./result_6chains/node70_1_2.txt 89"
    "./result_6chains/node70_2_0.txt 88"
    "./result_6chains/node70_2_2.txt 88"
    "./result_6chains/node70_3_0.txt 87"
    "./result_6chains/node70_3_2.txt 87"
    "./result_6chains/node70_4_0.txt 86"
    "./result_6chains/node70_4_2.txt 86"
    "./result_6chains/node70_5_0.txt 85"
    "./result_6chains/node70_5_2.txt 85"
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
