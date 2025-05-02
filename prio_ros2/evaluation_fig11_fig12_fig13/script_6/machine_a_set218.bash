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
ros2 run evaluation_3_randomdag uunifast_node -n node218_0_2 -p 27 -st topic218_0_1 -pt None -u 0.04232134545442118 > ./result_6chains/node218_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_1_2 -p 128 -st topic218_1_1 -pt None -u 0.057234210542481845 > ./result_6chains/node218_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_2_2 -p 194 -st topic218_2_1 -pt None -u 0.08056526876019493 > ./result_6chains/node218_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_3_2 -p 295 -st topic218_3_1 -pt None -u 0.012948974238014305 > ./result_6chains/node218_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_4_2 -p 387 -st topic218_4_1 -pt None -u 0.021173280119298796 > ./result_6chains/node218_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_5_2 -p 774 -st topic218_5_1 -pt None -u 0.06813527442993496 > ./result_6chains/node218_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_0_0 -p 27 -st none -pt topic218_0_0 -u 0.02148629325589191 > ./result_6chains/node218_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_1_0 -p 128 -st none -pt topic218_1_0 -u 0.01101795176438547 > ./result_6chains/node218_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_2_0 -p 194 -st none -pt topic218_2_0 -u 0.005016636642290295 > ./result_6chains/node218_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_3_0 -p 295 -st none -pt topic218_3_0 -u 0.02430748262359414 > ./result_6chains/node218_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_4_0 -p 387 -st none -pt topic218_4_0 -u 0.017775100190307855 > ./result_6chains/node218_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node218_5_0 -p 774 -st none -pt topic218_5_0 -u 0.0009814066985455727 > ./result_6chains/node218_5_0.txt &
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
    "./result_6chains/node218_0_0.txt 90"
    "./result_6chains/node218_0_2.txt 90"
    "./result_6chains/node218_1_0.txt 89"
    "./result_6chains/node218_1_2.txt 89"
    "./result_6chains/node218_2_0.txt 88"
    "./result_6chains/node218_2_2.txt 88"
    "./result_6chains/node218_3_0.txt 87"
    "./result_6chains/node218_3_2.txt 87"
    "./result_6chains/node218_4_0.txt 86"
    "./result_6chains/node218_4_2.txt 86"
    "./result_6chains/node218_5_0.txt 85"
    "./result_6chains/node218_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
