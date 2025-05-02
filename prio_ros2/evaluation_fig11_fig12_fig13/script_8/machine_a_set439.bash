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
ros2 run evaluation_3_randomdag uunifast_node -n node439_0_2 -p 45 -st topic439_0_1 -pt None -u 0.044827895492891845 > ./result_8chains/node439_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_1_2 -p 60 -st topic439_1_1 -pt None -u 0.010457006718302464 > ./result_8chains/node439_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_2_2 -p 207 -st topic439_2_1 -pt None -u 0.003469895443158788 > ./result_8chains/node439_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_3_2 -p 267 -st topic439_3_1 -pt None -u 0.0007817088295778984 > ./result_8chains/node439_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_4_2 -p 688 -st topic439_4_1 -pt None -u 0.0081479763706796 > ./result_8chains/node439_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_5_2 -p 826 -st topic439_5_1 -pt None -u 0.03795449110775134 > ./result_8chains/node439_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_6_2 -p 901 -st topic439_6_1 -pt None -u 0.0019027211316671525 > ./result_8chains/node439_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_7_2 -p 967 -st topic439_7_1 -pt None -u 0.015498514228231973 > ./result_8chains/node439_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_0_0 -p 45 -st none -pt topic439_0_0 -u 0.010383184497883835 > ./result_8chains/node439_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_1_0 -p 60 -st none -pt topic439_1_0 -u 0.009226401164873776 > ./result_8chains/node439_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_2_0 -p 207 -st none -pt topic439_2_0 -u 0.05778138651118386 > ./result_8chains/node439_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_3_0 -p 267 -st none -pt topic439_3_0 -u 0.06325491262028382 > ./result_8chains/node439_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_4_0 -p 688 -st none -pt topic439_4_0 -u 0.020870347957912233 > ./result_8chains/node439_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_5_0 -p 826 -st none -pt topic439_5_0 -u 0.004688895685513589 > ./result_8chains/node439_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_6_0 -p 901 -st none -pt topic439_6_0 -u 0.00332552489072957 > ./result_8chains/node439_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node439_7_0 -p 967 -st none -pt topic439_7_0 -u 7.778241754013288e-05 > ./result_8chains/node439_7_0.txt &
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
    "./result_8chains/node439_0_0.txt 90"
    "./result_8chains/node439_0_2.txt 90"
    "./result_8chains/node439_1_0.txt 89"
    "./result_8chains/node439_1_2.txt 89"
    "./result_8chains/node439_2_0.txt 88"
    "./result_8chains/node439_2_2.txt 88"
    "./result_8chains/node439_3_0.txt 87"
    "./result_8chains/node439_3_2.txt 87"
    "./result_8chains/node439_4_0.txt 86"
    "./result_8chains/node439_4_2.txt 86"
    "./result_8chains/node439_5_0.txt 85"
    "./result_8chains/node439_5_2.txt 85"
    "./result_8chains/node439_6_0.txt 84"
    "./result_8chains/node439_6_2.txt 84"
    "./result_8chains/node439_7_0.txt 83"
    "./result_8chains/node439_7_2.txt 83"
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
