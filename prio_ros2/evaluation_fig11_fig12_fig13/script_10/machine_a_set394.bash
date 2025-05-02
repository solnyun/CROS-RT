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
ros2 run evaluation_3_randomdag uunifast_node -n node394_0_2 -p 50 -st topic394_0_1 -pt None -u 0.009200318095235305 > ./result_10chains/node394_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_1_2 -p 62 -st topic394_1_1 -pt None -u 0.002461910149669566 > ./result_10chains/node394_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_2_2 -p 109 -st topic394_2_1 -pt None -u 0.012292008366954377 > ./result_10chains/node394_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_3_2 -p 179 -st topic394_3_1 -pt None -u 0.012769073113331142 > ./result_10chains/node394_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_4_2 -p 250 -st topic394_4_1 -pt None -u 0.009845666487053095 > ./result_10chains/node394_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_5_2 -p 362 -st topic394_5_1 -pt None -u 0.018153943012560736 > ./result_10chains/node394_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_6_2 -p 372 -st topic394_6_1 -pt None -u 0.021549996244608766 > ./result_10chains/node394_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_7_2 -p 665 -st topic394_7_1 -pt None -u 0.0685064862232429 > ./result_10chains/node394_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_8_2 -p 693 -st topic394_8_1 -pt None -u 0.04418717569463121 > ./result_10chains/node394_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_9_2 -p 926 -st topic394_9_1 -pt None -u 0.011142493476463724 > ./result_10chains/node394_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_0_0 -p 50 -st none -pt topic394_0_0 -u 0.019929143094446655 > ./result_10chains/node394_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_1_0 -p 62 -st none -pt topic394_1_0 -u 0.021141079373971805 > ./result_10chains/node394_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_2_0 -p 109 -st none -pt topic394_2_0 -u 0.019520689167064897 > ./result_10chains/node394_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_3_0 -p 179 -st none -pt topic394_3_0 -u 0.013457384966592822 > ./result_10chains/node394_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_4_0 -p 250 -st none -pt topic394_4_0 -u 0.0032362122915292058 > ./result_10chains/node394_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_5_0 -p 362 -st none -pt topic394_5_0 -u 0.013584790283438897 > ./result_10chains/node394_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_6_0 -p 372 -st none -pt topic394_6_0 -u 0.015707354411982816 > ./result_10chains/node394_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_7_0 -p 665 -st none -pt topic394_7_0 -u 0.021506089255818484 > ./result_10chains/node394_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node394_8_0 -p 693 -st none -pt topic394_8_0 -u 0.0365662048017117 > ./result_10chains/node394_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node394_9_0 -p 926 -st none -pt topic394_9_0 -u 0.0017588884304748677 > ./result_10chains/node394_9_0.txt &
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
    "./result_10chains/node394_0_0.txt 90"
    "./result_10chains/node394_0_2.txt 90"
    "./result_10chains/node394_1_0.txt 89"
    "./result_10chains/node394_1_2.txt 89"
    "./result_10chains/node394_2_0.txt 88"
    "./result_10chains/node394_2_2.txt 88"
    "./result_10chains/node394_3_0.txt 87"
    "./result_10chains/node394_3_2.txt 87"
    "./result_10chains/node394_4_0.txt 86"
    "./result_10chains/node394_4_2.txt 86"
    "./result_10chains/node394_5_0.txt 85"
    "./result_10chains/node394_5_2.txt 85"
    "./result_10chains/node394_6_0.txt 84"
    "./result_10chains/node394_6_2.txt 84"
    "./result_10chains/node394_7_0.txt 83"
    "./result_10chains/node394_7_2.txt 83"
    "./result_10chains/node394_8_0.txt 82"
    "./result_10chains/node394_8_2.txt 82"
    "./result_10chains/node394_9_0.txt 81"
    "./result_10chains/node394_9_2.txt 81"
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
