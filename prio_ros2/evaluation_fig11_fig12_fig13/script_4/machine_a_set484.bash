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
ros2 run evaluation_3_randomdag uunifast_node -n node484_0_2 -p 93 -st topic484_0_1 -pt None -u 0.1717275619762747 > ./result_4chains/node484_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_1_2 -p 139 -st topic484_1_1 -pt None -u 0.010047888891932255 > ./result_4chains/node484_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_2_2 -p 673 -st topic484_2_1 -pt None -u 0.09656250100238487 > ./result_4chains/node484_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_3_2 -p 933 -st topic484_3_1 -pt None -u 0.0010092757826870456 > ./result_4chains/node484_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_0_0 -p 93 -st none -pt topic484_0_0 -u 0.011020028801506376 > ./result_4chains/node484_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_1_0 -p 139 -st none -pt topic484_1_0 -u 0.06684889650173628 > ./result_4chains/node484_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_2_0 -p 673 -st none -pt topic484_2_0 -u 0.0061249843641326684 > ./result_4chains/node484_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_3_0 -p 933 -st none -pt topic484_3_0 -u 0.004989312674844404 > ./result_4chains/node484_3_0.txt &
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
    "./result_4chains/node484_0_0.txt 90"
    "./result_4chains/node484_0_2.txt 90"
    "./result_4chains/node484_1_0.txt 89"
    "./result_4chains/node484_1_2.txt 89"
    "./result_4chains/node484_2_0.txt 88"
    "./result_4chains/node484_2_2.txt 88"
    "./result_4chains/node484_3_0.txt 87"
    "./result_4chains/node484_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
