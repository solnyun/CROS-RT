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
ros2 run evaluation_3_randomdag uunifast_node -n node448_0_2 -p 596 -st topic448_0_1 -pt None -u 0.050735164080682627 > ./result_6chains/node448_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_1_2 -p 604 -st topic448_1_1 -pt None -u 0.0669723092197973 > ./result_6chains/node448_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_2_2 -p 678 -st topic448_2_1 -pt None -u 0.004692064759957787 > ./result_6chains/node448_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_3_2 -p 799 -st topic448_3_1 -pt None -u 0.0346369911733298 > ./result_6chains/node448_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_4_2 -p 864 -st topic448_4_1 -pt None -u 0.004289213005928369 > ./result_6chains/node448_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_5_2 -p 983 -st topic448_5_1 -pt None -u 0.017615911729870953 > ./result_6chains/node448_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_0_0 -p 596 -st none -pt topic448_0_0 -u 0.00584916576021971 > ./result_6chains/node448_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_1_0 -p 604 -st none -pt topic448_1_0 -u 0.004203194125892873 > ./result_6chains/node448_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_2_0 -p 678 -st none -pt topic448_2_0 -u 0.02976667918101744 > ./result_6chains/node448_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_3_0 -p 799 -st none -pt topic448_3_0 -u 0.012763780825795462 > ./result_6chains/node448_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_4_0 -p 864 -st none -pt topic448_4_0 -u 0.06542950372263462 > ./result_6chains/node448_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node448_5_0 -p 983 -st none -pt topic448_5_0 -u 0.008841818274951181 > ./result_6chains/node448_5_0.txt &
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
    "./result_6chains/node448_0_0.txt 90"
    "./result_6chains/node448_0_2.txt 90"
    "./result_6chains/node448_1_0.txt 89"
    "./result_6chains/node448_1_2.txt 89"
    "./result_6chains/node448_2_0.txt 88"
    "./result_6chains/node448_2_2.txt 88"
    "./result_6chains/node448_3_0.txt 87"
    "./result_6chains/node448_3_2.txt 87"
    "./result_6chains/node448_4_0.txt 86"
    "./result_6chains/node448_4_2.txt 86"
    "./result_6chains/node448_5_0.txt 85"
    "./result_6chains/node448_5_2.txt 85"
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
