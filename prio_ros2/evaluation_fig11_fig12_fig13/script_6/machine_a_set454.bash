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
ros2 run evaluation_3_randomdag uunifast_node -n node454_0_2 -p 273 -st topic454_0_1 -pt None -u 0.024104549367479022 > ./result_6chains/node454_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_1_2 -p 539 -st topic454_1_1 -pt None -u 0.02318537377690738 > ./result_6chains/node454_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_2_2 -p 546 -st topic454_2_1 -pt None -u 0.03632742195798205 > ./result_6chains/node454_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_3_2 -p 842 -st topic454_3_1 -pt None -u 0.002805192604061396 > ./result_6chains/node454_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_4_2 -p 864 -st topic454_4_1 -pt None -u 0.008236475150374983 > ./result_6chains/node454_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_5_2 -p 999 -st topic454_5_1 -pt None -u 0.10135362613209634 > ./result_6chains/node454_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_0_0 -p 273 -st none -pt topic454_0_0 -u 0.011814383810256401 > ./result_6chains/node454_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_1_0 -p 539 -st none -pt topic454_1_0 -u 0.02375374077040976 > ./result_6chains/node454_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_2_0 -p 546 -st none -pt topic454_2_0 -u 0.030751530431737895 > ./result_6chains/node454_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_3_0 -p 842 -st none -pt topic454_3_0 -u 0.006294513537532576 > ./result_6chains/node454_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_4_0 -p 864 -st none -pt topic454_4_0 -u 0.048867904996104966 > ./result_6chains/node454_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_5_0 -p 999 -st none -pt topic454_5_0 -u 0.016405161700957738 > ./result_6chains/node454_5_0.txt &
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
    "./result_6chains/node454_0_0.txt 90"
    "./result_6chains/node454_0_2.txt 90"
    "./result_6chains/node454_1_0.txt 89"
    "./result_6chains/node454_1_2.txt 89"
    "./result_6chains/node454_2_0.txt 88"
    "./result_6chains/node454_2_2.txt 88"
    "./result_6chains/node454_3_0.txt 87"
    "./result_6chains/node454_3_2.txt 87"
    "./result_6chains/node454_4_0.txt 86"
    "./result_6chains/node454_4_2.txt 86"
    "./result_6chains/node454_5_0.txt 85"
    "./result_6chains/node454_5_2.txt 85"
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
