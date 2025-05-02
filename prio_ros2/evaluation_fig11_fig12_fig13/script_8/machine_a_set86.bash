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
ros2 run evaluation_3_randomdag uunifast_node -n node86_0_2 -p 92 -st topic86_0_1 -pt None -u 0.023998922886486307 > ./result_8chains/node86_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_1_2 -p 239 -st topic86_1_1 -pt None -u 0.04445551409805987 > ./result_8chains/node86_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_2_2 -p 310 -st topic86_2_1 -pt None -u 0.0211214521995981 > ./result_8chains/node86_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_3_2 -p 480 -st topic86_3_1 -pt None -u 0.01730684666468374 > ./result_8chains/node86_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_4_2 -p 538 -st topic86_4_1 -pt None -u 0.005060068745796398 > ./result_8chains/node86_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_5_2 -p 789 -st topic86_5_1 -pt None -u 0.002801817119720773 > ./result_8chains/node86_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_6_2 -p 940 -st topic86_6_1 -pt None -u 0.02305962783122291 > ./result_8chains/node86_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_7_2 -p 961 -st topic86_7_1 -pt None -u 0.019868493948714296 > ./result_8chains/node86_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_0_0 -p 92 -st none -pt topic86_0_0 -u 0.005891056036295583 > ./result_8chains/node86_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_1_0 -p 239 -st none -pt topic86_1_0 -u 0.021828435413547786 > ./result_8chains/node86_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_2_0 -p 310 -st none -pt topic86_2_0 -u 0.027736724033885163 > ./result_8chains/node86_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_3_0 -p 480 -st none -pt topic86_3_0 -u 0.016178577319240828 > ./result_8chains/node86_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_4_0 -p 538 -st none -pt topic86_4_0 -u 0.027174532597781326 > ./result_8chains/node86_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_5_0 -p 789 -st none -pt topic86_5_0 -u 0.00939186115393345 > ./result_8chains/node86_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node86_6_0 -p 940 -st none -pt topic86_6_0 -u 0.007415604351199145 > ./result_8chains/node86_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node86_7_0 -p 961 -st none -pt topic86_7_0 -u 0.04458570321552241 > ./result_8chains/node86_7_0.txt &
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
    "./result_8chains/node86_0_0.txt 90"
    "./result_8chains/node86_0_2.txt 90"
    "./result_8chains/node86_1_0.txt 89"
    "./result_8chains/node86_1_2.txt 89"
    "./result_8chains/node86_2_0.txt 88"
    "./result_8chains/node86_2_2.txt 88"
    "./result_8chains/node86_3_0.txt 87"
    "./result_8chains/node86_3_2.txt 87"
    "./result_8chains/node86_4_0.txt 86"
    "./result_8chains/node86_4_2.txt 86"
    "./result_8chains/node86_5_0.txt 85"
    "./result_8chains/node86_5_2.txt 85"
    "./result_8chains/node86_6_0.txt 84"
    "./result_8chains/node86_6_2.txt 84"
    "./result_8chains/node86_7_0.txt 83"
    "./result_8chains/node86_7_2.txt 83"
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
