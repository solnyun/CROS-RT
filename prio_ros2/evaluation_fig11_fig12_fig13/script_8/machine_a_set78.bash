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
ros2 run evaluation_3_randomdag uunifast_node -n node78_0_2 -p 39 -st topic78_0_1 -pt None -u 0.013991452832465057 > ./result_8chains/node78_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_1_2 -p 103 -st topic78_1_1 -pt None -u 0.006009521759398173 > ./result_8chains/node78_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_2_2 -p 132 -st topic78_2_1 -pt None -u 0.02153277274949994 > ./result_8chains/node78_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_3_2 -p 135 -st topic78_3_1 -pt None -u 0.007518208932628501 > ./result_8chains/node78_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_4_2 -p 276 -st topic78_4_1 -pt None -u 0.01269993982278017 > ./result_8chains/node78_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_5_2 -p 299 -st topic78_5_1 -pt None -u 0.005547412710458666 > ./result_8chains/node78_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_6_2 -p 610 -st topic78_6_1 -pt None -u 0.03647631671863287 > ./result_8chains/node78_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_7_2 -p 882 -st topic78_7_1 -pt None -u 0.0009617676470120574 > ./result_8chains/node78_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_0_0 -p 39 -st none -pt topic78_0_0 -u 0.0012367460546818254 > ./result_8chains/node78_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_1_0 -p 103 -st none -pt topic78_1_0 -u 0.010223393944496173 > ./result_8chains/node78_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_2_0 -p 132 -st none -pt topic78_2_0 -u 0.04876959937183828 > ./result_8chains/node78_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_3_0 -p 135 -st none -pt topic78_3_0 -u 0.012107245347976081 > ./result_8chains/node78_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_4_0 -p 276 -st none -pt topic78_4_0 -u 0.00047076363984976943 > ./result_8chains/node78_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_5_0 -p 299 -st none -pt topic78_5_0 -u 0.11762873620970918 > ./result_8chains/node78_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_6_0 -p 610 -st none -pt topic78_6_0 -u 0.06350205530278423 > ./result_8chains/node78_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node78_7_0 -p 882 -st none -pt topic78_7_0 -u 0.019606782782253106 > ./result_8chains/node78_7_0.txt &
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
    "./result_8chains/node78_0_0.txt 90"
    "./result_8chains/node78_0_2.txt 90"
    "./result_8chains/node78_1_0.txt 89"
    "./result_8chains/node78_1_2.txt 89"
    "./result_8chains/node78_2_0.txt 88"
    "./result_8chains/node78_2_2.txt 88"
    "./result_8chains/node78_3_0.txt 87"
    "./result_8chains/node78_3_2.txt 87"
    "./result_8chains/node78_4_0.txt 86"
    "./result_8chains/node78_4_2.txt 86"
    "./result_8chains/node78_5_0.txt 85"
    "./result_8chains/node78_5_2.txt 85"
    "./result_8chains/node78_6_0.txt 84"
    "./result_8chains/node78_6_2.txt 84"
    "./result_8chains/node78_7_0.txt 83"
    "./result_8chains/node78_7_2.txt 83"
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
