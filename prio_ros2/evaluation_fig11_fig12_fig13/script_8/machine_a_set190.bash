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
ros2 run evaluation_3_randomdag uunifast_node -n node190_0_2 -p 14 -st topic190_0_1 -pt None -u 0.06714954529841138 > ./result_8chains/node190_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_1_2 -p 322 -st topic190_1_1 -pt None -u 0.046609644819349094 > ./result_8chains/node190_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_2_2 -p 391 -st topic190_2_1 -pt None -u 0.001500126724692158 > ./result_8chains/node190_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_3_2 -p 393 -st topic190_3_1 -pt None -u 0.04427404591192366 > ./result_8chains/node190_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_4_2 -p 409 -st topic190_4_1 -pt None -u 0.009920311563554357 > ./result_8chains/node190_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_5_2 -p 663 -st topic190_5_1 -pt None -u 0.029537498161113618 > ./result_8chains/node190_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_6_2 -p 674 -st topic190_6_1 -pt None -u 0.006319139186943906 > ./result_8chains/node190_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_7_2 -p 830 -st topic190_7_1 -pt None -u 0.019656940992595094 > ./result_8chains/node190_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_0_0 -p 14 -st none -pt topic190_0_0 -u 0.02185512150033131 > ./result_8chains/node190_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_1_0 -p 322 -st none -pt topic190_1_0 -u 0.02922215989002408 > ./result_8chains/node190_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_2_0 -p 391 -st none -pt topic190_2_0 -u 0.010633955630179215 > ./result_8chains/node190_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_3_0 -p 393 -st none -pt topic190_3_0 -u 0.006048966627149072 > ./result_8chains/node190_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_4_0 -p 409 -st none -pt topic190_4_0 -u 0.011039708199609727 > ./result_8chains/node190_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_5_0 -p 663 -st none -pt topic190_5_0 -u 0.02435109228296692 > ./result_8chains/node190_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node190_6_0 -p 674 -st none -pt topic190_6_0 -u 0.02792391354453657 > ./result_8chains/node190_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node190_7_0 -p 830 -st none -pt topic190_7_0 -u 0.0009906488759542711 > ./result_8chains/node190_7_0.txt &
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
    "./result_8chains/node190_0_0.txt 90"
    "./result_8chains/node190_0_2.txt 90"
    "./result_8chains/node190_1_0.txt 89"
    "./result_8chains/node190_1_2.txt 89"
    "./result_8chains/node190_2_0.txt 88"
    "./result_8chains/node190_2_2.txt 88"
    "./result_8chains/node190_3_0.txt 87"
    "./result_8chains/node190_3_2.txt 87"
    "./result_8chains/node190_4_0.txt 86"
    "./result_8chains/node190_4_2.txt 86"
    "./result_8chains/node190_5_0.txt 85"
    "./result_8chains/node190_5_2.txt 85"
    "./result_8chains/node190_6_0.txt 84"
    "./result_8chains/node190_6_2.txt 84"
    "./result_8chains/node190_7_0.txt 83"
    "./result_8chains/node190_7_2.txt 83"
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
