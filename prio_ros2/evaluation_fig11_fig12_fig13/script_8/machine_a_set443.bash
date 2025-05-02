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
ros2 run evaluation_3_randomdag uunifast_node -n node443_0_2 -p 72 -st topic443_0_1 -pt None -u 0.0004866785534006768 > ./result_8chains/node443_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_1_2 -p 110 -st topic443_1_1 -pt None -u 0.015189870119498072 > ./result_8chains/node443_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_2_2 -p 155 -st topic443_2_1 -pt None -u 0.005500894651782162 > ./result_8chains/node443_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_3_2 -p 527 -st topic443_3_1 -pt None -u 0.0019203328507957362 > ./result_8chains/node443_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_4_2 -p 601 -st topic443_4_1 -pt None -u 0.01989460064460921 > ./result_8chains/node443_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_5_2 -p 759 -st topic443_5_1 -pt None -u 0.011648980045812024 > ./result_8chains/node443_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_6_2 -p 775 -st topic443_6_1 -pt None -u 0.041473485417403755 > ./result_8chains/node443_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_7_2 -p 841 -st topic443_7_1 -pt None -u 0.0030233354658474893 > ./result_8chains/node443_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_0_0 -p 72 -st none -pt topic443_0_0 -u 0.02034541615128016 > ./result_8chains/node443_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_1_0 -p 110 -st none -pt topic443_1_0 -u 0.08225210078410511 > ./result_8chains/node443_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_2_0 -p 155 -st none -pt topic443_2_0 -u 0.021821349322688532 > ./result_8chains/node443_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_3_0 -p 527 -st none -pt topic443_3_0 -u 0.004112614298451445 > ./result_8chains/node443_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_4_0 -p 601 -st none -pt topic443_4_0 -u 0.03090040546961048 > ./result_8chains/node443_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_5_0 -p 759 -st none -pt topic443_5_0 -u 0.01539341043719658 > ./result_8chains/node443_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node443_6_0 -p 775 -st none -pt topic443_6_0 -u 0.03731730731998595 > ./result_8chains/node443_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node443_7_0 -p 841 -st none -pt topic443_7_0 -u 0.029658293981874057 > ./result_8chains/node443_7_0.txt &
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
    "./result_8chains/node443_0_0.txt 90"
    "./result_8chains/node443_0_2.txt 90"
    "./result_8chains/node443_1_0.txt 89"
    "./result_8chains/node443_1_2.txt 89"
    "./result_8chains/node443_2_0.txt 88"
    "./result_8chains/node443_2_2.txt 88"
    "./result_8chains/node443_3_0.txt 87"
    "./result_8chains/node443_3_2.txt 87"
    "./result_8chains/node443_4_0.txt 86"
    "./result_8chains/node443_4_2.txt 86"
    "./result_8chains/node443_5_0.txt 85"
    "./result_8chains/node443_5_2.txt 85"
    "./result_8chains/node443_6_0.txt 84"
    "./result_8chains/node443_6_2.txt 84"
    "./result_8chains/node443_7_0.txt 83"
    "./result_8chains/node443_7_2.txt 83"
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
