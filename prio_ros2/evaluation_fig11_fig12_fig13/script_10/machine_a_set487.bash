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
ros2 run evaluation_3_randomdag uunifast_node -n node487_0_2 -p 47 -st topic487_0_1 -pt None -u 0.025687213892282235 > ./result_10chains/node487_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_1_2 -p 91 -st topic487_1_1 -pt None -u 0.007628608758325772 > ./result_10chains/node487_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_2_2 -p 97 -st topic487_2_1 -pt None -u 0.005022509235420747 > ./result_10chains/node487_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_3_2 -p 106 -st topic487_3_1 -pt None -u 0.002233461253094593 > ./result_10chains/node487_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_4_2 -p 159 -st topic487_4_1 -pt None -u 0.004921827223079045 > ./result_10chains/node487_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_5_2 -p 333 -st topic487_5_1 -pt None -u 0.022837137271257163 > ./result_10chains/node487_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_6_2 -p 494 -st topic487_6_1 -pt None -u 0.00423164400021965 > ./result_10chains/node487_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_7_2 -p 689 -st topic487_7_1 -pt None -u 0.02951055548673459 > ./result_10chains/node487_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_8_2 -p 858 -st topic487_8_1 -pt None -u 0.003882468761774484 > ./result_10chains/node487_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_9_2 -p 904 -st topic487_9_1 -pt None -u 0.003572540292730821 > ./result_10chains/node487_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_0_0 -p 47 -st none -pt topic487_0_0 -u 0.027761863567562495 > ./result_10chains/node487_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_1_0 -p 91 -st none -pt topic487_1_0 -u 0.0026519687906852996 > ./result_10chains/node487_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_2_0 -p 97 -st none -pt topic487_2_0 -u 0.04397449665350628 > ./result_10chains/node487_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_3_0 -p 106 -st none -pt topic487_3_0 -u 0.01864984571281808 > ./result_10chains/node487_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_4_0 -p 159 -st none -pt topic487_4_0 -u 0.004137708790354244 > ./result_10chains/node487_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_5_0 -p 333 -st none -pt topic487_5_0 -u 0.0949656879421216 > ./result_10chains/node487_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_6_0 -p 494 -st none -pt topic487_6_0 -u 0.0020769217121034134 > ./result_10chains/node487_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_7_0 -p 689 -st none -pt topic487_7_0 -u 0.012172689623705213 > ./result_10chains/node487_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node487_8_0 -p 858 -st none -pt topic487_8_0 -u 0.0202455282518912 > ./result_10chains/node487_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node487_9_0 -p 904 -st none -pt topic487_9_0 -u 0.008267045553609617 > ./result_10chains/node487_9_0.txt &
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
    "./result_10chains/node487_0_0.txt 90"
    "./result_10chains/node487_0_2.txt 90"
    "./result_10chains/node487_1_0.txt 89"
    "./result_10chains/node487_1_2.txt 89"
    "./result_10chains/node487_2_0.txt 88"
    "./result_10chains/node487_2_2.txt 88"
    "./result_10chains/node487_3_0.txt 87"
    "./result_10chains/node487_3_2.txt 87"
    "./result_10chains/node487_4_0.txt 86"
    "./result_10chains/node487_4_2.txt 86"
    "./result_10chains/node487_5_0.txt 85"
    "./result_10chains/node487_5_2.txt 85"
    "./result_10chains/node487_6_0.txt 84"
    "./result_10chains/node487_6_2.txt 84"
    "./result_10chains/node487_7_0.txt 83"
    "./result_10chains/node487_7_2.txt 83"
    "./result_10chains/node487_8_0.txt 82"
    "./result_10chains/node487_8_2.txt 82"
    "./result_10chains/node487_9_0.txt 81"
    "./result_10chains/node487_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
