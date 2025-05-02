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
ros2 run evaluation_3_randomdag uunifast_node -n node347_0_1 -p 40 -st topic347_0_0 -pt topic347_0_1 -u 0.03136263349138613 > ./result_10chains/node347_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_1_1 -p 261 -st topic347_1_0 -pt topic347_1_1 -u 8.651551958793746e-05 > ./result_10chains/node347_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_2_1 -p 326 -st topic347_2_0 -pt topic347_2_1 -u 0.025832067991658048 > ./result_10chains/node347_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_3_1 -p 577 -st topic347_3_0 -pt topic347_3_1 -u 0.013741976151350366 > ./result_10chains/node347_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_4_1 -p 596 -st topic347_4_0 -pt topic347_4_1 -u 0.0021290074477784415 > ./result_10chains/node347_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_5_1 -p 690 -st topic347_5_0 -pt topic347_5_1 -u 0.025820340155846444 > ./result_10chains/node347_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_6_1 -p 715 -st topic347_6_0 -pt topic347_6_1 -u 0.007618811627326166 > ./result_10chains/node347_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_7_1 -p 737 -st topic347_7_0 -pt topic347_7_1 -u 0.00019926451443232074 > ./result_10chains/node347_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_8_1 -p 909 -st topic347_8_0 -pt topic347_8_1 -u 0.0035360423766302718 > ./result_10chains/node347_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node347_9_1 -p 926 -st topic347_9_0 -pt topic347_9_1 -u 0.01121751683983126 > ./result_10chains/node347_9_1.txt &
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
    "./result_10chains/node347_0_1.txt 90"
    "./result_10chains/node347_1_1.txt 89"
    "./result_10chains/node347_2_1.txt 88"
    "./result_10chains/node347_3_1.txt 87"
    "./result_10chains/node347_4_1.txt 86"
    "./result_10chains/node347_5_1.txt 85"
    "./result_10chains/node347_6_1.txt 84"
    "./result_10chains/node347_7_1.txt 83"
    "./result_10chains/node347_8_1.txt 82"
    "./result_10chains/node347_9_1.txt 81"
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
