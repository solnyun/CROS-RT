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
ros2 run evaluation_3_randomdag uunifast_node -n node302_0_2 -p 152 -st topic302_0_1 -pt None -u 0.011093688140554947 > ./result_6chains/node302_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_1_2 -p 405 -st topic302_1_1 -pt None -u 0.0317200385839993 > ./result_6chains/node302_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_2_2 -p 415 -st topic302_2_1 -pt None -u 0.01595957787773833 > ./result_6chains/node302_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_3_2 -p 764 -st topic302_3_1 -pt None -u 0.04511061625940044 > ./result_6chains/node302_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_4_2 -p 824 -st topic302_4_1 -pt None -u 0.014868462375520045 > ./result_6chains/node302_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_5_2 -p 878 -st topic302_5_1 -pt None -u 0.016237511308383513 > ./result_6chains/node302_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_0_0 -p 152 -st none -pt topic302_0_0 -u 0.02205867152550306 > ./result_6chains/node302_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_1_0 -p 405 -st none -pt topic302_1_0 -u 0.02130594106939826 > ./result_6chains/node302_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_2_0 -p 415 -st none -pt topic302_2_0 -u 0.008309490002007425 > ./result_6chains/node302_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_3_0 -p 764 -st none -pt topic302_3_0 -u 0.10784559569559182 > ./result_6chains/node302_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_4_0 -p 824 -st none -pt topic302_4_0 -u 0.005849409625780885 > ./result_6chains/node302_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_5_0 -p 878 -st none -pt topic302_5_0 -u 0.02318144401907349 > ./result_6chains/node302_5_0.txt &
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
    "./result_6chains/node302_0_0.txt 90"
    "./result_6chains/node302_0_2.txt 90"
    "./result_6chains/node302_1_0.txt 89"
    "./result_6chains/node302_1_2.txt 89"
    "./result_6chains/node302_2_0.txt 88"
    "./result_6chains/node302_2_2.txt 88"
    "./result_6chains/node302_3_0.txt 87"
    "./result_6chains/node302_3_2.txt 87"
    "./result_6chains/node302_4_0.txt 86"
    "./result_6chains/node302_4_2.txt 86"
    "./result_6chains/node302_5_0.txt 85"
    "./result_6chains/node302_5_2.txt 85"
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
