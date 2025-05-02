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
ros2 run evaluation_3_randomdag uunifast_node -n node418_0_1 -p 48 -st topic418_0_0 -pt topic418_0_1 -u 0.004429261656178629 > ./result_8chains/node418_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_1_1 -p 79 -st topic418_1_0 -pt topic418_1_1 -u 0.02031409065868911 > ./result_8chains/node418_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_2_1 -p 163 -st topic418_2_0 -pt topic418_2_1 -u 0.018635337006336683 > ./result_8chains/node418_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_3_1 -p 425 -st topic418_3_0 -pt topic418_3_1 -u 0.04446008970874432 > ./result_8chains/node418_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_4_1 -p 475 -st topic418_4_0 -pt topic418_4_1 -u 0.0016786702644368823 > ./result_8chains/node418_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_5_1 -p 515 -st topic418_5_0 -pt topic418_5_1 -u 0.013159292204134143 > ./result_8chains/node418_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_6_1 -p 581 -st topic418_6_0 -pt topic418_6_1 -u 0.01839933313465729 > ./result_8chains/node418_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node418_7_1 -p 678 -st topic418_7_0 -pt topic418_7_1 -u 0.039462716694506725 > ./result_8chains/node418_7_1.txt &
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
    "./result_8chains/node418_0_1.txt 90"
    "./result_8chains/node418_1_1.txt 89"
    "./result_8chains/node418_2_1.txt 88"
    "./result_8chains/node418_3_1.txt 87"
    "./result_8chains/node418_4_1.txt 86"
    "./result_8chains/node418_5_1.txt 85"
    "./result_8chains/node418_6_1.txt 84"
    "./result_8chains/node418_7_1.txt 83"
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
