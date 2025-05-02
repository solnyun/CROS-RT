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
ros2 run evaluation_3_randomdag uunifast_node -n node121_0_2 -p 72 -st topic121_0_1 -pt None -u 0.06224041816760445 > ./result_8chains/node121_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_1_2 -p 94 -st topic121_1_1 -pt None -u 0.0009322362739983547 > ./result_8chains/node121_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_2_2 -p 104 -st topic121_2_1 -pt None -u 0.0007660648789082347 > ./result_8chains/node121_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_3_2 -p 138 -st topic121_3_1 -pt None -u 0.008408386750160701 > ./result_8chains/node121_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_4_2 -p 196 -st topic121_4_1 -pt None -u 0.01455692072598086 > ./result_8chains/node121_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_5_2 -p 449 -st topic121_5_1 -pt None -u 0.02100283514600243 > ./result_8chains/node121_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_6_2 -p 549 -st topic121_6_1 -pt None -u 0.05597696551358031 > ./result_8chains/node121_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_7_2 -p 711 -st topic121_7_1 -pt None -u 0.01644910583973726 > ./result_8chains/node121_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_0_0 -p 72 -st none -pt topic121_0_0 -u 0.018263138497894182 > ./result_8chains/node121_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_1_0 -p 94 -st none -pt topic121_1_0 -u 0.0020224657572064375 > ./result_8chains/node121_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_2_0 -p 104 -st none -pt topic121_2_0 -u 0.02434977520865622 > ./result_8chains/node121_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_3_0 -p 138 -st none -pt topic121_3_0 -u 0.025897202817903198 > ./result_8chains/node121_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_4_0 -p 196 -st none -pt topic121_4_0 -u 0.024575605177508814 > ./result_8chains/node121_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_5_0 -p 449 -st none -pt topic121_5_0 -u 0.020741081897212604 > ./result_8chains/node121_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_6_0 -p 549 -st none -pt topic121_6_0 -u 0.006149245056886604 > ./result_8chains/node121_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_7_0 -p 711 -st none -pt topic121_7_0 -u 0.024121760329912277 > ./result_8chains/node121_7_0.txt &
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
    "./result_8chains/node121_0_0.txt 90"
    "./result_8chains/node121_0_2.txt 90"
    "./result_8chains/node121_1_0.txt 89"
    "./result_8chains/node121_1_2.txt 89"
    "./result_8chains/node121_2_0.txt 88"
    "./result_8chains/node121_2_2.txt 88"
    "./result_8chains/node121_3_0.txt 87"
    "./result_8chains/node121_3_2.txt 87"
    "./result_8chains/node121_4_0.txt 86"
    "./result_8chains/node121_4_2.txt 86"
    "./result_8chains/node121_5_0.txt 85"
    "./result_8chains/node121_5_2.txt 85"
    "./result_8chains/node121_6_0.txt 84"
    "./result_8chains/node121_6_2.txt 84"
    "./result_8chains/node121_7_0.txt 83"
    "./result_8chains/node121_7_2.txt 83"
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
