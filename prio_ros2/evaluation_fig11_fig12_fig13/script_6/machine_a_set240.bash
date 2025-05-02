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
ros2 run evaluation_3_randomdag uunifast_node -n node240_0_2 -p 23 -st topic240_0_1 -pt None -u 0.007029495946372311 > ./result_6chains/node240_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_1_2 -p 634 -st topic240_1_1 -pt None -u 0.08547257992220553 > ./result_6chains/node240_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_2_2 -p 735 -st topic240_2_1 -pt None -u 0.0221451049373364 > ./result_6chains/node240_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_3_2 -p 775 -st topic240_3_1 -pt None -u 0.011324102549300219 > ./result_6chains/node240_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_4_2 -p 985 -st topic240_4_1 -pt None -u 0.012243177641282604 > ./result_6chains/node240_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_5_2 -p 996 -st topic240_5_1 -pt None -u 0.007254566520296482 > ./result_6chains/node240_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_0_0 -p 23 -st none -pt topic240_0_0 -u 0.007127663904754888 > ./result_6chains/node240_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_1_0 -p 634 -st none -pt topic240_1_0 -u 0.06606284096573428 > ./result_6chains/node240_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_2_0 -p 735 -st none -pt topic240_2_0 -u 0.013650811891911141 > ./result_6chains/node240_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_3_0 -p 775 -st none -pt topic240_3_0 -u 0.0040794777272810945 > ./result_6chains/node240_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node240_4_0 -p 985 -st none -pt topic240_4_0 -u 0.0006880764179885701 > ./result_6chains/node240_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node240_5_0 -p 996 -st none -pt topic240_5_0 -u 0.056542473078430744 > ./result_6chains/node240_5_0.txt &
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
    "./result_6chains/node240_0_0.txt 90"
    "./result_6chains/node240_0_2.txt 90"
    "./result_6chains/node240_1_0.txt 89"
    "./result_6chains/node240_1_2.txt 89"
    "./result_6chains/node240_2_0.txt 88"
    "./result_6chains/node240_2_2.txt 88"
    "./result_6chains/node240_3_0.txt 87"
    "./result_6chains/node240_3_2.txt 87"
    "./result_6chains/node240_4_0.txt 86"
    "./result_6chains/node240_4_2.txt 86"
    "./result_6chains/node240_5_0.txt 85"
    "./result_6chains/node240_5_2.txt 85"
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
