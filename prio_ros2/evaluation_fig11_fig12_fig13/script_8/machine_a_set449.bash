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
ros2 run evaluation_3_randomdag uunifast_node -n node449_0_2 -p 57 -st topic449_0_1 -pt None -u 0.019201673508719097 > ./result_8chains/node449_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_1_2 -p 391 -st topic449_1_1 -pt None -u 0.0012665540600904635 > ./result_8chains/node449_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_2_2 -p 464 -st topic449_2_1 -pt None -u 0.00040291410419945883 > ./result_8chains/node449_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_3_2 -p 646 -st topic449_3_1 -pt None -u 0.009822139803672664 > ./result_8chains/node449_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_4_2 -p 692 -st topic449_4_1 -pt None -u 0.005241055183963533 > ./result_8chains/node449_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_5_2 -p 837 -st topic449_5_1 -pt None -u 0.020024009980634777 > ./result_8chains/node449_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_6_2 -p 978 -st topic449_6_1 -pt None -u 0.0007570249111270438 > ./result_8chains/node449_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_7_2 -p 998 -st topic449_7_1 -pt None -u 0.017509269350755575 > ./result_8chains/node449_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_0_0 -p 57 -st none -pt topic449_0_0 -u 0.005344853395996607 > ./result_8chains/node449_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_1_0 -p 391 -st none -pt topic449_1_0 -u 0.0017986045326880973 > ./result_8chains/node449_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_2_0 -p 464 -st none -pt topic449_2_0 -u 0.0232730203928333 > ./result_8chains/node449_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_3_0 -p 646 -st none -pt topic449_3_0 -u 0.09109690786197441 > ./result_8chains/node449_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_4_0 -p 692 -st none -pt topic449_4_0 -u 8.899756530156289e-05 > ./result_8chains/node449_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_5_0 -p 837 -st none -pt topic449_5_0 -u 0.03357759688074255 > ./result_8chains/node449_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node449_6_0 -p 978 -st none -pt topic449_6_0 -u 0.03395150525432229 > ./result_8chains/node449_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node449_7_0 -p 998 -st none -pt topic449_7_0 -u 0.028813884850041424 > ./result_8chains/node449_7_0.txt &
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
    "./result_8chains/node449_0_0.txt 90"
    "./result_8chains/node449_0_2.txt 90"
    "./result_8chains/node449_1_0.txt 89"
    "./result_8chains/node449_1_2.txt 89"
    "./result_8chains/node449_2_0.txt 88"
    "./result_8chains/node449_2_2.txt 88"
    "./result_8chains/node449_3_0.txt 87"
    "./result_8chains/node449_3_2.txt 87"
    "./result_8chains/node449_4_0.txt 86"
    "./result_8chains/node449_4_2.txt 86"
    "./result_8chains/node449_5_0.txt 85"
    "./result_8chains/node449_5_2.txt 85"
    "./result_8chains/node449_6_0.txt 84"
    "./result_8chains/node449_6_2.txt 84"
    "./result_8chains/node449_7_0.txt 83"
    "./result_8chains/node449_7_2.txt 83"
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
