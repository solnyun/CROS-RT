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
ros2 run evaluation_3_randomdag uunifast_node -n node160_0_2 -p 48 -st topic160_0_1 -pt None -u 0.006308328253533502 > ./result_6chains/node160_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_1_2 -p 559 -st topic160_1_1 -pt None -u 0.056712423192597505 > ./result_6chains/node160_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_2_2 -p 572 -st topic160_2_1 -pt None -u 0.020447560260120734 > ./result_6chains/node160_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_3_2 -p 621 -st topic160_3_1 -pt None -u 0.012356957778511063 > ./result_6chains/node160_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_4_2 -p 730 -st topic160_4_1 -pt None -u 0.017763788087211574 > ./result_6chains/node160_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_5_2 -p 767 -st topic160_5_1 -pt None -u 0.009444902446895373 > ./result_6chains/node160_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_0_0 -p 48 -st none -pt topic160_0_0 -u 0.0528960310950059 > ./result_6chains/node160_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_1_0 -p 559 -st none -pt topic160_1_0 -u 0.0028547573148962058 > ./result_6chains/node160_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_2_0 -p 572 -st none -pt topic160_2_0 -u 0.03669694927935141 > ./result_6chains/node160_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_3_0 -p 621 -st none -pt topic160_3_0 -u 0.02976955356993613 > ./result_6chains/node160_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node160_4_0 -p 730 -st none -pt topic160_4_0 -u 0.018031425564419168 > ./result_6chains/node160_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node160_5_0 -p 767 -st none -pt topic160_5_0 -u 0.00455986348484845 > ./result_6chains/node160_5_0.txt &
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
    "./result_6chains/node160_0_0.txt 90"
    "./result_6chains/node160_0_2.txt 90"
    "./result_6chains/node160_1_0.txt 89"
    "./result_6chains/node160_1_2.txt 89"
    "./result_6chains/node160_2_0.txt 88"
    "./result_6chains/node160_2_2.txt 88"
    "./result_6chains/node160_3_0.txt 87"
    "./result_6chains/node160_3_2.txt 87"
    "./result_6chains/node160_4_0.txt 86"
    "./result_6chains/node160_4_2.txt 86"
    "./result_6chains/node160_5_0.txt 85"
    "./result_6chains/node160_5_2.txt 85"
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
