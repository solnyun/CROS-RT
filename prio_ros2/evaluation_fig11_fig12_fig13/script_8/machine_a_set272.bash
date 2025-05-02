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
ros2 run evaluation_3_randomdag uunifast_node -n node272_0_2 -p 98 -st topic272_0_1 -pt None -u 0.011599977064271128 > ./result_8chains/node272_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_1_2 -p 463 -st topic272_1_1 -pt None -u 0.005539828633973842 > ./result_8chains/node272_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_2_2 -p 595 -st topic272_2_1 -pt None -u 0.013949994013198075 > ./result_8chains/node272_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_3_2 -p 675 -st topic272_3_1 -pt None -u 0.06170027372369988 > ./result_8chains/node272_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_4_2 -p 703 -st topic272_4_1 -pt None -u 0.018271524971163494 > ./result_8chains/node272_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_5_2 -p 719 -st topic272_5_1 -pt None -u 0.0007205554428512118 > ./result_8chains/node272_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_6_2 -p 784 -st topic272_6_1 -pt None -u 0.01913436238849356 > ./result_8chains/node272_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_7_2 -p 950 -st topic272_7_1 -pt None -u 0.03596904404682299 > ./result_8chains/node272_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_0_0 -p 98 -st none -pt topic272_0_0 -u 0.01312480859252102 > ./result_8chains/node272_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_1_0 -p 463 -st none -pt topic272_1_0 -u 0.049913862109794205 > ./result_8chains/node272_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_2_0 -p 595 -st none -pt topic272_2_0 -u 0.014006696538983954 > ./result_8chains/node272_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_3_0 -p 675 -st none -pt topic272_3_0 -u 0.024906587837118244 > ./result_8chains/node272_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_4_0 -p 703 -st none -pt topic272_4_0 -u 0.05140928814813969 > ./result_8chains/node272_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_5_0 -p 719 -st none -pt topic272_5_0 -u 0.0022132782030402642 > ./result_8chains/node272_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node272_6_0 -p 784 -st none -pt topic272_6_0 -u 0.03134187661161594 > ./result_8chains/node272_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node272_7_0 -p 950 -st none -pt topic272_7_0 -u 0.05224333927785005 > ./result_8chains/node272_7_0.txt &
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
    "./result_8chains/node272_0_0.txt 90"
    "./result_8chains/node272_0_2.txt 90"
    "./result_8chains/node272_1_0.txt 89"
    "./result_8chains/node272_1_2.txt 89"
    "./result_8chains/node272_2_0.txt 88"
    "./result_8chains/node272_2_2.txt 88"
    "./result_8chains/node272_3_0.txt 87"
    "./result_8chains/node272_3_2.txt 87"
    "./result_8chains/node272_4_0.txt 86"
    "./result_8chains/node272_4_2.txt 86"
    "./result_8chains/node272_5_0.txt 85"
    "./result_8chains/node272_5_2.txt 85"
    "./result_8chains/node272_6_0.txt 84"
    "./result_8chains/node272_6_2.txt 84"
    "./result_8chains/node272_7_0.txt 83"
    "./result_8chains/node272_7_2.txt 83"
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
