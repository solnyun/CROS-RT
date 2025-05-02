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
ros2 run evaluation_3_randomdag uunifast_node -n node116_0_2 -p 23 -st topic116_0_1 -pt None -u 0.03105430930134956 > ./result_8chains/node116_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_1_2 -p 99 -st topic116_1_1 -pt None -u 0.011469349614045499 > ./result_8chains/node116_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_2_2 -p 365 -st topic116_2_1 -pt None -u 0.00017008070395446717 > ./result_8chains/node116_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_3_2 -p 622 -st topic116_3_1 -pt None -u 0.0060161132756045566 > ./result_8chains/node116_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_4_2 -p 781 -st topic116_4_1 -pt None -u 0.0023023462544595197 > ./result_8chains/node116_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_5_2 -p 786 -st topic116_5_1 -pt None -u 0.0382298265694018 > ./result_8chains/node116_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_6_2 -p 862 -st topic116_6_1 -pt None -u 0.010529259253919766 > ./result_8chains/node116_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_7_2 -p 933 -st topic116_7_1 -pt None -u 0.020306831041597893 > ./result_8chains/node116_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_0_0 -p 23 -st none -pt topic116_0_0 -u 0.021496413172713114 > ./result_8chains/node116_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_1_0 -p 99 -st none -pt topic116_1_0 -u 0.01569115589963943 > ./result_8chains/node116_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_2_0 -p 365 -st none -pt topic116_2_0 -u 0.11754251972264657 > ./result_8chains/node116_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_3_0 -p 622 -st none -pt topic116_3_0 -u 0.022175096482680123 > ./result_8chains/node116_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_4_0 -p 781 -st none -pt topic116_4_0 -u 0.01756849098304422 > ./result_8chains/node116_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_5_0 -p 786 -st none -pt topic116_5_0 -u 0.011504483850324376 > ./result_8chains/node116_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node116_6_0 -p 862 -st none -pt topic116_6_0 -u 0.030571005775634416 > ./result_8chains/node116_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node116_7_0 -p 933 -st none -pt topic116_7_0 -u 0.004286855490615624 > ./result_8chains/node116_7_0.txt &
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
    "./result_8chains/node116_0_0.txt 90"
    "./result_8chains/node116_0_2.txt 90"
    "./result_8chains/node116_1_0.txt 89"
    "./result_8chains/node116_1_2.txt 89"
    "./result_8chains/node116_2_0.txt 88"
    "./result_8chains/node116_2_2.txt 88"
    "./result_8chains/node116_3_0.txt 87"
    "./result_8chains/node116_3_2.txt 87"
    "./result_8chains/node116_4_0.txt 86"
    "./result_8chains/node116_4_2.txt 86"
    "./result_8chains/node116_5_0.txt 85"
    "./result_8chains/node116_5_2.txt 85"
    "./result_8chains/node116_6_0.txt 84"
    "./result_8chains/node116_6_2.txt 84"
    "./result_8chains/node116_7_0.txt 83"
    "./result_8chains/node116_7_2.txt 83"
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
