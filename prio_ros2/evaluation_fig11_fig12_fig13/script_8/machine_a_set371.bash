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
ros2 run evaluation_3_randomdag uunifast_node -n node371_0_2 -p 20 -st topic371_0_1 -pt None -u 0.041199545575709595 > ./result_8chains/node371_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_1_2 -p 30 -st topic371_1_1 -pt None -u 0.0219295356221873 > ./result_8chains/node371_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_2_2 -p 67 -st topic371_2_1 -pt None -u 0.016306005637574783 > ./result_8chains/node371_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_3_2 -p 119 -st topic371_3_1 -pt None -u 0.05259765754654011 > ./result_8chains/node371_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_4_2 -p 312 -st topic371_4_1 -pt None -u 0.030691474434070665 > ./result_8chains/node371_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_5_2 -p 360 -st topic371_5_1 -pt None -u 0.008546255326851243 > ./result_8chains/node371_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_6_2 -p 558 -st topic371_6_1 -pt None -u 0.006948697798166759 > ./result_8chains/node371_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_7_2 -p 952 -st topic371_7_1 -pt None -u 0.0580948167930412 > ./result_8chains/node371_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_0_0 -p 20 -st none -pt topic371_0_0 -u 0.0033072588727025565 > ./result_8chains/node371_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_1_0 -p 30 -st none -pt topic371_1_0 -u 0.0007284219757294763 > ./result_8chains/node371_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_2_0 -p 67 -st none -pt topic371_2_0 -u 0.00719773578884586 > ./result_8chains/node371_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_3_0 -p 119 -st none -pt topic371_3_0 -u 0.0052401359491502375 > ./result_8chains/node371_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_4_0 -p 312 -st none -pt topic371_4_0 -u 0.015861351526073153 > ./result_8chains/node371_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_5_0 -p 360 -st none -pt topic371_5_0 -u 0.011285580303270898 > ./result_8chains/node371_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node371_6_0 -p 558 -st none -pt topic371_6_0 -u 0.0206625279702555 > ./result_8chains/node371_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node371_7_0 -p 952 -st none -pt topic371_7_0 -u 0.005899796465217606 > ./result_8chains/node371_7_0.txt &
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
    "./result_8chains/node371_0_0.txt 90"
    "./result_8chains/node371_0_2.txt 90"
    "./result_8chains/node371_1_0.txt 89"
    "./result_8chains/node371_1_2.txt 89"
    "./result_8chains/node371_2_0.txt 88"
    "./result_8chains/node371_2_2.txt 88"
    "./result_8chains/node371_3_0.txt 87"
    "./result_8chains/node371_3_2.txt 87"
    "./result_8chains/node371_4_0.txt 86"
    "./result_8chains/node371_4_2.txt 86"
    "./result_8chains/node371_5_0.txt 85"
    "./result_8chains/node371_5_2.txt 85"
    "./result_8chains/node371_6_0.txt 84"
    "./result_8chains/node371_6_2.txt 84"
    "./result_8chains/node371_7_0.txt 83"
    "./result_8chains/node371_7_2.txt 83"
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
