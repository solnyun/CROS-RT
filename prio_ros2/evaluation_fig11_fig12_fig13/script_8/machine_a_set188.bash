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
ros2 run evaluation_3_randomdag uunifast_node -n node188_0_2 -p 127 -st topic188_0_1 -pt None -u 0.010733730036764588 > ./result_8chains/node188_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_1_2 -p 226 -st topic188_1_1 -pt None -u 0.0024213255524655475 > ./result_8chains/node188_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_2_2 -p 349 -st topic188_2_1 -pt None -u 0.024582024844853445 > ./result_8chains/node188_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_3_2 -p 367 -st topic188_3_1 -pt None -u 0.016175175813935905 > ./result_8chains/node188_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_4_2 -p 422 -st topic188_4_1 -pt None -u 0.037345614123879184 > ./result_8chains/node188_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_5_2 -p 613 -st topic188_5_1 -pt None -u 0.007352635318809059 > ./result_8chains/node188_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_6_2 -p 635 -st topic188_6_1 -pt None -u 0.06971045521193846 > ./result_8chains/node188_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_7_2 -p 759 -st topic188_7_1 -pt None -u 0.014810905669306812 > ./result_8chains/node188_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_0_0 -p 127 -st none -pt topic188_0_0 -u 0.001515165310098654 > ./result_8chains/node188_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_1_0 -p 226 -st none -pt topic188_1_0 -u 0.006073202429429714 > ./result_8chains/node188_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_2_0 -p 349 -st none -pt topic188_2_0 -u 0.026669199204381322 > ./result_8chains/node188_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_3_0 -p 367 -st none -pt topic188_3_0 -u 0.00462942908288394 > ./result_8chains/node188_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_4_0 -p 422 -st none -pt topic188_4_0 -u 0.041714914181754825 > ./result_8chains/node188_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_5_0 -p 613 -st none -pt topic188_5_0 -u 0.00624762577918947 > ./result_8chains/node188_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node188_6_0 -p 635 -st none -pt topic188_6_0 -u 0.02981370503755859 > ./result_8chains/node188_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node188_7_0 -p 759 -st none -pt topic188_7_0 -u 0.008379567271222063 > ./result_8chains/node188_7_0.txt &
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
    "./result_8chains/node188_0_0.txt 90"
    "./result_8chains/node188_0_2.txt 90"
    "./result_8chains/node188_1_0.txt 89"
    "./result_8chains/node188_1_2.txt 89"
    "./result_8chains/node188_2_0.txt 88"
    "./result_8chains/node188_2_2.txt 88"
    "./result_8chains/node188_3_0.txt 87"
    "./result_8chains/node188_3_2.txt 87"
    "./result_8chains/node188_4_0.txt 86"
    "./result_8chains/node188_4_2.txt 86"
    "./result_8chains/node188_5_0.txt 85"
    "./result_8chains/node188_5_2.txt 85"
    "./result_8chains/node188_6_0.txt 84"
    "./result_8chains/node188_6_2.txt 84"
    "./result_8chains/node188_7_0.txt 83"
    "./result_8chains/node188_7_2.txt 83"
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
