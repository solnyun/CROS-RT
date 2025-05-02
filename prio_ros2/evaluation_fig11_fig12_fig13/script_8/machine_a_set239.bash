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
ros2 run evaluation_3_randomdag uunifast_node -n node239_0_2 -p 98 -st topic239_0_1 -pt None -u 0.08897430019636382 > ./result_8chains/node239_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_1_2 -p 434 -st topic239_1_1 -pt None -u 0.007593688472542215 > ./result_8chains/node239_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_2_2 -p 476 -st topic239_2_1 -pt None -u 0.01200140460028376 > ./result_8chains/node239_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_3_2 -p 778 -st topic239_3_1 -pt None -u 0.028199382989219535 > ./result_8chains/node239_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_4_2 -p 859 -st topic239_4_1 -pt None -u 0.027535208546973763 > ./result_8chains/node239_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_5_2 -p 903 -st topic239_5_1 -pt None -u 0.013905278500143801 > ./result_8chains/node239_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_6_2 -p 978 -st topic239_6_1 -pt None -u 0.0016009472553586632 > ./result_8chains/node239_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_7_2 -p 990 -st topic239_7_1 -pt None -u 0.012210802864956072 > ./result_8chains/node239_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_0_0 -p 98 -st none -pt topic239_0_0 -u 0.026301069352748396 > ./result_8chains/node239_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_1_0 -p 434 -st none -pt topic239_1_0 -u 0.01954135373066135 > ./result_8chains/node239_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_2_0 -p 476 -st none -pt topic239_2_0 -u 0.02101407680399825 > ./result_8chains/node239_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_3_0 -p 778 -st none -pt topic239_3_0 -u 0.03977153022274757 > ./result_8chains/node239_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_4_0 -p 859 -st none -pt topic239_4_0 -u 0.024405211165354795 > ./result_8chains/node239_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_5_0 -p 903 -st none -pt topic239_5_0 -u 0.03597213378337155 > ./result_8chains/node239_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_6_0 -p 978 -st none -pt topic239_6_0 -u 0.024083201584767358 > ./result_8chains/node239_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_7_0 -p 990 -st none -pt topic239_7_0 -u 0.0005117791029055456 > ./result_8chains/node239_7_0.txt &
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
    "./result_8chains/node239_0_0.txt 90"
    "./result_8chains/node239_0_2.txt 90"
    "./result_8chains/node239_1_0.txt 89"
    "./result_8chains/node239_1_2.txt 89"
    "./result_8chains/node239_2_0.txt 88"
    "./result_8chains/node239_2_2.txt 88"
    "./result_8chains/node239_3_0.txt 87"
    "./result_8chains/node239_3_2.txt 87"
    "./result_8chains/node239_4_0.txt 86"
    "./result_8chains/node239_4_2.txt 86"
    "./result_8chains/node239_5_0.txt 85"
    "./result_8chains/node239_5_2.txt 85"
    "./result_8chains/node239_6_0.txt 84"
    "./result_8chains/node239_6_2.txt 84"
    "./result_8chains/node239_7_0.txt 83"
    "./result_8chains/node239_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
