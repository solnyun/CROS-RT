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
ros2 run evaluation_3_randomdag uunifast_node -n node10_0_2 -p 304 -st topic10_0_1 -pt None -u 0.02999412377537175 > ./result_8chains/node10_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_1_2 -p 476 -st topic10_1_1 -pt None -u 0.004120299342468825 > ./result_8chains/node10_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_2_2 -p 617 -st topic10_2_1 -pt None -u 0.01005037033541123 > ./result_8chains/node10_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_3_2 -p 723 -st topic10_3_1 -pt None -u 0.07423012828512002 > ./result_8chains/node10_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_4_2 -p 735 -st topic10_4_1 -pt None -u 0.011700117504889584 > ./result_8chains/node10_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_5_2 -p 763 -st topic10_5_1 -pt None -u 0.012164533571984146 > ./result_8chains/node10_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_6_2 -p 799 -st topic10_6_1 -pt None -u 0.01681764859213939 > ./result_8chains/node10_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_7_2 -p 812 -st topic10_7_1 -pt None -u 0.01426513227666537 > ./result_8chains/node10_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_0_0 -p 304 -st none -pt topic10_0_0 -u 0.02015093386461153 > ./result_8chains/node10_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_1_0 -p 476 -st none -pt topic10_1_0 -u 0.036449516429045536 > ./result_8chains/node10_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_2_0 -p 617 -st none -pt topic10_2_0 -u 0.014000868918988552 > ./result_8chains/node10_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_3_0 -p 723 -st none -pt topic10_3_0 -u 0.002471358525574452 > ./result_8chains/node10_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_4_0 -p 735 -st none -pt topic10_4_0 -u 0.029140718226166096 > ./result_8chains/node10_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_5_0 -p 763 -st none -pt topic10_5_0 -u 0.03325634045014325 > ./result_8chains/node10_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node10_6_0 -p 799 -st none -pt topic10_6_0 -u 0.013863968422145267 > ./result_8chains/node10_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node10_7_0 -p 812 -st none -pt topic10_7_0 -u 0.009094995499902135 > ./result_8chains/node10_7_0.txt &
sleep 10
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
    "./result_8chains/node10_0_0.txt 90"
    "./result_8chains/node10_0_2.txt 90"
    "./result_8chains/node10_1_0.txt 89"
    "./result_8chains/node10_1_2.txt 89"
    "./result_8chains/node10_2_0.txt 88"
    "./result_8chains/node10_2_2.txt 88"
    "./result_8chains/node10_3_0.txt 87"
    "./result_8chains/node10_3_2.txt 87"
    "./result_8chains/node10_4_0.txt 86"
    "./result_8chains/node10_4_2.txt 86"
    "./result_8chains/node10_5_0.txt 85"
    "./result_8chains/node10_5_2.txt 85"
    "./result_8chains/node10_6_0.txt 84"
    "./result_8chains/node10_6_2.txt 84"
    "./result_8chains/node10_7_0.txt 83"
    "./result_8chains/node10_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
