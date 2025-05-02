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
ros2 run evaluation_3_randomdag uunifast_node -n node446_0_2 -p 170 -st topic446_0_1 -pt None -u 0.06315601734599852 > ./result_8chains/node446_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_1_2 -p 183 -st topic446_1_1 -pt None -u 0.0060675330338217925 > ./result_8chains/node446_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_2_2 -p 280 -st topic446_2_1 -pt None -u 0.005963748861623375 > ./result_8chains/node446_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_3_2 -p 370 -st topic446_3_1 -pt None -u 0.01536851851168658 > ./result_8chains/node446_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_4_2 -p 710 -st topic446_4_1 -pt None -u 0.01728266709537185 > ./result_8chains/node446_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_5_2 -p 716 -st topic446_5_1 -pt None -u 0.015864318718136067 > ./result_8chains/node446_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_6_2 -p 827 -st topic446_6_1 -pt None -u 0.014211496220279299 > ./result_8chains/node446_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_7_2 -p 979 -st topic446_7_1 -pt None -u 0.002393486856994298 > ./result_8chains/node446_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_0_0 -p 170 -st none -pt topic446_0_0 -u 0.02193796869303044 > ./result_8chains/node446_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_1_0 -p 183 -st none -pt topic446_1_0 -u 0.04308350624295754 > ./result_8chains/node446_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_2_0 -p 280 -st none -pt topic446_2_0 -u 0.024830626248454057 > ./result_8chains/node446_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_3_0 -p 370 -st none -pt topic446_3_0 -u 0.023790093852860267 > ./result_8chains/node446_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_4_0 -p 710 -st none -pt topic446_4_0 -u 0.026829630443907238 > ./result_8chains/node446_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_5_0 -p 716 -st none -pt topic446_5_0 -u 0.024391477800577877 > ./result_8chains/node446_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_6_0 -p 827 -st none -pt topic446_6_0 -u 0.01651233650520874 > ./result_8chains/node446_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_7_0 -p 979 -st none -pt topic446_7_0 -u 0.0380515990132267 > ./result_8chains/node446_7_0.txt &
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
    "./result_8chains/node446_0_0.txt 90"
    "./result_8chains/node446_0_2.txt 90"
    "./result_8chains/node446_1_0.txt 89"
    "./result_8chains/node446_1_2.txt 89"
    "./result_8chains/node446_2_0.txt 88"
    "./result_8chains/node446_2_2.txt 88"
    "./result_8chains/node446_3_0.txt 87"
    "./result_8chains/node446_3_2.txt 87"
    "./result_8chains/node446_4_0.txt 86"
    "./result_8chains/node446_4_2.txt 86"
    "./result_8chains/node446_5_0.txt 85"
    "./result_8chains/node446_5_2.txt 85"
    "./result_8chains/node446_6_0.txt 84"
    "./result_8chains/node446_6_2.txt 84"
    "./result_8chains/node446_7_0.txt 83"
    "./result_8chains/node446_7_2.txt 83"
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
