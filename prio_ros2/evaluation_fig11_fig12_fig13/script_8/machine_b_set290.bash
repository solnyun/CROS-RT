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
ros2 run evaluation_3_randomdag uunifast_node -n node290_0_1 -p 296 -st topic290_0_0 -pt topic290_0_1 -u 0.013885995374398608 > ./result_8chains/node290_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_1_1 -p 378 -st topic290_1_0 -pt topic290_1_1 -u 0.06477861889022096 > ./result_8chains/node290_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_2_1 -p 454 -st topic290_2_0 -pt topic290_2_1 -u 0.04125019437463656 > ./result_8chains/node290_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_3_1 -p 664 -st topic290_3_0 -pt topic290_3_1 -u 0.040672352998210065 > ./result_8chains/node290_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_4_1 -p 754 -st topic290_4_0 -pt topic290_4_1 -u 0.03486514629406015 > ./result_8chains/node290_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_5_1 -p 913 -st topic290_5_0 -pt topic290_5_1 -u 0.01658193633849782 > ./result_8chains/node290_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_6_1 -p 977 -st topic290_6_0 -pt topic290_6_1 -u 0.01334708730330307 > ./result_8chains/node290_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_7_1 -p 980 -st topic290_7_0 -pt topic290_7_1 -u 0.01769175604620482 > ./result_8chains/node290_7_1.txt &
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
    "./result_8chains/node290_0_1.txt 90"
    "./result_8chains/node290_1_1.txt 89"
    "./result_8chains/node290_2_1.txt 88"
    "./result_8chains/node290_3_1.txt 87"
    "./result_8chains/node290_4_1.txt 86"
    "./result_8chains/node290_5_1.txt 85"
    "./result_8chains/node290_6_1.txt 84"
    "./result_8chains/node290_7_1.txt 83"
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
