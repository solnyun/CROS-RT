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
ros2 run evaluation_3_randomdag uunifast_node -n node287_0_2 -p 25 -st topic287_0_1 -pt None -u 0.0029810822542443716 > ./result_10chains/node287_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_1_2 -p 152 -st topic287_1_1 -pt None -u 0.02344584338549427 > ./result_10chains/node287_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_2_2 -p 187 -st topic287_2_1 -pt None -u 0.012052406536615934 > ./result_10chains/node287_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_3_2 -p 208 -st topic287_3_1 -pt None -u 0.06688837096287226 > ./result_10chains/node287_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_4_2 -p 211 -st topic287_4_1 -pt None -u 0.0038323248609313243 > ./result_10chains/node287_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_5_2 -p 388 -st topic287_5_1 -pt None -u 0.02643491523245106 > ./result_10chains/node287_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_6_2 -p 718 -st topic287_6_1 -pt None -u 0.01294443807512885 > ./result_10chains/node287_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_7_2 -p 726 -st topic287_7_1 -pt None -u 0.03669014101684 > ./result_10chains/node287_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_8_2 -p 879 -st topic287_8_1 -pt None -u 0.007273798940253068 > ./result_10chains/node287_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_9_2 -p 896 -st topic287_9_1 -pt None -u 0.005573073624283215 > ./result_10chains/node287_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_0_0 -p 25 -st none -pt topic287_0_0 -u 0.005169722165002777 > ./result_10chains/node287_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_1_0 -p 152 -st none -pt topic287_1_0 -u 0.005977688800711645 > ./result_10chains/node287_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_2_0 -p 187 -st none -pt topic287_2_0 -u 0.008750440493290879 > ./result_10chains/node287_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_3_0 -p 208 -st none -pt topic287_3_0 -u 0.01102185609466072 > ./result_10chains/node287_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_4_0 -p 211 -st none -pt topic287_4_0 -u 0.008978478755805097 > ./result_10chains/node287_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_5_0 -p 388 -st none -pt topic287_5_0 -u 0.013518590885471582 > ./result_10chains/node287_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_6_0 -p 718 -st none -pt topic287_6_0 -u 0.030705201749766486 > ./result_10chains/node287_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_7_0 -p 726 -st none -pt topic287_7_0 -u 0.019743884441002807 > ./result_10chains/node287_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node287_8_0 -p 879 -st none -pt topic287_8_0 -u 0.016554907006124553 > ./result_10chains/node287_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node287_9_0 -p 896 -st none -pt topic287_9_0 -u 0.0009368727519504308 > ./result_10chains/node287_9_0.txt &
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
    "./result_10chains/node287_0_0.txt 90"
    "./result_10chains/node287_0_2.txt 90"
    "./result_10chains/node287_1_0.txt 89"
    "./result_10chains/node287_1_2.txt 89"
    "./result_10chains/node287_2_0.txt 88"
    "./result_10chains/node287_2_2.txt 88"
    "./result_10chains/node287_3_0.txt 87"
    "./result_10chains/node287_3_2.txt 87"
    "./result_10chains/node287_4_0.txt 86"
    "./result_10chains/node287_4_2.txt 86"
    "./result_10chains/node287_5_0.txt 85"
    "./result_10chains/node287_5_2.txt 85"
    "./result_10chains/node287_6_0.txt 84"
    "./result_10chains/node287_6_2.txt 84"
    "./result_10chains/node287_7_0.txt 83"
    "./result_10chains/node287_7_2.txt 83"
    "./result_10chains/node287_8_0.txt 82"
    "./result_10chains/node287_8_2.txt 82"
    "./result_10chains/node287_9_0.txt 81"
    "./result_10chains/node287_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
