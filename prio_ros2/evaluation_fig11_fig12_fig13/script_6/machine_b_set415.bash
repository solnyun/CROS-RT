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
ros2 run evaluation_3_randomdag uunifast_node -n node415_0_1 -p 68 -st topic415_0_0 -pt topic415_0_1 -u 0.007162807535501803 > ./result_6chains/node415_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_1_1 -p 117 -st topic415_1_0 -pt topic415_1_1 -u 0.0046116953006819505 > ./result_6chains/node415_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_2_1 -p 217 -st topic415_2_0 -pt topic415_2_1 -u 0.011035302062409547 > ./result_6chains/node415_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_3_1 -p 444 -st topic415_3_0 -pt topic415_3_1 -u 0.013772062569479326 > ./result_6chains/node415_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_4_1 -p 755 -st topic415_4_0 -pt topic415_4_1 -u 0.0021251933076437968 > ./result_6chains/node415_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node415_5_1 -p 759 -st topic415_5_0 -pt topic415_5_1 -u 0.1033925388324528 > ./result_6chains/node415_5_1.txt &
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
    "./result_6chains/node415_0_1.txt 90"
    "./result_6chains/node415_1_1.txt 89"
    "./result_6chains/node415_2_1.txt 88"
    "./result_6chains/node415_3_1.txt 87"
    "./result_6chains/node415_4_1.txt 86"
    "./result_6chains/node415_5_1.txt 85"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
