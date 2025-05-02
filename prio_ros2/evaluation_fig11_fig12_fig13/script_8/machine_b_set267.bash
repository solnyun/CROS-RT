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
ros2 run evaluation_3_randomdag uunifast_node -n node267_0_1 -p 321 -st topic267_0_0 -pt topic267_0_1 -u 0.0166285141390497 > ./result_8chains/node267_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_1_1 -p 330 -st topic267_1_0 -pt topic267_1_1 -u 0.002226384815296467 > ./result_8chains/node267_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_2_1 -p 339 -st topic267_2_0 -pt topic267_2_1 -u 0.05403104684943022 > ./result_8chains/node267_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_3_1 -p 344 -st topic267_3_0 -pt topic267_3_1 -u 0.0012996983765963255 > ./result_8chains/node267_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_4_1 -p 784 -st topic267_4_0 -pt topic267_4_1 -u 0.014739648446320613 > ./result_8chains/node267_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_5_1 -p 851 -st topic267_5_0 -pt topic267_5_1 -u 0.044279515003782466 > ./result_8chains/node267_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_6_1 -p 900 -st topic267_6_0 -pt topic267_6_1 -u 0.0004739638514292127 > ./result_8chains/node267_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_7_1 -p 977 -st topic267_7_0 -pt topic267_7_1 -u 0.014795164790386721 > ./result_8chains/node267_7_1.txt &
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
    "./result_8chains/node267_0_1.txt 90"
    "./result_8chains/node267_1_1.txt 89"
    "./result_8chains/node267_2_1.txt 88"
    "./result_8chains/node267_3_1.txt 87"
    "./result_8chains/node267_4_1.txt 86"
    "./result_8chains/node267_5_1.txt 85"
    "./result_8chains/node267_6_1.txt 84"
    "./result_8chains/node267_7_1.txt 83"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
