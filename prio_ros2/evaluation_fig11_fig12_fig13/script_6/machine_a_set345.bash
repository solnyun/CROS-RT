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
ros2 run evaluation_3_randomdag uunifast_node -n node345_0_2 -p 52 -st topic345_0_1 -pt None -u 0.004623002560643186 > ./result_6chains/node345_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_1_2 -p 193 -st topic345_1_1 -pt None -u 0.022104285159240455 > ./result_6chains/node345_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_2_2 -p 410 -st topic345_2_1 -pt None -u 0.020858932867322988 > ./result_6chains/node345_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_3_2 -p 643 -st topic345_3_1 -pt None -u 0.026833051732524232 > ./result_6chains/node345_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_4_2 -p 790 -st topic345_4_1 -pt None -u 0.022882819785585082 > ./result_6chains/node345_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_5_2 -p 937 -st topic345_5_1 -pt None -u 0.026449204058731343 > ./result_6chains/node345_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_0_0 -p 52 -st none -pt topic345_0_0 -u 0.018933070222087733 > ./result_6chains/node345_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_1_0 -p 193 -st none -pt topic345_1_0 -u 0.012880645308676941 > ./result_6chains/node345_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_2_0 -p 410 -st none -pt topic345_2_0 -u 0.019393098692180033 > ./result_6chains/node345_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_3_0 -p 643 -st none -pt topic345_3_0 -u 0.07282703762832798 > ./result_6chains/node345_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node345_4_0 -p 790 -st none -pt topic345_4_0 -u 0.08325648514213174 > ./result_6chains/node345_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node345_5_0 -p 937 -st none -pt topic345_5_0 -u 0.03735961497209435 > ./result_6chains/node345_5_0.txt &
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
    "./result_6chains/node345_0_0.txt 90"
    "./result_6chains/node345_0_2.txt 90"
    "./result_6chains/node345_1_0.txt 89"
    "./result_6chains/node345_1_2.txt 89"
    "./result_6chains/node345_2_0.txt 88"
    "./result_6chains/node345_2_2.txt 88"
    "./result_6chains/node345_3_0.txt 87"
    "./result_6chains/node345_3_2.txt 87"
    "./result_6chains/node345_4_0.txt 86"
    "./result_6chains/node345_4_2.txt 86"
    "./result_6chains/node345_5_0.txt 85"
    "./result_6chains/node345_5_2.txt 85"
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
