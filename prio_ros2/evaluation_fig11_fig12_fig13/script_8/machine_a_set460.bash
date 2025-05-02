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
ros2 run evaluation_3_randomdag uunifast_node -n node460_0_2 -p 89 -st topic460_0_1 -pt None -u 0.00946067484405122 > ./result_8chains/node460_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_1_2 -p 234 -st topic460_1_1 -pt None -u 0.018219663221626214 > ./result_8chains/node460_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_2_2 -p 333 -st topic460_2_1 -pt None -u 0.016141920274380328 > ./result_8chains/node460_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_3_2 -p 408 -st topic460_3_1 -pt None -u 0.005401621530036371 > ./result_8chains/node460_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_4_2 -p 426 -st topic460_4_1 -pt None -u 0.008505260253911628 > ./result_8chains/node460_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_5_2 -p 568 -st topic460_5_1 -pt None -u 0.033443103885641604 > ./result_8chains/node460_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_6_2 -p 662 -st topic460_6_1 -pt None -u 0.0005468404085847423 > ./result_8chains/node460_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_7_2 -p 708 -st topic460_7_1 -pt None -u 0.00020986155594041454 > ./result_8chains/node460_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_0_0 -p 89 -st none -pt topic460_0_0 -u 0.02346288622244752 > ./result_8chains/node460_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_1_0 -p 234 -st none -pt topic460_1_0 -u 0.015215002752076823 > ./result_8chains/node460_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_2_0 -p 333 -st none -pt topic460_2_0 -u 0.01038822228432823 > ./result_8chains/node460_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_3_0 -p 408 -st none -pt topic460_3_0 -u 0.006510727331912991 > ./result_8chains/node460_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_4_0 -p 426 -st none -pt topic460_4_0 -u 0.06722593020766623 > ./result_8chains/node460_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_5_0 -p 568 -st none -pt topic460_5_0 -u 0.03769802349273821 > ./result_8chains/node460_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node460_6_0 -p 662 -st none -pt topic460_6_0 -u 0.01211557774480057 > ./result_8chains/node460_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node460_7_0 -p 708 -st none -pt topic460_7_0 -u 0.02289183939516659 > ./result_8chains/node460_7_0.txt &
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
    "./result_8chains/node460_0_0.txt 90"
    "./result_8chains/node460_0_2.txt 90"
    "./result_8chains/node460_1_0.txt 89"
    "./result_8chains/node460_1_2.txt 89"
    "./result_8chains/node460_2_0.txt 88"
    "./result_8chains/node460_2_2.txt 88"
    "./result_8chains/node460_3_0.txt 87"
    "./result_8chains/node460_3_2.txt 87"
    "./result_8chains/node460_4_0.txt 86"
    "./result_8chains/node460_4_2.txt 86"
    "./result_8chains/node460_5_0.txt 85"
    "./result_8chains/node460_5_2.txt 85"
    "./result_8chains/node460_6_0.txt 84"
    "./result_8chains/node460_6_2.txt 84"
    "./result_8chains/node460_7_0.txt 83"
    "./result_8chains/node460_7_2.txt 83"
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
