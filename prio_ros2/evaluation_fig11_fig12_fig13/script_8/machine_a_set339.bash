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
ros2 run evaluation_3_randomdag uunifast_node -n node339_0_2 -p 46 -st topic339_0_1 -pt None -u 0.0035555423775588957 > ./result_8chains/node339_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_1_2 -p 74 -st topic339_1_1 -pt None -u 0.06761689517608871 > ./result_8chains/node339_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_2_2 -p 113 -st topic339_2_1 -pt None -u 0.01172314423616666 > ./result_8chains/node339_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_3_2 -p 121 -st topic339_3_1 -pt None -u 0.05962206924508956 > ./result_8chains/node339_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_4_2 -p 167 -st topic339_4_1 -pt None -u 0.038209730430064065 > ./result_8chains/node339_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_5_2 -p 403 -st topic339_5_1 -pt None -u 0.02567556262016632 > ./result_8chains/node339_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_6_2 -p 778 -st topic339_6_1 -pt None -u 0.0064451213396058415 > ./result_8chains/node339_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_7_2 -p 944 -st topic339_7_1 -pt None -u 0.05013541270814209 > ./result_8chains/node339_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_0_0 -p 46 -st none -pt topic339_0_0 -u 0.006824272060631076 > ./result_8chains/node339_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_1_0 -p 74 -st none -pt topic339_1_0 -u 0.006387556566436692 > ./result_8chains/node339_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_2_0 -p 113 -st none -pt topic339_2_0 -u 0.006123081416034293 > ./result_8chains/node339_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_3_0 -p 121 -st none -pt topic339_3_0 -u 0.031696105912251527 > ./result_8chains/node339_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_4_0 -p 167 -st none -pt topic339_4_0 -u 0.0035418336401916717 > ./result_8chains/node339_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_5_0 -p 403 -st none -pt topic339_5_0 -u 0.007466930060683025 > ./result_8chains/node339_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node339_6_0 -p 778 -st none -pt topic339_6_0 -u 0.03477252971726502 > ./result_8chains/node339_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node339_7_0 -p 944 -st none -pt topic339_7_0 -u 0.04702956990080651 > ./result_8chains/node339_7_0.txt &
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
    "./result_8chains/node339_0_0.txt 90"
    "./result_8chains/node339_0_2.txt 90"
    "./result_8chains/node339_1_0.txt 89"
    "./result_8chains/node339_1_2.txt 89"
    "./result_8chains/node339_2_0.txt 88"
    "./result_8chains/node339_2_2.txt 88"
    "./result_8chains/node339_3_0.txt 87"
    "./result_8chains/node339_3_2.txt 87"
    "./result_8chains/node339_4_0.txt 86"
    "./result_8chains/node339_4_2.txt 86"
    "./result_8chains/node339_5_0.txt 85"
    "./result_8chains/node339_5_2.txt 85"
    "./result_8chains/node339_6_0.txt 84"
    "./result_8chains/node339_6_2.txt 84"
    "./result_8chains/node339_7_0.txt 83"
    "./result_8chains/node339_7_2.txt 83"
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
