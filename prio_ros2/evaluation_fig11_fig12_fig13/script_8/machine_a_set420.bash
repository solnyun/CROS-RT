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
ros2 run evaluation_3_randomdag uunifast_node -n node420_0_2 -p 54 -st topic420_0_1 -pt None -u 0.01426943050984475 > ./result_8chains/node420_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_1_2 -p 191 -st topic420_1_1 -pt None -u 0.008706162905217252 > ./result_8chains/node420_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_2_2 -p 212 -st topic420_2_1 -pt None -u 0.017371324985749226 > ./result_8chains/node420_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_3_2 -p 308 -st topic420_3_1 -pt None -u 0.030185674124280942 > ./result_8chains/node420_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_4_2 -p 322 -st topic420_4_1 -pt None -u 0.0024097850361826656 > ./result_8chains/node420_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_5_2 -p 488 -st topic420_5_1 -pt None -u 0.00613966198559926 > ./result_8chains/node420_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_6_2 -p 542 -st topic420_6_1 -pt None -u 0.0023930732144441177 > ./result_8chains/node420_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_7_2 -p 798 -st topic420_7_1 -pt None -u 0.006840660833786505 > ./result_8chains/node420_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_0_0 -p 54 -st none -pt topic420_0_0 -u 0.016013405120158364 > ./result_8chains/node420_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_1_0 -p 191 -st none -pt topic420_1_0 -u 0.04161056094380322 > ./result_8chains/node420_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_2_0 -p 212 -st none -pt topic420_2_0 -u 0.01060010851901022 > ./result_8chains/node420_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_3_0 -p 308 -st none -pt topic420_3_0 -u 0.03343236284722717 > ./result_8chains/node420_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_4_0 -p 322 -st none -pt topic420_4_0 -u 0.018524804866158734 > ./result_8chains/node420_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_5_0 -p 488 -st none -pt topic420_5_0 -u 0.05451368455029022 > ./result_8chains/node420_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node420_6_0 -p 542 -st none -pt topic420_6_0 -u 0.0024570264980903894 > ./result_8chains/node420_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node420_7_0 -p 798 -st none -pt topic420_7_0 -u 0.02422972463014339 > ./result_8chains/node420_7_0.txt &
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
    "./result_8chains/node420_0_0.txt 90"
    "./result_8chains/node420_0_2.txt 90"
    "./result_8chains/node420_1_0.txt 89"
    "./result_8chains/node420_1_2.txt 89"
    "./result_8chains/node420_2_0.txt 88"
    "./result_8chains/node420_2_2.txt 88"
    "./result_8chains/node420_3_0.txt 87"
    "./result_8chains/node420_3_2.txt 87"
    "./result_8chains/node420_4_0.txt 86"
    "./result_8chains/node420_4_2.txt 86"
    "./result_8chains/node420_5_0.txt 85"
    "./result_8chains/node420_5_2.txt 85"
    "./result_8chains/node420_6_0.txt 84"
    "./result_8chains/node420_6_2.txt 84"
    "./result_8chains/node420_7_0.txt 83"
    "./result_8chains/node420_7_2.txt 83"
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
