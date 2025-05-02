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
ros2 run evaluation_3_randomdag uunifast_node -n node192_0_2 -p 223 -st topic192_0_1 -pt None -u 0.03340959292521156 > ./result_10chains/node192_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_1_2 -p 312 -st topic192_1_1 -pt None -u 0.015537244719529497 > ./result_10chains/node192_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_2_2 -p 449 -st topic192_2_1 -pt None -u 0.06109335434644836 > ./result_10chains/node192_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_3_2 -p 523 -st topic192_3_1 -pt None -u 0.042374016731595465 > ./result_10chains/node192_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_4_2 -p 574 -st topic192_4_1 -pt None -u 0.007107635397192974 > ./result_10chains/node192_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_5_2 -p 757 -st topic192_5_1 -pt None -u 0.028547107672758254 > ./result_10chains/node192_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_6_2 -p 784 -st topic192_6_1 -pt None -u 0.017731330357021846 > ./result_10chains/node192_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_7_2 -p 821 -st topic192_7_1 -pt None -u 0.01333002562536359 > ./result_10chains/node192_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_8_2 -p 845 -st topic192_8_1 -pt None -u 0.002596060242083434 > ./result_10chains/node192_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_9_2 -p 974 -st topic192_9_1 -pt None -u 0.036451760544654974 > ./result_10chains/node192_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_0_0 -p 223 -st none -pt topic192_0_0 -u 0.014965282847003658 > ./result_10chains/node192_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_1_0 -p 312 -st none -pt topic192_1_0 -u 0.015696500394298873 > ./result_10chains/node192_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_2_0 -p 449 -st none -pt topic192_2_0 -u 0.0010535021460900684 > ./result_10chains/node192_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_3_0 -p 523 -st none -pt topic192_3_0 -u 0.015760824248638006 > ./result_10chains/node192_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_4_0 -p 574 -st none -pt topic192_4_0 -u 0.010040060526405992 > ./result_10chains/node192_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_5_0 -p 757 -st none -pt topic192_5_0 -u 0.0042008015874461235 > ./result_10chains/node192_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_6_0 -p 784 -st none -pt topic192_6_0 -u 0.0011959097077882674 > ./result_10chains/node192_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_7_0 -p 821 -st none -pt topic192_7_0 -u 0.006219442382610962 > ./result_10chains/node192_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_8_0 -p 845 -st none -pt topic192_8_0 -u 0.01885926413090222 > ./result_10chains/node192_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_9_0 -p 974 -st none -pt topic192_9_0 -u 0.028011901725285726 > ./result_10chains/node192_9_0.txt &
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
    "./result_10chains/node192_0_0.txt 90"
    "./result_10chains/node192_0_2.txt 90"
    "./result_10chains/node192_1_0.txt 89"
    "./result_10chains/node192_1_2.txt 89"
    "./result_10chains/node192_2_0.txt 88"
    "./result_10chains/node192_2_2.txt 88"
    "./result_10chains/node192_3_0.txt 87"
    "./result_10chains/node192_3_2.txt 87"
    "./result_10chains/node192_4_0.txt 86"
    "./result_10chains/node192_4_2.txt 86"
    "./result_10chains/node192_5_0.txt 85"
    "./result_10chains/node192_5_2.txt 85"
    "./result_10chains/node192_6_0.txt 84"
    "./result_10chains/node192_6_2.txt 84"
    "./result_10chains/node192_7_0.txt 83"
    "./result_10chains/node192_7_2.txt 83"
    "./result_10chains/node192_8_0.txt 82"
    "./result_10chains/node192_8_2.txt 82"
    "./result_10chains/node192_9_0.txt 81"
    "./result_10chains/node192_9_2.txt 81"
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
