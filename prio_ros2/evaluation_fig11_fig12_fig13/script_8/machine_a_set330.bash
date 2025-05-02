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
ros2 run evaluation_3_randomdag uunifast_node -n node330_0_2 -p 148 -st topic330_0_1 -pt None -u 0.0036129761658725834 > ./result_8chains/node330_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_1_2 -p 201 -st topic330_1_1 -pt None -u 0.01780320687900122 > ./result_8chains/node330_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_2_2 -p 217 -st topic330_2_1 -pt None -u 0.00922904563445115 > ./result_8chains/node330_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_3_2 -p 342 -st topic330_3_1 -pt None -u 0.010135830123938205 > ./result_8chains/node330_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_4_2 -p 500 -st topic330_4_1 -pt None -u 0.03506260339013437 > ./result_8chains/node330_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_5_2 -p 725 -st topic330_5_1 -pt None -u 0.004918414812810329 > ./result_8chains/node330_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_6_2 -p 803 -st topic330_6_1 -pt None -u 0.010116263489688429 > ./result_8chains/node330_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_7_2 -p 914 -st topic330_7_1 -pt None -u 0.0022606550538035123 > ./result_8chains/node330_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_0_0 -p 148 -st none -pt topic330_0_0 -u 0.009113477257748748 > ./result_8chains/node330_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_1_0 -p 201 -st none -pt topic330_1_0 -u 0.000919196171669745 > ./result_8chains/node330_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_2_0 -p 217 -st none -pt topic330_2_0 -u 0.013007747094270938 > ./result_8chains/node330_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_3_0 -p 342 -st none -pt topic330_3_0 -u 0.025527749139191702 > ./result_8chains/node330_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_4_0 -p 500 -st none -pt topic330_4_0 -u 0.07852219345671274 > ./result_8chains/node330_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_5_0 -p 725 -st none -pt topic330_5_0 -u 0.06940629404561055 > ./result_8chains/node330_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node330_6_0 -p 803 -st none -pt topic330_6_0 -u 0.026451419321900926 > ./result_8chains/node330_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node330_7_0 -p 914 -st none -pt topic330_7_0 -u 0.007082322134184717 > ./result_8chains/node330_7_0.txt &
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
    "./result_8chains/node330_0_0.txt 90"
    "./result_8chains/node330_0_2.txt 90"
    "./result_8chains/node330_1_0.txt 89"
    "./result_8chains/node330_1_2.txt 89"
    "./result_8chains/node330_2_0.txt 88"
    "./result_8chains/node330_2_2.txt 88"
    "./result_8chains/node330_3_0.txt 87"
    "./result_8chains/node330_3_2.txt 87"
    "./result_8chains/node330_4_0.txt 86"
    "./result_8chains/node330_4_2.txt 86"
    "./result_8chains/node330_5_0.txt 85"
    "./result_8chains/node330_5_2.txt 85"
    "./result_8chains/node330_6_0.txt 84"
    "./result_8chains/node330_6_2.txt 84"
    "./result_8chains/node330_7_0.txt 83"
    "./result_8chains/node330_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
