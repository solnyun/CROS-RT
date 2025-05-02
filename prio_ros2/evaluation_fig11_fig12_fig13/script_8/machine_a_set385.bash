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
ros2 run evaluation_3_randomdag uunifast_node -n node385_0_2 -p 85 -st topic385_0_1 -pt None -u 0.0036998580763934474 > ./result_8chains/node385_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_1_2 -p 92 -st topic385_1_1 -pt None -u 0.01551972850842065 > ./result_8chains/node385_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_2_2 -p 203 -st topic385_2_1 -pt None -u 0.01087433816678729 > ./result_8chains/node385_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_3_2 -p 403 -st topic385_3_1 -pt None -u 0.039588077587937365 > ./result_8chains/node385_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_4_2 -p 624 -st topic385_4_1 -pt None -u 0.07792247073363295 > ./result_8chains/node385_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_5_2 -p 720 -st topic385_5_1 -pt None -u 0.009184637400833473 > ./result_8chains/node385_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_6_2 -p 947 -st topic385_6_1 -pt None -u 0.02969260324386932 > ./result_8chains/node385_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_7_2 -p 980 -st topic385_7_1 -pt None -u 0.02701990215672391 > ./result_8chains/node385_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_0_0 -p 85 -st none -pt topic385_0_0 -u 0.005055361472530495 > ./result_8chains/node385_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_1_0 -p 92 -st none -pt topic385_1_0 -u 0.0025899279619012727 > ./result_8chains/node385_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_2_0 -p 203 -st none -pt topic385_2_0 -u 0.021487230795959877 > ./result_8chains/node385_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_3_0 -p 403 -st none -pt topic385_3_0 -u 0.045923789564147055 > ./result_8chains/node385_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_4_0 -p 624 -st none -pt topic385_4_0 -u 0.00995031854771039 > ./result_8chains/node385_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_5_0 -p 720 -st none -pt topic385_5_0 -u 0.007769295503538137 > ./result_8chains/node385_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node385_6_0 -p 947 -st none -pt topic385_6_0 -u 0.04676948997906549 > ./result_8chains/node385_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node385_7_0 -p 980 -st none -pt topic385_7_0 -u 0.0034798747405910824 > ./result_8chains/node385_7_0.txt &
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
    "./result_8chains/node385_0_0.txt 90"
    "./result_8chains/node385_0_2.txt 90"
    "./result_8chains/node385_1_0.txt 89"
    "./result_8chains/node385_1_2.txt 89"
    "./result_8chains/node385_2_0.txt 88"
    "./result_8chains/node385_2_2.txt 88"
    "./result_8chains/node385_3_0.txt 87"
    "./result_8chains/node385_3_2.txt 87"
    "./result_8chains/node385_4_0.txt 86"
    "./result_8chains/node385_4_2.txt 86"
    "./result_8chains/node385_5_0.txt 85"
    "./result_8chains/node385_5_2.txt 85"
    "./result_8chains/node385_6_0.txt 84"
    "./result_8chains/node385_6_2.txt 84"
    "./result_8chains/node385_7_0.txt 83"
    "./result_8chains/node385_7_2.txt 83"
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
