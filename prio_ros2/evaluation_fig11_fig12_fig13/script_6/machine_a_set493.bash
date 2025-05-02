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
ros2 run evaluation_3_randomdag uunifast_node -n node493_0_2 -p 100 -st topic493_0_1 -pt None -u 0.05029780730981287 > ./result_6chains/node493_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_1_2 -p 182 -st topic493_1_1 -pt None -u 0.0726848815948089 > ./result_6chains/node493_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_2_2 -p 377 -st topic493_2_1 -pt None -u 0.029973509093393996 > ./result_6chains/node493_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_3_2 -p 621 -st topic493_3_1 -pt None -u 0.013213119220032474 > ./result_6chains/node493_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_4_2 -p 748 -st topic493_4_1 -pt None -u 0.01741628019368248 > ./result_6chains/node493_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_5_2 -p 922 -st topic493_5_1 -pt None -u 0.019750765460715306 > ./result_6chains/node493_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_0_0 -p 100 -st none -pt topic493_0_0 -u 0.020522275691724046 > ./result_6chains/node493_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_1_0 -p 182 -st none -pt topic493_1_0 -u 0.06331775402173079 > ./result_6chains/node493_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_2_0 -p 377 -st none -pt topic493_2_0 -u 0.009409631231245136 > ./result_6chains/node493_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_3_0 -p 621 -st none -pt topic493_3_0 -u 0.030489104248702048 > ./result_6chains/node493_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_4_0 -p 748 -st none -pt topic493_4_0 -u 0.03219583154081787 > ./result_6chains/node493_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_5_0 -p 922 -st none -pt topic493_5_0 -u 0.017659318559524705 > ./result_6chains/node493_5_0.txt &
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
    "./result_6chains/node493_0_0.txt 90"
    "./result_6chains/node493_0_2.txt 90"
    "./result_6chains/node493_1_0.txt 89"
    "./result_6chains/node493_1_2.txt 89"
    "./result_6chains/node493_2_0.txt 88"
    "./result_6chains/node493_2_2.txt 88"
    "./result_6chains/node493_3_0.txt 87"
    "./result_6chains/node493_3_2.txt 87"
    "./result_6chains/node493_4_0.txt 86"
    "./result_6chains/node493_4_2.txt 86"
    "./result_6chains/node493_5_0.txt 85"
    "./result_6chains/node493_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
