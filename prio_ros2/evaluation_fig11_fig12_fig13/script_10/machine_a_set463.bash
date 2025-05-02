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
ros2 run evaluation_3_randomdag uunifast_node -n node463_0_2 -p 28 -st topic463_0_1 -pt None -u 0.010693350211072872 > ./result_10chains/node463_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_1_2 -p 207 -st topic463_1_1 -pt None -u 0.028779763882350373 > ./result_10chains/node463_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_2_2 -p 412 -st topic463_2_1 -pt None -u 0.007026565141078189 > ./result_10chains/node463_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_3_2 -p 630 -st topic463_3_1 -pt None -u 0.011537581457346457 > ./result_10chains/node463_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_4_2 -p 681 -st topic463_4_1 -pt None -u 0.04341570971958081 > ./result_10chains/node463_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_5_2 -p 684 -st topic463_5_1 -pt None -u 0.003332622667502838 > ./result_10chains/node463_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_6_2 -p 710 -st topic463_6_1 -pt None -u 0.011151763631283673 > ./result_10chains/node463_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_7_2 -p 727 -st topic463_7_1 -pt None -u 0.0032079310859762372 > ./result_10chains/node463_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_8_2 -p 831 -st topic463_8_1 -pt None -u 0.019628575785086512 > ./result_10chains/node463_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_9_2 -p 920 -st topic463_9_1 -pt None -u 0.02685220602524034 > ./result_10chains/node463_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_0_0 -p 28 -st none -pt topic463_0_0 -u 0.05122131312899686 > ./result_10chains/node463_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_1_0 -p 207 -st none -pt topic463_1_0 -u 0.00016567273534162652 > ./result_10chains/node463_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_2_0 -p 412 -st none -pt topic463_2_0 -u 0.004957062578250793 > ./result_10chains/node463_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_3_0 -p 630 -st none -pt topic463_3_0 -u 0.034306978723478376 > ./result_10chains/node463_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_4_0 -p 681 -st none -pt topic463_4_0 -u 0.010465219030200201 > ./result_10chains/node463_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_5_0 -p 684 -st none -pt topic463_5_0 -u 0.014485331317027117 > ./result_10chains/node463_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_6_0 -p 710 -st none -pt topic463_6_0 -u 0.014299879743710747 > ./result_10chains/node463_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_7_0 -p 727 -st none -pt topic463_7_0 -u 0.003478684150600375 > ./result_10chains/node463_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node463_8_0 -p 831 -st none -pt topic463_8_0 -u 0.017300739504379464 > ./result_10chains/node463_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node463_9_0 -p 920 -st none -pt topic463_9_0 -u 0.001576214779427855 > ./result_10chains/node463_9_0.txt &
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
    "./result_10chains/node463_0_0.txt 90"
    "./result_10chains/node463_0_2.txt 90"
    "./result_10chains/node463_1_0.txt 89"
    "./result_10chains/node463_1_2.txt 89"
    "./result_10chains/node463_2_0.txt 88"
    "./result_10chains/node463_2_2.txt 88"
    "./result_10chains/node463_3_0.txt 87"
    "./result_10chains/node463_3_2.txt 87"
    "./result_10chains/node463_4_0.txt 86"
    "./result_10chains/node463_4_2.txt 86"
    "./result_10chains/node463_5_0.txt 85"
    "./result_10chains/node463_5_2.txt 85"
    "./result_10chains/node463_6_0.txt 84"
    "./result_10chains/node463_6_2.txt 84"
    "./result_10chains/node463_7_0.txt 83"
    "./result_10chains/node463_7_2.txt 83"
    "./result_10chains/node463_8_0.txt 82"
    "./result_10chains/node463_8_2.txt 82"
    "./result_10chains/node463_9_0.txt 81"
    "./result_10chains/node463_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
