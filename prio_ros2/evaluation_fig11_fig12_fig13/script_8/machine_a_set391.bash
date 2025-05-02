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
ros2 run evaluation_3_randomdag uunifast_node -n node391_0_2 -p 66 -st topic391_0_1 -pt None -u 0.014130075483498317 > ./result_8chains/node391_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_1_2 -p 106 -st topic391_1_1 -pt None -u 0.0025828831428412746 > ./result_8chains/node391_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_2_2 -p 108 -st topic391_2_1 -pt None -u 0.03536204811265414 > ./result_8chains/node391_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_3_2 -p 468 -st topic391_3_1 -pt None -u 0.003280184451194823 > ./result_8chains/node391_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_4_2 -p 493 -st topic391_4_1 -pt None -u 0.038904628632453614 > ./result_8chains/node391_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_5_2 -p 680 -st topic391_5_1 -pt None -u 0.007010022812454386 > ./result_8chains/node391_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_6_2 -p 689 -st topic391_6_1 -pt None -u 0.031319992101232944 > ./result_8chains/node391_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_7_2 -p 861 -st topic391_7_1 -pt None -u 0.04099870551559848 > ./result_8chains/node391_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_0_0 -p 66 -st none -pt topic391_0_0 -u 0.03258644097589308 > ./result_8chains/node391_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_1_0 -p 106 -st none -pt topic391_1_0 -u 0.005233301268363633 > ./result_8chains/node391_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_2_0 -p 108 -st none -pt topic391_2_0 -u 0.026616800336344726 > ./result_8chains/node391_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_3_0 -p 468 -st none -pt topic391_3_0 -u 0.02391286562482564 > ./result_8chains/node391_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_4_0 -p 493 -st none -pt topic391_4_0 -u 0.0018505736398271022 > ./result_8chains/node391_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_5_0 -p 680 -st none -pt topic391_5_0 -u 0.005215886537509734 > ./result_8chains/node391_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_6_0 -p 689 -st none -pt topic391_6_0 -u 0.02500400255236873 > ./result_8chains/node391_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_7_0 -p 861 -st none -pt topic391_7_0 -u 0.04709383038341125 > ./result_8chains/node391_7_0.txt &
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
    "./result_8chains/node391_0_0.txt 90"
    "./result_8chains/node391_0_2.txt 90"
    "./result_8chains/node391_1_0.txt 89"
    "./result_8chains/node391_1_2.txt 89"
    "./result_8chains/node391_2_0.txt 88"
    "./result_8chains/node391_2_2.txt 88"
    "./result_8chains/node391_3_0.txt 87"
    "./result_8chains/node391_3_2.txt 87"
    "./result_8chains/node391_4_0.txt 86"
    "./result_8chains/node391_4_2.txt 86"
    "./result_8chains/node391_5_0.txt 85"
    "./result_8chains/node391_5_2.txt 85"
    "./result_8chains/node391_6_0.txt 84"
    "./result_8chains/node391_6_2.txt 84"
    "./result_8chains/node391_7_0.txt 83"
    "./result_8chains/node391_7_2.txt 83"
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
