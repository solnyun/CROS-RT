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
ros2 run evaluation_3_randomdag uunifast_node -n node320_0_2 -p 55 -st topic320_0_1 -pt None -u 0.06930170531063179 > ./result_6chains/node320_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_1_2 -p 200 -st topic320_1_1 -pt None -u 0.014601108781324756 > ./result_6chains/node320_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_2_2 -p 216 -st topic320_2_1 -pt None -u 0.0051476233561424944 > ./result_6chains/node320_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_3_2 -p 262 -st topic320_3_1 -pt None -u 0.09831063144152644 > ./result_6chains/node320_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_4_2 -p 819 -st topic320_4_1 -pt None -u 0.00981257339165148 > ./result_6chains/node320_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_5_2 -p 904 -st topic320_5_1 -pt None -u 0.004880245053429971 > ./result_6chains/node320_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_0_0 -p 55 -st none -pt topic320_0_0 -u 0.03320754871694709 > ./result_6chains/node320_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_1_0 -p 200 -st none -pt topic320_1_0 -u 0.019121640922093064 > ./result_6chains/node320_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_2_0 -p 216 -st none -pt topic320_2_0 -u 0.004016621150613742 > ./result_6chains/node320_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_3_0 -p 262 -st none -pt topic320_3_0 -u 0.05137573289295633 > ./result_6chains/node320_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_4_0 -p 819 -st none -pt topic320_4_0 -u 0.07364007330986219 > ./result_6chains/node320_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_5_0 -p 904 -st none -pt topic320_5_0 -u 0.0376495597121211 > ./result_6chains/node320_5_0.txt &
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
    "./result_6chains/node320_0_0.txt 90"
    "./result_6chains/node320_0_2.txt 90"
    "./result_6chains/node320_1_0.txt 89"
    "./result_6chains/node320_1_2.txt 89"
    "./result_6chains/node320_2_0.txt 88"
    "./result_6chains/node320_2_2.txt 88"
    "./result_6chains/node320_3_0.txt 87"
    "./result_6chains/node320_3_2.txt 87"
    "./result_6chains/node320_4_0.txt 86"
    "./result_6chains/node320_4_2.txt 86"
    "./result_6chains/node320_5_0.txt 85"
    "./result_6chains/node320_5_2.txt 85"
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
