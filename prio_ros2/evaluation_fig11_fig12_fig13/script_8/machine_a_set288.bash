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
ros2 run evaluation_3_randomdag uunifast_node -n node288_0_2 -p 20 -st topic288_0_1 -pt None -u 0.05420316875613973 > ./result_8chains/node288_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_1_2 -p 333 -st topic288_1_1 -pt None -u 0.044602065670144186 > ./result_8chains/node288_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_2_2 -p 366 -st topic288_2_1 -pt None -u 0.01597341685926429 > ./result_8chains/node288_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_3_2 -p 367 -st topic288_3_1 -pt None -u 0.04658128184346269 > ./result_8chains/node288_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_4_2 -p 528 -st topic288_4_1 -pt None -u 0.009179693433573971 > ./result_8chains/node288_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_5_2 -p 603 -st topic288_5_1 -pt None -u 0.011791950313630797 > ./result_8chains/node288_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_6_2 -p 776 -st topic288_6_1 -pt None -u 0.000937307626165465 > ./result_8chains/node288_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_7_2 -p 809 -st topic288_7_1 -pt None -u 0.018373125229037165 > ./result_8chains/node288_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_0_0 -p 20 -st none -pt topic288_0_0 -u 0.031636851467364446 > ./result_8chains/node288_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_1_0 -p 333 -st none -pt topic288_1_0 -u 0.019554031588764287 > ./result_8chains/node288_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_2_0 -p 366 -st none -pt topic288_2_0 -u 0.00235856750317176 > ./result_8chains/node288_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_3_0 -p 367 -st none -pt topic288_3_0 -u 0.0009282104028185412 > ./result_8chains/node288_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_4_0 -p 528 -st none -pt topic288_4_0 -u 0.030184131834537692 > ./result_8chains/node288_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_5_0 -p 603 -st none -pt topic288_5_0 -u 0.022419968511892166 > ./result_8chains/node288_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_6_0 -p 776 -st none -pt topic288_6_0 -u 0.014973840738366218 > ./result_8chains/node288_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_7_0 -p 809 -st none -pt topic288_7_0 -u 0.03002783770327471 > ./result_8chains/node288_7_0.txt &
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
    "./result_8chains/node288_0_0.txt 90"
    "./result_8chains/node288_0_2.txt 90"
    "./result_8chains/node288_1_0.txt 89"
    "./result_8chains/node288_1_2.txt 89"
    "./result_8chains/node288_2_0.txt 88"
    "./result_8chains/node288_2_2.txt 88"
    "./result_8chains/node288_3_0.txt 87"
    "./result_8chains/node288_3_2.txt 87"
    "./result_8chains/node288_4_0.txt 86"
    "./result_8chains/node288_4_2.txt 86"
    "./result_8chains/node288_5_0.txt 85"
    "./result_8chains/node288_5_2.txt 85"
    "./result_8chains/node288_6_0.txt 84"
    "./result_8chains/node288_6_2.txt 84"
    "./result_8chains/node288_7_0.txt 83"
    "./result_8chains/node288_7_2.txt 83"
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
