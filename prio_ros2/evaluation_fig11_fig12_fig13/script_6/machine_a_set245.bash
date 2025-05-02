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
ros2 run evaluation_3_randomdag uunifast_node -n node245_0_2 -p 243 -st topic245_0_1 -pt None -u 0.024637373319150502 > ./result_6chains/node245_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_1_2 -p 244 -st topic245_1_1 -pt None -u 0.0082498011086386 > ./result_6chains/node245_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_2_2 -p 391 -st topic245_2_1 -pt None -u 0.030617733630009802 > ./result_6chains/node245_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_3_2 -p 720 -st topic245_3_1 -pt None -u 0.0055054924139795736 > ./result_6chains/node245_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_4_2 -p 782 -st topic245_4_1 -pt None -u 0.07718329741157527 > ./result_6chains/node245_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_5_2 -p 800 -st topic245_5_1 -pt None -u 0.019422393382772723 > ./result_6chains/node245_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_0_0 -p 243 -st none -pt topic245_0_0 -u 0.02853569153156893 > ./result_6chains/node245_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_1_0 -p 244 -st none -pt topic245_1_0 -u 0.02634920002671204 > ./result_6chains/node245_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_2_0 -p 391 -st none -pt topic245_2_0 -u 0.03446849418452397 > ./result_6chains/node245_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_3_0 -p 720 -st none -pt topic245_3_0 -u 0.06443804110293883 > ./result_6chains/node245_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_4_0 -p 782 -st none -pt topic245_4_0 -u 0.057203913383450794 > ./result_6chains/node245_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node245_5_0 -p 800 -st none -pt topic245_5_0 -u 0.029060866609085596 > ./result_6chains/node245_5_0.txt &
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
    "./result_6chains/node245_0_0.txt 90"
    "./result_6chains/node245_0_2.txt 90"
    "./result_6chains/node245_1_0.txt 89"
    "./result_6chains/node245_1_2.txt 89"
    "./result_6chains/node245_2_0.txt 88"
    "./result_6chains/node245_2_2.txt 88"
    "./result_6chains/node245_3_0.txt 87"
    "./result_6chains/node245_3_2.txt 87"
    "./result_6chains/node245_4_0.txt 86"
    "./result_6chains/node245_4_2.txt 86"
    "./result_6chains/node245_5_0.txt 85"
    "./result_6chains/node245_5_2.txt 85"
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
