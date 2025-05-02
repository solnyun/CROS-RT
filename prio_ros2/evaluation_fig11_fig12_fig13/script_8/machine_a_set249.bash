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
ros2 run evaluation_3_randomdag uunifast_node -n node249_0_2 -p 115 -st topic249_0_1 -pt None -u 0.024709311089617603 > ./result_8chains/node249_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_1_2 -p 349 -st topic249_1_1 -pt None -u 0.0074660257173473354 > ./result_8chains/node249_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_2_2 -p 494 -st topic249_2_1 -pt None -u 0.003825193753758671 > ./result_8chains/node249_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_3_2 -p 638 -st topic249_3_1 -pt None -u 0.0458501064413433 > ./result_8chains/node249_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_4_2 -p 680 -st topic249_4_1 -pt None -u 0.021173791899616906 > ./result_8chains/node249_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_5_2 -p 820 -st topic249_5_1 -pt None -u 0.011270625797188252 > ./result_8chains/node249_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_6_2 -p 987 -st topic249_6_1 -pt None -u 0.0032497447936075813 > ./result_8chains/node249_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_7_2 -p 992 -st topic249_7_1 -pt None -u 0.008067395096353123 > ./result_8chains/node249_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_0_0 -p 115 -st none -pt topic249_0_0 -u 0.020014757416410733 > ./result_8chains/node249_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_1_0 -p 349 -st none -pt topic249_1_0 -u 0.00671276953915767 > ./result_8chains/node249_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_2_0 -p 494 -st none -pt topic249_2_0 -u 0.030141001689051483 > ./result_8chains/node249_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_3_0 -p 638 -st none -pt topic249_3_0 -u 0.010478992481192884 > ./result_8chains/node249_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_4_0 -p 680 -st none -pt topic249_4_0 -u 0.025305430041071802 > ./result_8chains/node249_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_5_0 -p 820 -st none -pt topic249_5_0 -u 0.007432078493892602 > ./result_8chains/node249_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node249_6_0 -p 987 -st none -pt topic249_6_0 -u 0.04219292656676106 > ./result_8chains/node249_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node249_7_0 -p 992 -st none -pt topic249_7_0 -u 0.0055061670664759595 > ./result_8chains/node249_7_0.txt &
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
    "./result_8chains/node249_0_0.txt 90"
    "./result_8chains/node249_0_2.txt 90"
    "./result_8chains/node249_1_0.txt 89"
    "./result_8chains/node249_1_2.txt 89"
    "./result_8chains/node249_2_0.txt 88"
    "./result_8chains/node249_2_2.txt 88"
    "./result_8chains/node249_3_0.txt 87"
    "./result_8chains/node249_3_2.txt 87"
    "./result_8chains/node249_4_0.txt 86"
    "./result_8chains/node249_4_2.txt 86"
    "./result_8chains/node249_5_0.txt 85"
    "./result_8chains/node249_5_2.txt 85"
    "./result_8chains/node249_6_0.txt 84"
    "./result_8chains/node249_6_2.txt 84"
    "./result_8chains/node249_7_0.txt 83"
    "./result_8chains/node249_7_2.txt 83"
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
