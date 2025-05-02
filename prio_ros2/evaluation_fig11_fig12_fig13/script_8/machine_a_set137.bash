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
ros2 run evaluation_3_randomdag uunifast_node -n node137_0_2 -p 98 -st topic137_0_1 -pt None -u 0.021250714811075988 > ./result_8chains/node137_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_1_2 -p 191 -st topic137_1_1 -pt None -u 0.004217752032862676 > ./result_8chains/node137_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_2_2 -p 219 -st topic137_2_1 -pt None -u 0.010091994104248103 > ./result_8chains/node137_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_3_2 -p 307 -st topic137_3_1 -pt None -u 0.0686317928951716 > ./result_8chains/node137_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_4_2 -p 381 -st topic137_4_1 -pt None -u 0.008385764854829891 > ./result_8chains/node137_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_5_2 -p 609 -st topic137_5_1 -pt None -u 0.014929852203979493 > ./result_8chains/node137_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_6_2 -p 610 -st topic137_6_1 -pt None -u 0.02192970288854782 > ./result_8chains/node137_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_7_2 -p 833 -st topic137_7_1 -pt None -u 0.02036954047371584 > ./result_8chains/node137_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_0_0 -p 98 -st none -pt topic137_0_0 -u 0.024958187584971203 > ./result_8chains/node137_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_1_0 -p 191 -st none -pt topic137_1_0 -u 0.001990256626535236 > ./result_8chains/node137_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_2_0 -p 219 -st none -pt topic137_2_0 -u 0.029258797790777835 > ./result_8chains/node137_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_3_0 -p 307 -st none -pt topic137_3_0 -u 0.05770645779727612 > ./result_8chains/node137_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_4_0 -p 381 -st none -pt topic137_4_0 -u 0.0051425968013616985 > ./result_8chains/node137_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_5_0 -p 609 -st none -pt topic137_5_0 -u 3.1709414270608693e-05 > ./result_8chains/node137_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node137_6_0 -p 610 -st none -pt topic137_6_0 -u 0.005727022440490975 > ./result_8chains/node137_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node137_7_0 -p 833 -st none -pt topic137_7_0 -u 0.022711078124769267 > ./result_8chains/node137_7_0.txt &
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
    "./result_8chains/node137_0_0.txt 90"
    "./result_8chains/node137_0_2.txt 90"
    "./result_8chains/node137_1_0.txt 89"
    "./result_8chains/node137_1_2.txt 89"
    "./result_8chains/node137_2_0.txt 88"
    "./result_8chains/node137_2_2.txt 88"
    "./result_8chains/node137_3_0.txt 87"
    "./result_8chains/node137_3_2.txt 87"
    "./result_8chains/node137_4_0.txt 86"
    "./result_8chains/node137_4_2.txt 86"
    "./result_8chains/node137_5_0.txt 85"
    "./result_8chains/node137_5_2.txt 85"
    "./result_8chains/node137_6_0.txt 84"
    "./result_8chains/node137_6_2.txt 84"
    "./result_8chains/node137_7_0.txt 83"
    "./result_8chains/node137_7_2.txt 83"
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
