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
ros2 run evaluation_3_randomdag uunifast_node -n node17_0_1 -p 61 -st topic17_0_0 -pt topic17_0_1 -u 0.04677328070283826 > ./result_10chains/node17_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_1_1 -p 137 -st topic17_1_0 -pt topic17_1_1 -u 0.0035135477170580853 > ./result_10chains/node17_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_2_1 -p 354 -st topic17_2_0 -pt topic17_2_1 -u 0.0009904300298579916 > ./result_10chains/node17_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_3_1 -p 391 -st topic17_3_0 -pt topic17_3_1 -u 0.005433006780771854 > ./result_10chains/node17_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_4_1 -p 488 -st topic17_4_0 -pt topic17_4_1 -u 0.0026304108793707703 > ./result_10chains/node17_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_5_1 -p 558 -st topic17_5_0 -pt topic17_5_1 -u 0.005488624067988945 > ./result_10chains/node17_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_6_1 -p 607 -st topic17_6_0 -pt topic17_6_1 -u 0.004810692428761115 > ./result_10chains/node17_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_7_1 -p 691 -st topic17_7_0 -pt topic17_7_1 -u 0.045265776376855554 > ./result_10chains/node17_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_8_1 -p 704 -st topic17_8_0 -pt topic17_8_1 -u 0.00982953424479556 > ./result_10chains/node17_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_9_1 -p 877 -st topic17_9_0 -pt topic17_9_1 -u 0.003816193020134138 > ./result_10chains/node17_9_1.txt &
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
    "./result_10chains/node17_0_1.txt 90"
    "./result_10chains/node17_1_1.txt 89"
    "./result_10chains/node17_2_1.txt 88"
    "./result_10chains/node17_3_1.txt 87"
    "./result_10chains/node17_4_1.txt 86"
    "./result_10chains/node17_5_1.txt 85"
    "./result_10chains/node17_6_1.txt 84"
    "./result_10chains/node17_7_1.txt 83"
    "./result_10chains/node17_8_1.txt 82"
    "./result_10chains/node17_9_1.txt 81"
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
