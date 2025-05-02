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
ros2 run evaluation_3_randomdag uunifast_node -n node422_0_2 -p 42 -st topic422_0_1 -pt None -u 0.061899660013404634 > ./result_4chains/node422_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_1_2 -p 648 -st topic422_1_1 -pt None -u 0.0022363646195899534 > ./result_4chains/node422_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_2_2 -p 708 -st topic422_2_1 -pt None -u 0.09477019897851327 > ./result_4chains/node422_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_3_2 -p 775 -st topic422_3_1 -pt None -u 0.013363147986434924 > ./result_4chains/node422_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_0_0 -p 42 -st none -pt topic422_0_0 -u 0.011061462307085212 > ./result_4chains/node422_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_1_0 -p 648 -st none -pt topic422_1_0 -u 0.049478138723791865 > ./result_4chains/node422_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_2_0 -p 708 -st none -pt topic422_2_0 -u 0.03230997065637184 > ./result_4chains/node422_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_3_0 -p 775 -st none -pt topic422_3_0 -u 0.019297734867703392 > ./result_4chains/node422_3_0.txt &
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
    "./result_4chains/node422_0_0.txt 90"
    "./result_4chains/node422_0_2.txt 90"
    "./result_4chains/node422_1_0.txt 89"
    "./result_4chains/node422_1_2.txt 89"
    "./result_4chains/node422_2_0.txt 88"
    "./result_4chains/node422_2_2.txt 88"
    "./result_4chains/node422_3_0.txt 87"
    "./result_4chains/node422_3_2.txt 87"
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
