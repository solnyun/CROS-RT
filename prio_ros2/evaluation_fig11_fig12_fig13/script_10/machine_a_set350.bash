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
ros2 run evaluation_3_randomdag uunifast_node -n node350_0_2 -p 116 -st topic350_0_1 -pt None -u 0.01653329831885264 > ./result_10chains/node350_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_1_2 -p 222 -st topic350_1_1 -pt None -u 0.018849381635054896 > ./result_10chains/node350_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_2_2 -p 285 -st topic350_2_1 -pt None -u 0.033426036648427804 > ./result_10chains/node350_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_3_2 -p 423 -st topic350_3_1 -pt None -u 0.01079005842166203 > ./result_10chains/node350_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_4_2 -p 450 -st topic350_4_1 -pt None -u 0.010164860324560848 > ./result_10chains/node350_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_5_2 -p 579 -st topic350_5_1 -pt None -u 0.03364333433736902 > ./result_10chains/node350_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_6_2 -p 599 -st topic350_6_1 -pt None -u 0.0009484045362569138 > ./result_10chains/node350_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_7_2 -p 719 -st topic350_7_1 -pt None -u 0.00592529916561671 > ./result_10chains/node350_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_8_2 -p 785 -st topic350_8_1 -pt None -u 0.007659092164180412 > ./result_10chains/node350_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_9_2 -p 979 -st topic350_9_1 -pt None -u 0.012326465615935074 > ./result_10chains/node350_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_0_0 -p 116 -st none -pt topic350_0_0 -u 0.015143489921164932 > ./result_10chains/node350_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_1_0 -p 222 -st none -pt topic350_1_0 -u 0.04134394498744054 > ./result_10chains/node350_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_2_0 -p 285 -st none -pt topic350_2_0 -u 0.0037928832319943373 > ./result_10chains/node350_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_3_0 -p 423 -st none -pt topic350_3_0 -u 0.028847587082512227 > ./result_10chains/node350_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_4_0 -p 450 -st none -pt topic350_4_0 -u 0.02538694937363209 > ./result_10chains/node350_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_5_0 -p 579 -st none -pt topic350_5_0 -u 0.007803409196992822 > ./result_10chains/node350_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_6_0 -p 599 -st none -pt topic350_6_0 -u 0.0036995671316637224 > ./result_10chains/node350_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_7_0 -p 719 -st none -pt topic350_7_0 -u 0.003271115741217634 > ./result_10chains/node350_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_8_0 -p 785 -st none -pt topic350_8_0 -u 0.008209833633084807 > ./result_10chains/node350_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node350_9_0 -p 979 -st none -pt topic350_9_0 -u 0.04248432214179765 > ./result_10chains/node350_9_0.txt &
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
    "./result_10chains/node350_0_0.txt 90"
    "./result_10chains/node350_0_2.txt 90"
    "./result_10chains/node350_1_0.txt 89"
    "./result_10chains/node350_1_2.txt 89"
    "./result_10chains/node350_2_0.txt 88"
    "./result_10chains/node350_2_2.txt 88"
    "./result_10chains/node350_3_0.txt 87"
    "./result_10chains/node350_3_2.txt 87"
    "./result_10chains/node350_4_0.txt 86"
    "./result_10chains/node350_4_2.txt 86"
    "./result_10chains/node350_5_0.txt 85"
    "./result_10chains/node350_5_2.txt 85"
    "./result_10chains/node350_6_0.txt 84"
    "./result_10chains/node350_6_2.txt 84"
    "./result_10chains/node350_7_0.txt 83"
    "./result_10chains/node350_7_2.txt 83"
    "./result_10chains/node350_8_0.txt 82"
    "./result_10chains/node350_8_2.txt 82"
    "./result_10chains/node350_9_0.txt 81"
    "./result_10chains/node350_9_2.txt 81"
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
