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
ros2 run evaluation_3_randomdag uunifast_node -n node316_0_2 -p 11 -st topic316_0_1 -pt None -u 0.042249642850501756 > ./result_6chains/node316_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_1_2 -p 50 -st topic316_1_1 -pt None -u 0.028596105180145825 > ./result_6chains/node316_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_2_2 -p 139 -st topic316_2_1 -pt None -u 0.02935230268823763 > ./result_6chains/node316_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_3_2 -p 246 -st topic316_3_1 -pt None -u 0.0037056575764979616 > ./result_6chains/node316_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_4_2 -p 385 -st topic316_4_1 -pt None -u 0.020435298005402003 > ./result_6chains/node316_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_5_2 -p 887 -st topic316_5_1 -pt None -u 0.0755697887237009 > ./result_6chains/node316_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_0_0 -p 11 -st none -pt topic316_0_0 -u 0.002604255800618238 > ./result_6chains/node316_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_1_0 -p 50 -st none -pt topic316_1_0 -u 0.001236582440669487 > ./result_6chains/node316_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_2_0 -p 139 -st none -pt topic316_2_0 -u 0.004282069302570524 > ./result_6chains/node316_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_3_0 -p 246 -st none -pt topic316_3_0 -u 0.053044791902619653 > ./result_6chains/node316_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node316_4_0 -p 385 -st none -pt topic316_4_0 -u 0.0021841658226715854 > ./result_6chains/node316_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node316_5_0 -p 887 -st none -pt topic316_5_0 -u 0.02681500310633357 > ./result_6chains/node316_5_0.txt &
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
    "./result_6chains/node316_0_0.txt 90"
    "./result_6chains/node316_0_2.txt 90"
    "./result_6chains/node316_1_0.txt 89"
    "./result_6chains/node316_1_2.txt 89"
    "./result_6chains/node316_2_0.txt 88"
    "./result_6chains/node316_2_2.txt 88"
    "./result_6chains/node316_3_0.txt 87"
    "./result_6chains/node316_3_2.txt 87"
    "./result_6chains/node316_4_0.txt 86"
    "./result_6chains/node316_4_2.txt 86"
    "./result_6chains/node316_5_0.txt 85"
    "./result_6chains/node316_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
