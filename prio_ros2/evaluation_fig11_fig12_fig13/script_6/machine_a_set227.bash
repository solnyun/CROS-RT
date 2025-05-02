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
ros2 run evaluation_3_randomdag uunifast_node -n node227_0_2 -p 33 -st topic227_0_1 -pt None -u 0.01191543234222986 > ./result_6chains/node227_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_1_2 -p 390 -st topic227_1_1 -pt None -u 0.009425709329913046 > ./result_6chains/node227_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_2_2 -p 418 -st topic227_2_1 -pt None -u 0.001031465058162373 > ./result_6chains/node227_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_3_2 -p 695 -st topic227_3_1 -pt None -u 0.014529278720859629 > ./result_6chains/node227_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_4_2 -p 723 -st topic227_4_1 -pt None -u 0.0035114930573186265 > ./result_6chains/node227_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_5_2 -p 984 -st topic227_5_1 -pt None -u 0.003111804921362057 > ./result_6chains/node227_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_0_0 -p 33 -st none -pt topic227_0_0 -u 0.07020818579462512 > ./result_6chains/node227_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_1_0 -p 390 -st none -pt topic227_1_0 -u 0.0001881899577574342 > ./result_6chains/node227_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_2_0 -p 418 -st none -pt topic227_2_0 -u 0.03757206820752762 > ./result_6chains/node227_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_3_0 -p 695 -st none -pt topic227_3_0 -u 0.005884221840429749 > ./result_6chains/node227_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_4_0 -p 723 -st none -pt topic227_4_0 -u 0.04334815271945669 > ./result_6chains/node227_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_5_0 -p 984 -st none -pt topic227_5_0 -u 0.07206973554056015 > ./result_6chains/node227_5_0.txt &
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
    "./result_6chains/node227_0_0.txt 90"
    "./result_6chains/node227_0_2.txt 90"
    "./result_6chains/node227_1_0.txt 89"
    "./result_6chains/node227_1_2.txt 89"
    "./result_6chains/node227_2_0.txt 88"
    "./result_6chains/node227_2_2.txt 88"
    "./result_6chains/node227_3_0.txt 87"
    "./result_6chains/node227_3_2.txt 87"
    "./result_6chains/node227_4_0.txt 86"
    "./result_6chains/node227_4_2.txt 86"
    "./result_6chains/node227_5_0.txt 85"
    "./result_6chains/node227_5_2.txt 85"
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
