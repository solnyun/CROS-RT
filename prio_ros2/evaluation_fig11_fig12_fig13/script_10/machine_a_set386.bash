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
ros2 run evaluation_3_randomdag uunifast_node -n node386_0_2 -p 30 -st topic386_0_1 -pt None -u 0.009270232379557097 > ./result_10chains/node386_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_1_2 -p 71 -st topic386_1_1 -pt None -u 0.013092892280451518 > ./result_10chains/node386_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_2_2 -p 121 -st topic386_2_1 -pt None -u 0.019290122216489736 > ./result_10chains/node386_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_3_2 -p 233 -st topic386_3_1 -pt None -u 0.004101843934834315 > ./result_10chains/node386_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_4_2 -p 407 -st topic386_4_1 -pt None -u 0.021587765063246778 > ./result_10chains/node386_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_5_2 -p 421 -st topic386_5_1 -pt None -u 0.05367436057597186 > ./result_10chains/node386_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_6_2 -p 689 -st topic386_6_1 -pt None -u 0.0005407922966462475 > ./result_10chains/node386_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_7_2 -p 699 -st topic386_7_1 -pt None -u 0.04156669366722475 > ./result_10chains/node386_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_8_2 -p 888 -st topic386_8_1 -pt None -u 0.0001374648717312188 > ./result_10chains/node386_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_9_2 -p 933 -st topic386_9_1 -pt None -u 0.026308313175406776 > ./result_10chains/node386_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_0_0 -p 30 -st none -pt topic386_0_0 -u 0.009059512351230703 > ./result_10chains/node386_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_1_0 -p 71 -st none -pt topic386_1_0 -u 0.0023615243173776834 > ./result_10chains/node386_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_2_0 -p 121 -st none -pt topic386_2_0 -u 0.06989237091731715 > ./result_10chains/node386_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_3_0 -p 233 -st none -pt topic386_3_0 -u 0.024486438149552647 > ./result_10chains/node386_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_4_0 -p 407 -st none -pt topic386_4_0 -u 0.018092639228615037 > ./result_10chains/node386_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_5_0 -p 421 -st none -pt topic386_5_0 -u 0.00775777827086771 > ./result_10chains/node386_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_6_0 -p 689 -st none -pt topic386_6_0 -u 0.02480712668325874 > ./result_10chains/node386_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_7_0 -p 699 -st none -pt topic386_7_0 -u 0.020025516112930103 > ./result_10chains/node386_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_8_0 -p 888 -st none -pt topic386_8_0 -u 0.008261599930135963 > ./result_10chains/node386_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_9_0 -p 933 -st none -pt topic386_9_0 -u 0.044322241725989094 > ./result_10chains/node386_9_0.txt &
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
    "./result_10chains/node386_0_0.txt 90"
    "./result_10chains/node386_0_2.txt 90"
    "./result_10chains/node386_1_0.txt 89"
    "./result_10chains/node386_1_2.txt 89"
    "./result_10chains/node386_2_0.txt 88"
    "./result_10chains/node386_2_2.txt 88"
    "./result_10chains/node386_3_0.txt 87"
    "./result_10chains/node386_3_2.txt 87"
    "./result_10chains/node386_4_0.txt 86"
    "./result_10chains/node386_4_2.txt 86"
    "./result_10chains/node386_5_0.txt 85"
    "./result_10chains/node386_5_2.txt 85"
    "./result_10chains/node386_6_0.txt 84"
    "./result_10chains/node386_6_2.txt 84"
    "./result_10chains/node386_7_0.txt 83"
    "./result_10chains/node386_7_2.txt 83"
    "./result_10chains/node386_8_0.txt 82"
    "./result_10chains/node386_8_2.txt 82"
    "./result_10chains/node386_9_0.txt 81"
    "./result_10chains/node386_9_2.txt 81"
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
