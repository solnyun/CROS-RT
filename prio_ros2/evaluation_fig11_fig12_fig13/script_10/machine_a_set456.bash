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
ros2 run evaluation_3_randomdag uunifast_node -n node456_0_2 -p 154 -st topic456_0_1 -pt None -u 0.02418992322070579 > ./result_10chains/node456_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_1_2 -p 178 -st topic456_1_1 -pt None -u 0.0013559726844858955 > ./result_10chains/node456_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_2_2 -p 279 -st topic456_2_1 -pt None -u 0.022546609301216047 > ./result_10chains/node456_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_3_2 -p 313 -st topic456_3_1 -pt None -u 0.018639477350468947 > ./result_10chains/node456_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_4_2 -p 487 -st topic456_4_1 -pt None -u 0.004289811803501492 > ./result_10chains/node456_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_5_2 -p 631 -st topic456_5_1 -pt None -u 0.00797484802100823 > ./result_10chains/node456_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_6_2 -p 662 -st topic456_6_1 -pt None -u 0.0014456885433118127 > ./result_10chains/node456_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_7_2 -p 764 -st topic456_7_1 -pt None -u 0.006895865691630976 > ./result_10chains/node456_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_8_2 -p 803 -st topic456_8_1 -pt None -u 0.006305959324614432 > ./result_10chains/node456_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_9_2 -p 950 -st topic456_9_1 -pt None -u 0.04554058782298641 > ./result_10chains/node456_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_0_0 -p 154 -st none -pt topic456_0_0 -u 0.01810967672946656 > ./result_10chains/node456_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_1_0 -p 178 -st none -pt topic456_1_0 -u 0.013880257278604702 > ./result_10chains/node456_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_2_0 -p 279 -st none -pt topic456_2_0 -u 0.00019606823044127086 > ./result_10chains/node456_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_3_0 -p 313 -st none -pt topic456_3_0 -u 0.020610914640548927 > ./result_10chains/node456_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_4_0 -p 487 -st none -pt topic456_4_0 -u 0.051577888992411974 > ./result_10chains/node456_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_5_0 -p 631 -st none -pt topic456_5_0 -u 0.007259385920514283 > ./result_10chains/node456_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_6_0 -p 662 -st none -pt topic456_6_0 -u 0.02014283372630729 > ./result_10chains/node456_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_7_0 -p 764 -st none -pt topic456_7_0 -u 0.005378719290649425 > ./result_10chains/node456_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node456_8_0 -p 803 -st none -pt topic456_8_0 -u 0.00196209907254552 > ./result_10chains/node456_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node456_9_0 -p 950 -st none -pt topic456_9_0 -u 0.021832902005190585 > ./result_10chains/node456_9_0.txt &
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
    "./result_10chains/node456_0_0.txt 90"
    "./result_10chains/node456_0_2.txt 90"
    "./result_10chains/node456_1_0.txt 89"
    "./result_10chains/node456_1_2.txt 89"
    "./result_10chains/node456_2_0.txt 88"
    "./result_10chains/node456_2_2.txt 88"
    "./result_10chains/node456_3_0.txt 87"
    "./result_10chains/node456_3_2.txt 87"
    "./result_10chains/node456_4_0.txt 86"
    "./result_10chains/node456_4_2.txt 86"
    "./result_10chains/node456_5_0.txt 85"
    "./result_10chains/node456_5_2.txt 85"
    "./result_10chains/node456_6_0.txt 84"
    "./result_10chains/node456_6_2.txt 84"
    "./result_10chains/node456_7_0.txt 83"
    "./result_10chains/node456_7_2.txt 83"
    "./result_10chains/node456_8_0.txt 82"
    "./result_10chains/node456_8_2.txt 82"
    "./result_10chains/node456_9_0.txt 81"
    "./result_10chains/node456_9_2.txt 81"
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
