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
ros2 run evaluation_3_randomdag uunifast_node -n node411_0_2 -p 20 -st topic411_0_1 -pt None -u 0.02787004317825803 > ./result_10chains/node411_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_1_2 -p 81 -st topic411_1_1 -pt None -u 0.0014154482858127482 > ./result_10chains/node411_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_2_2 -p 164 -st topic411_2_1 -pt None -u 0.012609376871040634 > ./result_10chains/node411_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_3_2 -p 297 -st topic411_3_1 -pt None -u 0.04231760518690647 > ./result_10chains/node411_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_4_2 -p 507 -st topic411_4_1 -pt None -u 0.01795256147314822 > ./result_10chains/node411_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_5_2 -p 754 -st topic411_5_1 -pt None -u 0.01387381491855555 > ./result_10chains/node411_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_6_2 -p 757 -st topic411_6_1 -pt None -u 0.005442657093539693 > ./result_10chains/node411_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_7_2 -p 860 -st topic411_7_1 -pt None -u 0.03465405757310294 > ./result_10chains/node411_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_8_2 -p 931 -st topic411_8_1 -pt None -u 0.006391024391473862 > ./result_10chains/node411_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_9_2 -p 985 -st topic411_9_1 -pt None -u 0.012200705174987296 > ./result_10chains/node411_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_0_0 -p 20 -st none -pt topic411_0_0 -u 0.01567031558755405 > ./result_10chains/node411_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_1_0 -p 81 -st none -pt topic411_1_0 -u 0.013655789148676767 > ./result_10chains/node411_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_2_0 -p 164 -st none -pt topic411_2_0 -u 0.006259460187340693 > ./result_10chains/node411_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_3_0 -p 297 -st none -pt topic411_3_0 -u 0.007032490809082248 > ./result_10chains/node411_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_4_0 -p 507 -st none -pt topic411_4_0 -u 0.027627486242174815 > ./result_10chains/node411_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_5_0 -p 754 -st none -pt topic411_5_0 -u 0.013153322341943774 > ./result_10chains/node411_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_6_0 -p 757 -st none -pt topic411_6_0 -u 0.04133402260765978 > ./result_10chains/node411_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_7_0 -p 860 -st none -pt topic411_7_0 -u 0.02396037049568364 > ./result_10chains/node411_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_8_0 -p 931 -st none -pt topic411_8_0 -u 0.06678361485700994 > ./result_10chains/node411_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node411_9_0 -p 985 -st none -pt topic411_9_0 -u 0.007477594613993662 > ./result_10chains/node411_9_0.txt &
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
    "./result_10chains/node411_0_0.txt 90"
    "./result_10chains/node411_0_2.txt 90"
    "./result_10chains/node411_1_0.txt 89"
    "./result_10chains/node411_1_2.txt 89"
    "./result_10chains/node411_2_0.txt 88"
    "./result_10chains/node411_2_2.txt 88"
    "./result_10chains/node411_3_0.txt 87"
    "./result_10chains/node411_3_2.txt 87"
    "./result_10chains/node411_4_0.txt 86"
    "./result_10chains/node411_4_2.txt 86"
    "./result_10chains/node411_5_0.txt 85"
    "./result_10chains/node411_5_2.txt 85"
    "./result_10chains/node411_6_0.txt 84"
    "./result_10chains/node411_6_2.txt 84"
    "./result_10chains/node411_7_0.txt 83"
    "./result_10chains/node411_7_2.txt 83"
    "./result_10chains/node411_8_0.txt 82"
    "./result_10chains/node411_8_2.txt 82"
    "./result_10chains/node411_9_0.txt 81"
    "./result_10chains/node411_9_2.txt 81"
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
