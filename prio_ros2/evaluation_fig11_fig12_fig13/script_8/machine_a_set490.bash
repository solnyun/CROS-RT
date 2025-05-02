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
ros2 run evaluation_3_randomdag uunifast_node -n node490_0_2 -p 50 -st topic490_0_1 -pt None -u 0.030005946192844246 > ./result_8chains/node490_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_1_2 -p 75 -st topic490_1_1 -pt None -u 0.01958146067752564 > ./result_8chains/node490_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_2_2 -p 102 -st topic490_2_1 -pt None -u 0.01347775442329946 > ./result_8chains/node490_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_3_2 -p 205 -st topic490_3_1 -pt None -u 0.03708313814045011 > ./result_8chains/node490_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_4_2 -p 215 -st topic490_4_1 -pt None -u 0.003972384534544154 > ./result_8chains/node490_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_5_2 -p 473 -st topic490_5_1 -pt None -u 0.04240065006201163 > ./result_8chains/node490_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_6_2 -p 534 -st topic490_6_1 -pt None -u 0.03974835946905579 > ./result_8chains/node490_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_7_2 -p 746 -st topic490_7_1 -pt None -u 0.01640958585666818 > ./result_8chains/node490_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_0_0 -p 50 -st none -pt topic490_0_0 -u 0.029934429755819447 > ./result_8chains/node490_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_1_0 -p 75 -st none -pt topic490_1_0 -u 0.010715126869597025 > ./result_8chains/node490_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_2_0 -p 102 -st none -pt topic490_2_0 -u 0.0006473309507924463 > ./result_8chains/node490_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_3_0 -p 205 -st none -pt topic490_3_0 -u 0.02966049171451618 > ./result_8chains/node490_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_4_0 -p 215 -st none -pt topic490_4_0 -u 0.00034291657661023045 > ./result_8chains/node490_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_5_0 -p 473 -st none -pt topic490_5_0 -u 0.0037811137480406043 > ./result_8chains/node490_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_6_0 -p 534 -st none -pt topic490_6_0 -u 0.015574829887173042 > ./result_8chains/node490_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_7_0 -p 746 -st none -pt topic490_7_0 -u 0.002711099472554542 > ./result_8chains/node490_7_0.txt &
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
    "./result_8chains/node490_0_0.txt 90"
    "./result_8chains/node490_0_2.txt 90"
    "./result_8chains/node490_1_0.txt 89"
    "./result_8chains/node490_1_2.txt 89"
    "./result_8chains/node490_2_0.txt 88"
    "./result_8chains/node490_2_2.txt 88"
    "./result_8chains/node490_3_0.txt 87"
    "./result_8chains/node490_3_2.txt 87"
    "./result_8chains/node490_4_0.txt 86"
    "./result_8chains/node490_4_2.txt 86"
    "./result_8chains/node490_5_0.txt 85"
    "./result_8chains/node490_5_2.txt 85"
    "./result_8chains/node490_6_0.txt 84"
    "./result_8chains/node490_6_2.txt 84"
    "./result_8chains/node490_7_0.txt 83"
    "./result_8chains/node490_7_2.txt 83"
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
