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
ros2 run evaluation_3_randomdag uunifast_node -n node277_0_2 -p 16 -st topic277_0_1 -pt None -u 0.002789601094532246 > ./result_8chains/node277_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_1_2 -p 172 -st topic277_1_1 -pt None -u 0.011066676321736524 > ./result_8chains/node277_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_2_2 -p 277 -st topic277_2_1 -pt None -u 0.11006862890117805 > ./result_8chains/node277_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_3_2 -p 348 -st topic277_3_1 -pt None -u 0.007410132025554073 > ./result_8chains/node277_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_4_2 -p 492 -st topic277_4_1 -pt None -u 0.018865744713688848 > ./result_8chains/node277_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_5_2 -p 564 -st topic277_5_1 -pt None -u 0.0067834494080532826 > ./result_8chains/node277_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_6_2 -p 672 -st topic277_6_1 -pt None -u 0.012200948749009115 > ./result_8chains/node277_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_7_2 -p 764 -st topic277_7_1 -pt None -u 0.0369890929305015 > ./result_8chains/node277_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_0_0 -p 16 -st none -pt topic277_0_0 -u 0.03247122519584128 > ./result_8chains/node277_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_1_0 -p 172 -st none -pt topic277_1_0 -u 0.037584838172649404 > ./result_8chains/node277_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_2_0 -p 277 -st none -pt topic277_2_0 -u 0.0027499719907990716 > ./result_8chains/node277_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_3_0 -p 348 -st none -pt topic277_3_0 -u 0.01820671657927972 > ./result_8chains/node277_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_4_0 -p 492 -st none -pt topic277_4_0 -u 0.032441756069203326 > ./result_8chains/node277_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_5_0 -p 564 -st none -pt topic277_5_0 -u 0.008143240155313855 > ./result_8chains/node277_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_6_0 -p 672 -st none -pt topic277_6_0 -u 0.009738576447497677 > ./result_8chains/node277_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_7_0 -p 764 -st none -pt topic277_7_0 -u 0.019705892391654135 > ./result_8chains/node277_7_0.txt &
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
    "./result_8chains/node277_0_0.txt 90"
    "./result_8chains/node277_0_2.txt 90"
    "./result_8chains/node277_1_0.txt 89"
    "./result_8chains/node277_1_2.txt 89"
    "./result_8chains/node277_2_0.txt 88"
    "./result_8chains/node277_2_2.txt 88"
    "./result_8chains/node277_3_0.txt 87"
    "./result_8chains/node277_3_2.txt 87"
    "./result_8chains/node277_4_0.txt 86"
    "./result_8chains/node277_4_2.txt 86"
    "./result_8chains/node277_5_0.txt 85"
    "./result_8chains/node277_5_2.txt 85"
    "./result_8chains/node277_6_0.txt 84"
    "./result_8chains/node277_6_2.txt 84"
    "./result_8chains/node277_7_0.txt 83"
    "./result_8chains/node277_7_2.txt 83"
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
