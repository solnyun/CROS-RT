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
ros2 run evaluation_3_randomdag uunifast_node -n node334_0_1 -p 72 -st topic334_0_0 -pt topic334_0_1 -u 0.003435695026675123 > ./result_8chains/node334_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_1_1 -p 353 -st topic334_1_0 -pt topic334_1_1 -u 0.010713103093395293 > ./result_8chains/node334_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_2_1 -p 381 -st topic334_2_0 -pt topic334_2_1 -u 0.00766185433959371 > ./result_8chains/node334_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_3_1 -p 545 -st topic334_3_0 -pt topic334_3_1 -u 0.062249042294444557 > ./result_8chains/node334_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_4_1 -p 658 -st topic334_4_0 -pt topic334_4_1 -u 0.05286345856561919 > ./result_8chains/node334_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_5_1 -p 697 -st topic334_5_0 -pt topic334_5_1 -u 0.020793747301473958 > ./result_8chains/node334_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_6_1 -p 816 -st topic334_6_0 -pt topic334_6_1 -u 0.03250188627968538 > ./result_8chains/node334_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node334_7_1 -p 821 -st topic334_7_0 -pt topic334_7_1 -u 0.026470577831088724 > ./result_8chains/node334_7_1.txt &
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
    "./result_8chains/node334_0_1.txt 90"
    "./result_8chains/node334_1_1.txt 89"
    "./result_8chains/node334_2_1.txt 88"
    "./result_8chains/node334_3_1.txt 87"
    "./result_8chains/node334_4_1.txt 86"
    "./result_8chains/node334_5_1.txt 85"
    "./result_8chains/node334_6_1.txt 84"
    "./result_8chains/node334_7_1.txt 83"
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
