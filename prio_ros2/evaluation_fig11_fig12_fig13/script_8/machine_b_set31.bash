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
ros2 run evaluation_3_randomdag uunifast_node -n node31_0_1 -p 329 -st topic31_0_0 -pt topic31_0_1 -u 0.022825665536284567 > ./result_8chains/node31_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_1_1 -p 454 -st topic31_1_0 -pt topic31_1_1 -u 0.026872633762226705 > ./result_8chains/node31_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_2_1 -p 514 -st topic31_2_0 -pt topic31_2_1 -u 0.02832865725338718 > ./result_8chains/node31_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_3_1 -p 517 -st topic31_3_0 -pt topic31_3_1 -u 0.012170008586047276 > ./result_8chains/node31_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_4_1 -p 612 -st topic31_4_0 -pt topic31_4_1 -u 0.007946230500755047 > ./result_8chains/node31_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_5_1 -p 671 -st topic31_5_0 -pt topic31_5_1 -u 0.028323850676192322 > ./result_8chains/node31_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_6_1 -p 932 -st topic31_6_0 -pt topic31_6_1 -u 0.005935866731460217 > ./result_8chains/node31_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node31_7_1 -p 948 -st topic31_7_0 -pt topic31_7_1 -u 0.00011360099852067733 > ./result_8chains/node31_7_1.txt &
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
    "./result_8chains/node31_0_1.txt 90"
    "./result_8chains/node31_1_1.txt 89"
    "./result_8chains/node31_2_1.txt 88"
    "./result_8chains/node31_3_1.txt 87"
    "./result_8chains/node31_4_1.txt 86"
    "./result_8chains/node31_5_1.txt 85"
    "./result_8chains/node31_6_1.txt 84"
    "./result_8chains/node31_7_1.txt 83"
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
