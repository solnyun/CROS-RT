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
ros2 run evaluation_3_randomdag uunifast_node -n node362_0_1 -p 175 -st topic362_0_0 -pt topic362_0_1 -u 0.01681781752085587 > ./result_8chains/node362_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_1_1 -p 217 -st topic362_1_0 -pt topic362_1_1 -u 0.006175788520740855 > ./result_8chains/node362_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_2_1 -p 224 -st topic362_2_0 -pt topic362_2_1 -u 0.014437818691963533 > ./result_8chains/node362_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_3_1 -p 355 -st topic362_3_0 -pt topic362_3_1 -u 0.0057735576836452085 > ./result_8chains/node362_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_4_1 -p 359 -st topic362_4_0 -pt topic362_4_1 -u 0.00015437067277707106 > ./result_8chains/node362_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_5_1 -p 362 -st topic362_5_0 -pt topic362_5_1 -u 0.009838111273718142 > ./result_8chains/node362_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_6_1 -p 511 -st topic362_6_0 -pt topic362_6_1 -u 0.07067348685478922 > ./result_8chains/node362_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_7_1 -p 844 -st topic362_7_0 -pt topic362_7_1 -u 0.008046742640714992 > ./result_8chains/node362_7_1.txt &
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
    "./result_8chains/node362_0_1.txt 90"
    "./result_8chains/node362_1_1.txt 89"
    "./result_8chains/node362_2_1.txt 88"
    "./result_8chains/node362_3_1.txt 87"
    "./result_8chains/node362_4_1.txt 86"
    "./result_8chains/node362_5_1.txt 85"
    "./result_8chains/node362_6_1.txt 84"
    "./result_8chains/node362_7_1.txt 83"
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
