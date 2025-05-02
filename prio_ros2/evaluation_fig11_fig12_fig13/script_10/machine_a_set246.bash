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
ros2 run evaluation_3_randomdag uunifast_node -n node246_0_2 -p 185 -st topic246_0_1 -pt None -u 0.05819445523403011 > ./result_10chains/node246_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_1_2 -p 196 -st topic246_1_1 -pt None -u 0.017594644901768375 > ./result_10chains/node246_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_2_2 -p 371 -st topic246_2_1 -pt None -u 0.008902878134052827 > ./result_10chains/node246_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_3_2 -p 382 -st topic246_3_1 -pt None -u 0.0021693756953777565 > ./result_10chains/node246_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_4_2 -p 663 -st topic246_4_1 -pt None -u 0.012861327676131601 > ./result_10chains/node246_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_5_2 -p 708 -st topic246_5_1 -pt None -u 0.006374668652072063 > ./result_10chains/node246_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_6_2 -p 724 -st topic246_6_1 -pt None -u 0.006675727590094993 > ./result_10chains/node246_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_7_2 -p 746 -st topic246_7_1 -pt None -u 0.017051796092838148 > ./result_10chains/node246_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_8_2 -p 922 -st topic246_8_1 -pt None -u 0.010456032858062653 > ./result_10chains/node246_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_9_2 -p 992 -st topic246_9_1 -pt None -u 0.0022206300725116502 > ./result_10chains/node246_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_0_0 -p 185 -st none -pt topic246_0_0 -u 0.010483259208543705 > ./result_10chains/node246_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_1_0 -p 196 -st none -pt topic246_1_0 -u 0.009287841271801212 > ./result_10chains/node246_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_2_0 -p 371 -st none -pt topic246_2_0 -u 0.08238959113570682 > ./result_10chains/node246_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_3_0 -p 382 -st none -pt topic246_3_0 -u 0.013799459562848726 > ./result_10chains/node246_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_4_0 -p 663 -st none -pt topic246_4_0 -u 0.027175709245641055 > ./result_10chains/node246_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_5_0 -p 708 -st none -pt topic246_5_0 -u 0.014592837617165177 > ./result_10chains/node246_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_6_0 -p 724 -st none -pt topic246_6_0 -u 0.012011619991616568 > ./result_10chains/node246_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_7_0 -p 746 -st none -pt topic246_7_0 -u 0.0008148732576510054 > ./result_10chains/node246_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_8_0 -p 922 -st none -pt topic246_8_0 -u 0.02049491006340458 > ./result_10chains/node246_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_9_0 -p 992 -st none -pt topic246_9_0 -u 0.046809990511239685 > ./result_10chains/node246_9_0.txt &
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
    "./result_10chains/node246_0_0.txt 90"
    "./result_10chains/node246_0_2.txt 90"
    "./result_10chains/node246_1_0.txt 89"
    "./result_10chains/node246_1_2.txt 89"
    "./result_10chains/node246_2_0.txt 88"
    "./result_10chains/node246_2_2.txt 88"
    "./result_10chains/node246_3_0.txt 87"
    "./result_10chains/node246_3_2.txt 87"
    "./result_10chains/node246_4_0.txt 86"
    "./result_10chains/node246_4_2.txt 86"
    "./result_10chains/node246_5_0.txt 85"
    "./result_10chains/node246_5_2.txt 85"
    "./result_10chains/node246_6_0.txt 84"
    "./result_10chains/node246_6_2.txt 84"
    "./result_10chains/node246_7_0.txt 83"
    "./result_10chains/node246_7_2.txt 83"
    "./result_10chains/node246_8_0.txt 82"
    "./result_10chains/node246_8_2.txt 82"
    "./result_10chains/node246_9_0.txt 81"
    "./result_10chains/node246_9_2.txt 81"
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
