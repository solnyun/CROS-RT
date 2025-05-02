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
ros2 run evaluation_3_randomdag uunifast_node -n node29_0_2 -p 110 -st topic29_0_1 -pt None -u 0.015466702353227557 > ./result_8chains/node29_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_1_2 -p 211 -st topic29_1_1 -pt None -u 0.014448997637982686 > ./result_8chains/node29_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_2_2 -p 516 -st topic29_2_1 -pt None -u 0.017740721286566785 > ./result_8chains/node29_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_3_2 -p 581 -st topic29_3_1 -pt None -u 0.016695876831430728 > ./result_8chains/node29_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_4_2 -p 749 -st topic29_4_1 -pt None -u 0.0187941494321118 > ./result_8chains/node29_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_5_2 -p 817 -st topic29_5_1 -pt None -u 0.029359404756517077 > ./result_8chains/node29_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_6_2 -p 943 -st topic29_6_1 -pt None -u 0.05584510300169927 > ./result_8chains/node29_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_7_2 -p 990 -st topic29_7_1 -pt None -u 0.046414284795364066 > ./result_8chains/node29_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_0_0 -p 110 -st none -pt topic29_0_0 -u 0.03127761436551535 > ./result_8chains/node29_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_1_0 -p 211 -st none -pt topic29_1_0 -u 0.021997917233205044 > ./result_8chains/node29_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_2_0 -p 516 -st none -pt topic29_2_0 -u 0.035466478245062216 > ./result_8chains/node29_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_3_0 -p 581 -st none -pt topic29_3_0 -u 0.0010362856192655534 > ./result_8chains/node29_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_4_0 -p 749 -st none -pt topic29_4_0 -u 0.0033849995921282905 > ./result_8chains/node29_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_5_0 -p 817 -st none -pt topic29_5_0 -u 0.009296591660823222 > ./result_8chains/node29_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node29_6_0 -p 943 -st none -pt topic29_6_0 -u 0.013584965725495723 > ./result_8chains/node29_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node29_7_0 -p 990 -st none -pt topic29_7_0 -u 0.02356613330061836 > ./result_8chains/node29_7_0.txt &
sleep 10
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
    "./result_8chains/node29_0_0.txt 90"
    "./result_8chains/node29_0_2.txt 90"
    "./result_8chains/node29_1_0.txt 89"
    "./result_8chains/node29_1_2.txt 89"
    "./result_8chains/node29_2_0.txt 88"
    "./result_8chains/node29_2_2.txt 88"
    "./result_8chains/node29_3_0.txt 87"
    "./result_8chains/node29_3_2.txt 87"
    "./result_8chains/node29_4_0.txt 86"
    "./result_8chains/node29_4_2.txt 86"
    "./result_8chains/node29_5_0.txt 85"
    "./result_8chains/node29_5_2.txt 85"
    "./result_8chains/node29_6_0.txt 84"
    "./result_8chains/node29_6_2.txt 84"
    "./result_8chains/node29_7_0.txt 83"
    "./result_8chains/node29_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
