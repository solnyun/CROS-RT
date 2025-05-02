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
ros2 run evaluation_3_randomdag uunifast_node -n node295_0_2 -p 476 -st topic295_0_1 -pt None -u 0.0690158989366052 > ./result_8chains/node295_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_1_2 -p 505 -st topic295_1_1 -pt None -u 0.006013347634033384 > ./result_8chains/node295_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_2_2 -p 578 -st topic295_2_1 -pt None -u 0.0026358988879646716 > ./result_8chains/node295_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_3_2 -p 627 -st topic295_3_1 -pt None -u 0.0021461676551173814 > ./result_8chains/node295_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_4_2 -p 677 -st topic295_4_1 -pt None -u 0.03324961480645877 > ./result_8chains/node295_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_5_2 -p 735 -st topic295_5_1 -pt None -u 0.0012286010161367544 > ./result_8chains/node295_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_6_2 -p 866 -st topic295_6_1 -pt None -u 0.03241842783595608 > ./result_8chains/node295_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_7_2 -p 949 -st topic295_7_1 -pt None -u 0.05547639660060884 > ./result_8chains/node295_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_0_0 -p 476 -st none -pt topic295_0_0 -u 0.010293373210575885 > ./result_8chains/node295_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_1_0 -p 505 -st none -pt topic295_1_0 -u 0.006756240657514678 > ./result_8chains/node295_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_2_0 -p 578 -st none -pt topic295_2_0 -u 0.00384755200895609 > ./result_8chains/node295_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_3_0 -p 627 -st none -pt topic295_3_0 -u 0.021094857016055235 > ./result_8chains/node295_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_4_0 -p 677 -st none -pt topic295_4_0 -u 0.011646821273343766 > ./result_8chains/node295_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_5_0 -p 735 -st none -pt topic295_5_0 -u 0.000642136170731028 > ./result_8chains/node295_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node295_6_0 -p 866 -st none -pt topic295_6_0 -u 0.002601315673611382 > ./result_8chains/node295_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node295_7_0 -p 949 -st none -pt topic295_7_0 -u 0.03672207310877473 > ./result_8chains/node295_7_0.txt &
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
    "./result_8chains/node295_0_0.txt 90"
    "./result_8chains/node295_0_2.txt 90"
    "./result_8chains/node295_1_0.txt 89"
    "./result_8chains/node295_1_2.txt 89"
    "./result_8chains/node295_2_0.txt 88"
    "./result_8chains/node295_2_2.txt 88"
    "./result_8chains/node295_3_0.txt 87"
    "./result_8chains/node295_3_2.txt 87"
    "./result_8chains/node295_4_0.txt 86"
    "./result_8chains/node295_4_2.txt 86"
    "./result_8chains/node295_5_0.txt 85"
    "./result_8chains/node295_5_2.txt 85"
    "./result_8chains/node295_6_0.txt 84"
    "./result_8chains/node295_6_2.txt 84"
    "./result_8chains/node295_7_0.txt 83"
    "./result_8chains/node295_7_2.txt 83"
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
