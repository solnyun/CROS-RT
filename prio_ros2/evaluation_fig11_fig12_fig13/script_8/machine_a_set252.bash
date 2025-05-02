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
ros2 run evaluation_3_randomdag uunifast_node -n node252_0_2 -p 37 -st topic252_0_1 -pt None -u 0.004699035976232502 > ./result_8chains/node252_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_1_2 -p 330 -st topic252_1_1 -pt None -u 0.007822402030930542 > ./result_8chains/node252_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_2_2 -p 407 -st topic252_2_1 -pt None -u 0.009412606362015241 > ./result_8chains/node252_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_3_2 -p 459 -st topic252_3_1 -pt None -u 0.039633889178042 > ./result_8chains/node252_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_4_2 -p 633 -st topic252_4_1 -pt None -u 0.01768925468884258 > ./result_8chains/node252_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_5_2 -p 784 -st topic252_5_1 -pt None -u 0.004727764056900688 > ./result_8chains/node252_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_6_2 -p 826 -st topic252_6_1 -pt None -u 0.02462371656975889 > ./result_8chains/node252_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_7_2 -p 860 -st topic252_7_1 -pt None -u 0.047095446539901165 > ./result_8chains/node252_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_0_0 -p 37 -st none -pt topic252_0_0 -u 0.049626389407959104 > ./result_8chains/node252_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_1_0 -p 330 -st none -pt topic252_1_0 -u 0.028125710000273807 > ./result_8chains/node252_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_2_0 -p 407 -st none -pt topic252_2_0 -u 0.006476940263771824 > ./result_8chains/node252_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_3_0 -p 459 -st none -pt topic252_3_0 -u 0.012520287605624791 > ./result_8chains/node252_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_4_0 -p 633 -st none -pt topic252_4_0 -u 0.011850983056490322 > ./result_8chains/node252_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_5_0 -p 784 -st none -pt topic252_5_0 -u 0.03169939573396116 > ./result_8chains/node252_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node252_6_0 -p 826 -st none -pt topic252_6_0 -u 0.008992037696065713 > ./result_8chains/node252_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node252_7_0 -p 860 -st none -pt topic252_7_0 -u 0.0026912490093141325 > ./result_8chains/node252_7_0.txt &
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
    "./result_8chains/node252_0_0.txt 90"
    "./result_8chains/node252_0_2.txt 90"
    "./result_8chains/node252_1_0.txt 89"
    "./result_8chains/node252_1_2.txt 89"
    "./result_8chains/node252_2_0.txt 88"
    "./result_8chains/node252_2_2.txt 88"
    "./result_8chains/node252_3_0.txt 87"
    "./result_8chains/node252_3_2.txt 87"
    "./result_8chains/node252_4_0.txt 86"
    "./result_8chains/node252_4_2.txt 86"
    "./result_8chains/node252_5_0.txt 85"
    "./result_8chains/node252_5_2.txt 85"
    "./result_8chains/node252_6_0.txt 84"
    "./result_8chains/node252_6_2.txt 84"
    "./result_8chains/node252_7_0.txt 83"
    "./result_8chains/node252_7_2.txt 83"
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
