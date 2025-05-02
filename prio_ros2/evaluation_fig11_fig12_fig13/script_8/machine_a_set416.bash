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
ros2 run evaluation_3_randomdag uunifast_node -n node416_0_2 -p 83 -st topic416_0_1 -pt None -u 0.035600377205874 > ./result_8chains/node416_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_1_2 -p 120 -st topic416_1_1 -pt None -u 0.025708709179605493 > ./result_8chains/node416_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_2_2 -p 163 -st topic416_2_1 -pt None -u 0.013549291421105225 > ./result_8chains/node416_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_3_2 -p 388 -st topic416_3_1 -pt None -u 0.0023878263452247195 > ./result_8chains/node416_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_4_2 -p 450 -st topic416_4_1 -pt None -u 0.0005080207399735526 > ./result_8chains/node416_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_5_2 -p 538 -st topic416_5_1 -pt None -u 0.006122170141137417 > ./result_8chains/node416_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_6_2 -p 651 -st topic416_6_1 -pt None -u 0.03633814834433356 > ./result_8chains/node416_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_7_2 -p 975 -st topic416_7_1 -pt None -u 0.013138244627552692 > ./result_8chains/node416_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_0_0 -p 83 -st none -pt topic416_0_0 -u 0.012779566824579758 > ./result_8chains/node416_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_1_0 -p 120 -st none -pt topic416_1_0 -u 0.0006596135846059781 > ./result_8chains/node416_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_2_0 -p 163 -st none -pt topic416_2_0 -u 0.005954684987642511 > ./result_8chains/node416_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_3_0 -p 388 -st none -pt topic416_3_0 -u 0.03004979676835201 > ./result_8chains/node416_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_4_0 -p 450 -st none -pt topic416_4_0 -u 0.0018373468728020148 > ./result_8chains/node416_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_5_0 -p 538 -st none -pt topic416_5_0 -u 0.0009110057813147276 > ./result_8chains/node416_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_6_0 -p 651 -st none -pt topic416_6_0 -u 0.01343408857997308 > ./result_8chains/node416_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_7_0 -p 975 -st none -pt topic416_7_0 -u 0.06296095837783543 > ./result_8chains/node416_7_0.txt &
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
    "./result_8chains/node416_0_0.txt 90"
    "./result_8chains/node416_0_2.txt 90"
    "./result_8chains/node416_1_0.txt 89"
    "./result_8chains/node416_1_2.txt 89"
    "./result_8chains/node416_2_0.txt 88"
    "./result_8chains/node416_2_2.txt 88"
    "./result_8chains/node416_3_0.txt 87"
    "./result_8chains/node416_3_2.txt 87"
    "./result_8chains/node416_4_0.txt 86"
    "./result_8chains/node416_4_2.txt 86"
    "./result_8chains/node416_5_0.txt 85"
    "./result_8chains/node416_5_2.txt 85"
    "./result_8chains/node416_6_0.txt 84"
    "./result_8chains/node416_6_2.txt 84"
    "./result_8chains/node416_7_0.txt 83"
    "./result_8chains/node416_7_2.txt 83"
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
