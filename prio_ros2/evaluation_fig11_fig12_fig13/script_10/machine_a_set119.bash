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
ros2 run evaluation_3_randomdag uunifast_node -n node119_0_2 -p 39 -st topic119_0_1 -pt None -u 0.029665285439878453 > ./result_10chains/node119_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_1_2 -p 63 -st topic119_1_1 -pt None -u 0.0023385357022656095 > ./result_10chains/node119_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_2_2 -p 74 -st topic119_2_1 -pt None -u 0.03444411166956585 > ./result_10chains/node119_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_3_2 -p 185 -st topic119_3_1 -pt None -u 0.020737345050192146 > ./result_10chains/node119_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_4_2 -p 247 -st topic119_4_1 -pt None -u 0.0034971923578446806 > ./result_10chains/node119_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_5_2 -p 388 -st topic119_5_1 -pt None -u 0.012896618258248171 > ./result_10chains/node119_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_6_2 -p 552 -st topic119_6_1 -pt None -u 0.014177926268633415 > ./result_10chains/node119_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_7_2 -p 636 -st topic119_7_1 -pt None -u 0.006569192857008549 > ./result_10chains/node119_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_8_2 -p 713 -st topic119_8_1 -pt None -u 0.01746335864086019 > ./result_10chains/node119_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_9_2 -p 906 -st topic119_9_1 -pt None -u 0.0035528511344451045 > ./result_10chains/node119_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_0_0 -p 39 -st none -pt topic119_0_0 -u 0.00014483620248090245 > ./result_10chains/node119_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_1_0 -p 63 -st none -pt topic119_1_0 -u 0.009171192585932297 > ./result_10chains/node119_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_2_0 -p 74 -st none -pt topic119_2_0 -u 0.02404167477601521 > ./result_10chains/node119_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_3_0 -p 185 -st none -pt topic119_3_0 -u 0.012367914381287093 > ./result_10chains/node119_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_4_0 -p 247 -st none -pt topic119_4_0 -u 0.027303256799110498 > ./result_10chains/node119_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_5_0 -p 388 -st none -pt topic119_5_0 -u 0.02207319279805156 > ./result_10chains/node119_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_6_0 -p 552 -st none -pt topic119_6_0 -u 0.00764688344768813 > ./result_10chains/node119_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_7_0 -p 636 -st none -pt topic119_7_0 -u 0.002227495032528337 > ./result_10chains/node119_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_8_0 -p 713 -st none -pt topic119_8_0 -u 0.013505621910250884 > ./result_10chains/node119_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node119_9_0 -p 906 -st none -pt topic119_9_0 -u 0.012825643386453629 > ./result_10chains/node119_9_0.txt &
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
    "./result_10chains/node119_0_0.txt 90"
    "./result_10chains/node119_0_2.txt 90"
    "./result_10chains/node119_1_0.txt 89"
    "./result_10chains/node119_1_2.txt 89"
    "./result_10chains/node119_2_0.txt 88"
    "./result_10chains/node119_2_2.txt 88"
    "./result_10chains/node119_3_0.txt 87"
    "./result_10chains/node119_3_2.txt 87"
    "./result_10chains/node119_4_0.txt 86"
    "./result_10chains/node119_4_2.txt 86"
    "./result_10chains/node119_5_0.txt 85"
    "./result_10chains/node119_5_2.txt 85"
    "./result_10chains/node119_6_0.txt 84"
    "./result_10chains/node119_6_2.txt 84"
    "./result_10chains/node119_7_0.txt 83"
    "./result_10chains/node119_7_2.txt 83"
    "./result_10chains/node119_8_0.txt 82"
    "./result_10chains/node119_8_2.txt 82"
    "./result_10chains/node119_9_0.txt 81"
    "./result_10chains/node119_9_2.txt 81"
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
