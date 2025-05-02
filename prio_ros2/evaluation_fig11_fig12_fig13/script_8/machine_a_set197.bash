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
ros2 run evaluation_3_randomdag uunifast_node -n node197_0_2 -p 70 -st topic197_0_1 -pt None -u 0.021607681746659002 > ./result_8chains/node197_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_1_2 -p 242 -st topic197_1_1 -pt None -u 0.0013611610948085495 > ./result_8chains/node197_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_2_2 -p 289 -st topic197_2_1 -pt None -u 0.025620617551532776 > ./result_8chains/node197_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_3_2 -p 316 -st topic197_3_1 -pt None -u 0.00674091528905571 > ./result_8chains/node197_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_4_2 -p 396 -st topic197_4_1 -pt None -u 0.020542059302057908 > ./result_8chains/node197_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_5_2 -p 515 -st topic197_5_1 -pt None -u 0.026369793253225443 > ./result_8chains/node197_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_6_2 -p 913 -st topic197_6_1 -pt None -u 0.002992464301910594 > ./result_8chains/node197_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_7_2 -p 971 -st topic197_7_1 -pt None -u 0.08184919572017944 > ./result_8chains/node197_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_0_0 -p 70 -st none -pt topic197_0_0 -u 0.0074801678247868875 > ./result_8chains/node197_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_1_0 -p 242 -st none -pt topic197_1_0 -u 0.012366778347757512 > ./result_8chains/node197_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_2_0 -p 289 -st none -pt topic197_2_0 -u 0.028517734936725325 > ./result_8chains/node197_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_3_0 -p 316 -st none -pt topic197_3_0 -u 0.027179222848168372 > ./result_8chains/node197_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_4_0 -p 396 -st none -pt topic197_4_0 -u 0.009879839058124812 > ./result_8chains/node197_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_5_0 -p 515 -st none -pt topic197_5_0 -u 0.0117788977858726 > ./result_8chains/node197_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_6_0 -p 913 -st none -pt topic197_6_0 -u 0.02852552141453292 > ./result_8chains/node197_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node197_7_0 -p 971 -st none -pt topic197_7_0 -u 0.00048791323700474176 > ./result_8chains/node197_7_0.txt &
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
    "./result_8chains/node197_0_0.txt 90"
    "./result_8chains/node197_0_2.txt 90"
    "./result_8chains/node197_1_0.txt 89"
    "./result_8chains/node197_1_2.txt 89"
    "./result_8chains/node197_2_0.txt 88"
    "./result_8chains/node197_2_2.txt 88"
    "./result_8chains/node197_3_0.txt 87"
    "./result_8chains/node197_3_2.txt 87"
    "./result_8chains/node197_4_0.txt 86"
    "./result_8chains/node197_4_2.txt 86"
    "./result_8chains/node197_5_0.txt 85"
    "./result_8chains/node197_5_2.txt 85"
    "./result_8chains/node197_6_0.txt 84"
    "./result_8chains/node197_6_2.txt 84"
    "./result_8chains/node197_7_0.txt 83"
    "./result_8chains/node197_7_2.txt 83"
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
