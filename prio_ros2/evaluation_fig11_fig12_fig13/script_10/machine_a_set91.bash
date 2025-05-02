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
ros2 run evaluation_3_randomdag uunifast_node -n node91_0_2 -p 87 -st topic91_0_1 -pt None -u 0.013814163593990625 > ./result_10chains/node91_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_1_2 -p 288 -st topic91_1_1 -pt None -u 0.02798405219076916 > ./result_10chains/node91_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_2_2 -p 642 -st topic91_2_1 -pt None -u 0.0054062708531184556 > ./result_10chains/node91_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_3_2 -p 687 -st topic91_3_1 -pt None -u 0.011000848915577788 > ./result_10chains/node91_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_4_2 -p 750 -st topic91_4_1 -pt None -u 0.006333568740008622 > ./result_10chains/node91_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_5_2 -p 778 -st topic91_5_1 -pt None -u 0.0033930583263506175 > ./result_10chains/node91_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_6_2 -p 815 -st topic91_6_1 -pt None -u 0.03971964925598198 > ./result_10chains/node91_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_7_2 -p 881 -st topic91_7_1 -pt None -u 0.018390820011324666 > ./result_10chains/node91_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_8_2 -p 957 -st topic91_8_1 -pt None -u 0.02134707113884045 > ./result_10chains/node91_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_9_2 -p 994 -st topic91_9_1 -pt None -u 0.008913901306803548 > ./result_10chains/node91_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_0_0 -p 87 -st none -pt topic91_0_0 -u 0.0007484946019216676 > ./result_10chains/node91_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_1_0 -p 288 -st none -pt topic91_1_0 -u 0.01593423481790579 > ./result_10chains/node91_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_2_0 -p 642 -st none -pt topic91_2_0 -u 0.0025865257971521283 > ./result_10chains/node91_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_3_0 -p 687 -st none -pt topic91_3_0 -u 0.00701349181077815 > ./result_10chains/node91_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_4_0 -p 750 -st none -pt topic91_4_0 -u 0.01051051929922775 > ./result_10chains/node91_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_5_0 -p 778 -st none -pt topic91_5_0 -u 0.08877431699883406 > ./result_10chains/node91_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_6_0 -p 815 -st none -pt topic91_6_0 -u 0.01607831731242229 > ./result_10chains/node91_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_7_0 -p 881 -st none -pt topic91_7_0 -u 0.01910190673449788 > ./result_10chains/node91_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_8_0 -p 957 -st none -pt topic91_8_0 -u 0.016070205681309888 > ./result_10chains/node91_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node91_9_0 -p 994 -st none -pt topic91_9_0 -u 0.0007077575044300479 > ./result_10chains/node91_9_0.txt &
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
    "./result_10chains/node91_0_0.txt 90"
    "./result_10chains/node91_0_2.txt 90"
    "./result_10chains/node91_1_0.txt 89"
    "./result_10chains/node91_1_2.txt 89"
    "./result_10chains/node91_2_0.txt 88"
    "./result_10chains/node91_2_2.txt 88"
    "./result_10chains/node91_3_0.txt 87"
    "./result_10chains/node91_3_2.txt 87"
    "./result_10chains/node91_4_0.txt 86"
    "./result_10chains/node91_4_2.txt 86"
    "./result_10chains/node91_5_0.txt 85"
    "./result_10chains/node91_5_2.txt 85"
    "./result_10chains/node91_6_0.txt 84"
    "./result_10chains/node91_6_2.txt 84"
    "./result_10chains/node91_7_0.txt 83"
    "./result_10chains/node91_7_2.txt 83"
    "./result_10chains/node91_8_0.txt 82"
    "./result_10chains/node91_8_2.txt 82"
    "./result_10chains/node91_9_0.txt 81"
    "./result_10chains/node91_9_2.txt 81"
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
