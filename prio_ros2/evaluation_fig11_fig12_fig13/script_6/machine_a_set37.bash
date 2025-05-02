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
ros2 run evaluation_3_randomdag uunifast_node -n node37_0_2 -p 234 -st topic37_0_1 -pt None -u 0.06963640339463356 > ./result_6chains/node37_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_1_2 -p 425 -st topic37_1_1 -pt None -u 0.003151262658385834 > ./result_6chains/node37_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_2_2 -p 473 -st topic37_2_1 -pt None -u 0.021569654321364595 > ./result_6chains/node37_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_3_2 -p 495 -st topic37_3_1 -pt None -u 0.005714461942104565 > ./result_6chains/node37_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_4_2 -p 679 -st topic37_4_1 -pt None -u 0.025891457911198672 > ./result_6chains/node37_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_5_2 -p 695 -st topic37_5_1 -pt None -u 0.03257568579070624 > ./result_6chains/node37_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_0_0 -p 234 -st none -pt topic37_0_0 -u 0.00489679738020371 > ./result_6chains/node37_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_1_0 -p 425 -st none -pt topic37_1_0 -u 0.03985575591843249 > ./result_6chains/node37_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_2_0 -p 473 -st none -pt topic37_2_0 -u 0.012964001546578618 > ./result_6chains/node37_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_3_0 -p 495 -st none -pt topic37_3_0 -u 0.02834586045114168 > ./result_6chains/node37_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node37_4_0 -p 679 -st none -pt topic37_4_0 -u 0.03987218981709373 > ./result_6chains/node37_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node37_5_0 -p 695 -st none -pt topic37_5_0 -u 0.011645537714534034 > ./result_6chains/node37_5_0.txt &
sleep 10
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
    "./result_6chains/node37_0_0.txt 90"
    "./result_6chains/node37_0_2.txt 90"
    "./result_6chains/node37_1_0.txt 89"
    "./result_6chains/node37_1_2.txt 89"
    "./result_6chains/node37_2_0.txt 88"
    "./result_6chains/node37_2_2.txt 88"
    "./result_6chains/node37_3_0.txt 87"
    "./result_6chains/node37_3_2.txt 87"
    "./result_6chains/node37_4_0.txt 86"
    "./result_6chains/node37_4_2.txt 86"
    "./result_6chains/node37_5_0.txt 85"
    "./result_6chains/node37_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
