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
ros2 run evaluation_3_randomdag uunifast_node -n node141_0_2 -p 95 -st topic141_0_1 -pt None -u 0.02389985518298715 > ./result_8chains/node141_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_1_2 -p 445 -st topic141_1_1 -pt None -u 0.01818764746917334 > ./result_8chains/node141_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_2_2 -p 482 -st topic141_2_1 -pt None -u 5.634883116151235e-05 > ./result_8chains/node141_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_3_2 -p 499 -st topic141_3_1 -pt None -u 0.01057545514436753 > ./result_8chains/node141_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_4_2 -p 548 -st topic141_4_1 -pt None -u 0.02433303729710226 > ./result_8chains/node141_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_5_2 -p 673 -st topic141_5_1 -pt None -u 0.00391751979683784 > ./result_8chains/node141_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_6_2 -p 820 -st topic141_6_1 -pt None -u 0.003617866590194238 > ./result_8chains/node141_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_7_2 -p 876 -st topic141_7_1 -pt None -u 0.03019672717968074 > ./result_8chains/node141_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_0_0 -p 95 -st none -pt topic141_0_0 -u 0.012675431634362522 > ./result_8chains/node141_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_1_0 -p 445 -st none -pt topic141_1_0 -u 0.0019271291767805065 > ./result_8chains/node141_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_2_0 -p 482 -st none -pt topic141_2_0 -u 0.03411376142024691 > ./result_8chains/node141_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_3_0 -p 499 -st none -pt topic141_3_0 -u 0.064225305401035 > ./result_8chains/node141_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_4_0 -p 548 -st none -pt topic141_4_0 -u 0.004809602947171199 > ./result_8chains/node141_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_5_0 -p 673 -st none -pt topic141_5_0 -u 0.11621075053525429 > ./result_8chains/node141_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_6_0 -p 820 -st none -pt topic141_6_0 -u 0.0005000065618567667 > ./result_8chains/node141_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node141_7_0 -p 876 -st none -pt topic141_7_0 -u 0.005718947228995734 > ./result_8chains/node141_7_0.txt &
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
    "./result_8chains/node141_0_0.txt 90"
    "./result_8chains/node141_0_2.txt 90"
    "./result_8chains/node141_1_0.txt 89"
    "./result_8chains/node141_1_2.txt 89"
    "./result_8chains/node141_2_0.txt 88"
    "./result_8chains/node141_2_2.txt 88"
    "./result_8chains/node141_3_0.txt 87"
    "./result_8chains/node141_3_2.txt 87"
    "./result_8chains/node141_4_0.txt 86"
    "./result_8chains/node141_4_2.txt 86"
    "./result_8chains/node141_5_0.txt 85"
    "./result_8chains/node141_5_2.txt 85"
    "./result_8chains/node141_6_0.txt 84"
    "./result_8chains/node141_6_2.txt 84"
    "./result_8chains/node141_7_0.txt 83"
    "./result_8chains/node141_7_2.txt 83"
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
